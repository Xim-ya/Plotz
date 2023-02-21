import 'dart:isolate';
import 'package:soon_sak/utilities/index.dart';

mixin FirebaseIsolateHelper {
  Future<T> loadWithFirebaseIsolate<T>(Future<T> Function() function) async {
    // 1. Isolate로부터 수신할 데이터를 위한 ReceivePort 생성
    final ReceivePort receivePort = ReceivePort();

    // 2. Root isolate의 BinaryMessenger를 가져오기 위한 RootIsolateToken 생성
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    // 3 백그라운드 isolate에서 실행할 함수를 전달하며 새로운 isolate 생성
   final isolate =  await Isolate.spawn(
        _isolateEntry,
        _IsolateEntryPayload(
          function: function,
          sendPort: receivePort.sendPort,
          rootIsolateToken: rootIsolateToken,
        ));

    // 7. 백그라운드 isolate로부터 데이터를 수신하고 리턴.
    return receivePort.first.then(
      (dynamic data) {
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
}

// 6. 백그라운드 isolate에서 실행될 함수 (entry)
void _isolateEntry(_IsolateEntryPayload payload) async {
  final Function function = payload.function;

  // 중요!! Isolate Background 스레드를 초기화 (3.7 버전)
  // 출처 : https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8
  // BackgroundIsolateBinaryMessenger.ensureInitialized(payload.rootIsolateToken);

  try {
    BackgroundIsolateBinaryMessenger.ensureInitialized(
        payload.rootIsolateToken);
  } on MissingPluginException catch (e) {
    print(e.toString());
    return Future.error(e.toString());
  }
  await Firebase.initializeApp();
  /// 중요!! FireBaseStore을 이용하고 있기 때문에
  /// Firebase sdk를 initialize 해줘야함
  /// 별도의 스레드에서 실행되기 때문에
  /// [main.dart]에서 생성되는 것과는 무관함.


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
