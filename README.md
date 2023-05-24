# okaki-device-bridge

A Webservice that connects IoT devices to okaki.

The following documentation was tested with Dart 3.0.1.

First thing to do:
```bash
cd okaki-device-bridge
```

# Endpoints

POST `/measurements` expects a JSON String with a deviceID and a List of Measurement objects. Example:

```json
{
    "deviceID":"998877",
    "measurements":
    [
        {"sensorID":"sensor1","sensorTypeID":"float","value":"12.34"},
        {"sensorID":"sensor1","sensorTypeID":"float","value":"56.78"}
    ]
}
```

# Running with the Dart SDK

You can run the service with the [Dart SDK](https://dart.dev/get-dart)
like this:

```bash
$ dart run bin/server.dart
Server listening on port 8080
```

## Running with Docker

If you have [Docker](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```bash
$ docker build . -t okaki-device-bridge
$ docker run -it -p 8080:8080 okaki-device-bridge
Server listening on port 8080
```


## Credits

This app was built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).
