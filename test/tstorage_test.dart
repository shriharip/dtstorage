import 'package:flutter_test/flutter_test.dart';

import 'package:tstorage/tstorage.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

Storage s;

  const channel = MethodChannel('plugins.flutter.io/path_provider');
  void setUpMockChannels(MethodChannel channel) {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return '.';
      }
    });
  }

  setUpAll(() async {
    setUpMockChannels(channel);
  });

  setUp(() async {
    s = Storage();
  });

  test('write, read listen', () async {
     s.write('test', 'a');
    final val = await s.val.stream.first;
    expect('a', val);
  });

}

