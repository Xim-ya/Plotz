import 'dart:isolate';

class ReceivePortHandler {
  ReceivePortHandler._();

  static ReceivePort receivePort = ReceivePort();
}