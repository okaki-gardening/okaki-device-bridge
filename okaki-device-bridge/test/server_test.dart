import 'dart:io';

import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  final port = '8079';
  final host = 'http://127.0.0.1:$port';
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('Root', () async {
    final response = await get(Uri.parse('$host/'));
    expect(response.statusCode, 200);
    expect(response.body, 'okaki device bridge\n');
  });

  test('post two measurements', () async {
    final response = await post(Uri.parse('$host/measurements'),
        body:
            '{"deviceID":"device1", "key":"my-secret", "measurements":[{"sensorID":"sensor1","sensorTypeID":"float","value":"12.34"},{"sensorID":"sensor1","sensorTypeID":"float","value":"56.78"}]}');
    expect(response.statusCode, 200);
    expect(response.body, '2 measurements added.');
  });

  test('wrong syntax', () async {
    final response = await post(Uri.parse('$host/measurements'),
        body:
            '{"deviceID":"device1", "measurements":[{"sensorID":"sensor1","sensorTypeID":"float","value":"12.34"},{"sensorID":"sensor1","sensorTypeID":"float","value":"56.78"}]}');
    expect(response.statusCode, 500);
  });

  test('wrong credentials', () async {
    final response = await post(Uri.parse('$host/measurements'),
        body:
            '{"deviceID":"device1", "key":"WRONG!!!", "measurements":[{"sensorID":"sensor1","sensorTypeID":"float","value":"12.34"},{"sensorID":"sensor1","sensorTypeID":"float","value":"56.78"}]}');
    expect(response.statusCode, 500);
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });
}
