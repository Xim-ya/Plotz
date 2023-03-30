import 'dart:collection';
import 'dart:isolate';
import 'package:soon_sak/utilities/index.dart';

mixin FirebaseIsolateHelper {
  // 동시에 실행할 수 있는 Isolate의 최대 개수
  static const int _maxIsolates = 5;
  // 현재 실행 중인 Isolate의 수
  int _currentIsolates = 0;
  // 작업 큐
  final Queue<Function> _taskQueue = Queue();

  // 작업을 큐에 추가하고 실행
  Future<T> loadWithFirebaseIsolate<T>(Future<T> Function() function) async {
    if (_currentIsolates < _maxIsolates) {
      _currentIsolates++;
      return _executeIsolate(function);
    } else {
      final completer = Completer<T>();
      _taskQueue.add(() async {
        final result = await _executeIsolate(function);
        completer.complete(result);
      });
      return completer.future;
    }
  }

  // 실제 Isolate 실행 로직
  Future<T> _executeIsolate<T>(Future<T> Function() function) async {
    final ReceivePort receivePort = ReceivePort();
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    final isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateEntryPayload(
        function: function,
        sendPort: receivePort.sendPort,
        rootIsolateToken: rootIsolateToken,
      ),
    );

    return receivePort.first.then(
          (dynamic data) {
        _currentIsolates--;
        _runNextTask();
        if (data is T) {
          isolate.kill(priority: Isolate.immediate);
          return data;
        } else {
          isolate.kill(priority: Isolate.immediate);
          throw data;
        }
      },
    );
  }

  // 작업 큐에서 다음 작업을 실행
  void _runNextTask() {
    if (_taskQueue.isNotEmpty) {
      final nextTask = _taskQueue.removeFirst();
      nextTask();
    }
  }
}

// 6. 백그라운드 isolate에서 실행될 함수 (entry)
void _isolateEntry(_IsolateEntryPayload payload) async {
  final Function function = payload.function;

  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        payload.rootIsolateToken);
  } on MissingPluginException catch (e) {
    print(e.toString());
    return Future.error(e.toString());
  }
  await Firebase.initializeApp();

  final result = await function();
  payload.sendPort.send(result);
}

// Isolate Entry 모델
class _IsolateEntryPayload {
  const _IsolateEntryPayload({
    required this.function,
    required this.sendPort,
    required this.rootIsolateToken,
  });

  final Future<dynamic> Function() function;
  final SendPort sendPort;
  final RootIsolateToken rootIsolateToken;
}