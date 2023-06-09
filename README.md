# okaki-device-bridge

A Webservice that connects IoT devices to okaki.

The following documentation was tested with Dart 3.0.1.

First thing to do:
```bash
cd okaki-device-bridge
```

# Endpoints

POST `/measurements` expects a JSON String with a deviceID and a List of Measurement objects. See messsage_model.dart!

Example:

```json
{
    "deviceID":"device1",
    "key":"my-secret",
    "measurements":
    [
        {"sensorID":"sensor1","sensorTypeID":"float","value":"12.34"},
        {"sensorID":"sensor1","sensorTypeID":"float","value":"56.78"}
    ]
}
```

# .env file

You need to create an .env file in the okaki-device-bridge subfolder with the following content:

```
OKAKI_DBNAME=testing
OKAKI_APIKEY=YOURAPPWRITEAPIKEY
OKAKI_PROJECT_ID=644bbba076344291f17d
OKAKI_ENDPOINT=https://appwrite.okaki.org/v1
```

# HTTP support

by default, HTTPS is used. If you need to use HTTP, please check the last eight lines of server.dart and modify the file to your needs.

# HTTPS support

If you run the okaki device bridge on the same domain as your appwrite installation, we can reuse appwrite's certificates. If you don't use the same domain, please provide your own certificates!

Let's say, our local linux user is called ubuntu... 
we need to copy the Let's Encrypt certificates that appwrite created for its services to our bin/certificates directory.

```bash
sudo su
cd /var/lib/docker/volumes/appwrite_appwrite-certificates/_data
cd <YOUR_DOMAIN_NAME e.g. appwrite.okaki.org>
cp fullchain.pem /home/ubuntu/okaki-device-bridge/okaki-device-bridge/bin/certificates/server_chain.pem
cp privkey.pem /home/ubuntu/okaki-device-bridge/okaki-device-bridge/bin/certificates/server_key.pem
chown ubuntu /home/ubuntu/okaki-device-bridge/okaki-device-bridge/bin/certificates/server_chain.pem
chown ubuntu /home/ubuntu/okaki-device-bridge/okaki-device-bridge/bin/certificates/server_key.pem
exit
```

# Running with the Dart SDK

You can run the service with the [Dart SDK](https://dart.dev/get-dart)
like this:

```bash
$ dart run bin/server.dart
Server listening on port 8080
```

# Running as a Linux Service

This is the current solution for okaki.org:

Generate a new file called
`/etc/systemd/system/odbridge.service`:

```bash
[Unit]
Description=okaki device bridge

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/okaki-device-bridge/okaki-device-bridge/bin/
ExecStart=/home/ubuntu/dart-sdk/bin/dart server.dart
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and run the new service:

```bash
sudo systemctl enable odbridge
sudo systemctl daemon-reload
sudo service odbridge start
```


## Running with Docker

If you have [Docker](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```bash
$ docker build . -t okaki-device-bridge
$ docker run -it --rm -p 8080:8080 --env-file .env --name odbridge okaki-device-bridge
Server listening on port 8080
```

You can stop the Service by killing the docker container:
```bash
docker kill odbridge   
```

## Credits

This app was built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).
