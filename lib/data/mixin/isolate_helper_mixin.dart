import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

mixin IsolateHelperMixin {
  // 동시에 처리할 Isolate의 최대 개수
  final int _maxIsolates = 5;

  // 현재 실행 중인 Isolate의 수
  int _currentIsolates = 0;

  // 대기중인 작업을 저장하는 큐
  final Queue<Function> _taskQueue = Queue();

  // 작업을 Isolate와 함께 실행하고 결과를 반환하는 메서드
  Future<T> loadWithIsolate<T>(Future<T> Function() function) async {
    // 현재 실행 중인 Isolate 수가 최대치 미만일 경우, 새 Isolate를 생성하고 실행
    if (_currentIsolates < _maxIsolates) {
      _currentIsolates++;
      return _executeIsolate(function);
    } else {
      // 최대치에 도달한 경우, 작업을 큐에 저장
      final completer = Completer<T>();
      _taskQueue.add(() async {
        final result = await _executeIsolate(function);
        completer.complete(result);
      });
      return completer.future;
    }
  }

  // Isolate를 생성하고 실행하는 메서드
  Future<T> _executeIsolate<T>(Future<T> Function() function) async {
    // Isolate 간 통신을 위한 ReceivePort 생성
    final ReceivePort receivePort = ReceivePort();

    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    // 새 Isolate를 생성하고, function과 통신용 ReceivePort를 전달
    final isolate = await Isolate.spawn(
      _isolateEntry,
      _IsolateEntryPayload(
        function: function,
        sendPort: receivePort.sendPort,
        rootIsolateToken: rootIsolateToken,
      ),
    );

    // Isolate 생성 후, 큐의 다음 작업을 실행
    _runNextTask();

    // Isolate가 작업을 완료하면, 그 결과를 반환하고 Isolate를 종료
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

  // 큐에서 다음 작업을 가져와 실행하는 메서드
  void _runNextTask() {
    if (_currentIsolates < _maxIsolates && _taskQueue.isNotEmpty) {
      final nextTask = _taskQueue.removeFirst();
      nextTask();
    }
  }
}

// Isolate에서 실행될 함수. 이 함수에서는 사용자의 함수를 실행하고, 그 결과를 메인 Isolate로 전달
Future<void> _isolateEntry(_IsolateEntryPayload payload) async {
  final Function function = payload.function;

  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
      payload.rootIsolateToken,
    );
  } on MissingPluginException catch (e) {
    payload.sendPort.send(e);
    return;
  }

  // 사용자의 함수를 실행하고, 그 결과를 메인 Isolate로 전달. 에러 발생 시, 에러를 전달
  try {
    final result = await function();
    payload.sendPort.send(result);
  } catch (e) {
    payload.sendPort.send(e);
  }
}

// Isolate를 생성할 때 필요한 데이터를 담는 클래스
class _IsolateEntryPayload {
  const _IsolateEntryPayload({
    required this.function,
    required this.sendPort,
    required this.rootIsolateToken,
  });

  // Isolate에서 실행할 사용자의 함수
  final Future<dynamic> Function() function;

  // 결과를 전달할 메인 Isolate의 SendPort
  final SendPort sendPort;

  // Isolate Token
  final RootIsolateToken rootIsolateToken;
}
