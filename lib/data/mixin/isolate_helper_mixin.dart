// import 'dart:developer';
// import 'dart:isolate';
// import 'package:soon_sak/utilities/index.dart';
//
//
// mixin IsolateHelperMixin {
//   Future<T> loadWithIsolate<T>(Future<T> Function() function) async {
//     // 1. Isolate로부터 수신할 데이터를 위한 ReceivePort 생성
//     final ReceivePort receivePort = ReceivePort();
//
//     // 2. 백그라운드 isolate에서 실행할 함수를 전달하며 새로운 isolate 생성
//     final _isolate = await Isolate.spawn(
//         _isolateEntry,
//         _IsolateEntryPayload(
//           function: function,
//           sendPort: receivePort.sendPort,
//         ));
//
//     // 3. 백그라운드 isolate로부터 데이터를 수신하고 리턴.
//     return receivePort.first.then(
//           (dynamic data) {
//         if (data is T) {
//           _isolate.kill(priority: Isolate.immediate);
//           return data;
//         } else {
//           throw data;
//         }
//       },
//     );
//   }
// }
//
// // 4. 백그라운드 isolate에서 실행될 함수 (entry)
// void _isolateEntry(_IsolateEntryPayload payload) async {
//   final Function function = payload.function;
//
//   final result = await function();
//   payload.sendPort.send(result);
//
// }
//
// // Isolate Entry 모델
// class _IsolateEntryPayload {
//   const _IsolateEntryPayload({
//     required this.function,
//     required this.sendPort,
//   });
//
//   final Future<dynamic> Function() function;
//   final SendPort sendPort;
// }