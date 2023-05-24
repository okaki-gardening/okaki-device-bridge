import 'dart:convert';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'measurement_model.dart';
import 'message_model.dart';

import 'package:dotenv/dotenv.dart';

final appwrite.Client client = appwrite.Client();
final appwrite.Databases databases = appwrite.Databases(client);

String? dbName;

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/measurements', _measurementsHandler);

Future<Response> _rootHandler(Request req) async {
  return Response.ok('okaki device bridge\n');
}

Future<Response> _measurementsHandler(Request req) async {
  final body = await req.readAsString();

  try {
    final jsonBody = jsonDecode(body);
    MeasurementMessage m = MeasurementMessage.fromMap(jsonBody);
    print(m.deviceID);
    for (Measurement measurement in m.measurements) {
      await databases.createDocument(
          databaseId: dbName!,
          collectionId: 'measurements',
          documentId: appwrite.ID.unique(),
          data: measurement.toMap());
    }
  } catch (e, s) {
    print(e);
    print(s);
    Response.internalServerError(body: 'error while trying to add measurement');
  }

  return Response.ok(body, headers: {'content-type': 'application/json'});
}

void main(List<String> args) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  dbName = env['OKAKI_DBNAME'];
  final String? apikey = env['OKAKI_APIKEY'];
  final String? projectID = env['OKAKI_PROJECT_ID'];
  final String? endpoint = env['OKAKI_ENDPOINT'];

  if ((dbName == null) ||
      (apikey == null) ||
      (projectID == null) ||
      (endpoint == null)) {
    print("ERROR: please check your .env file");
    return;
  }

  // Init SDK

  client
      .setEndpoint(endpoint) // Your API Endpoint
      .setProject(projectID) // Your project ID
      .setKey(apikey); // Your secret API key

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}