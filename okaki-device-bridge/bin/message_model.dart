// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'measurement_model.dart';

class MeasurementMessage {
  final String deviceID;
  final List<Measurement> measurements;
  MeasurementMessage({
    required this.deviceID,
    required this.measurements,
  });

  MeasurementMessage copyWith({
    String? deviceID,
    List<Measurement>? measurements,
  }) {
    return MeasurementMessage(
      deviceID: deviceID ?? this.deviceID,
      measurements: measurements ?? this.measurements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceID': deviceID,
      'measurements': measurements.map((x) => x.toMap()).toList(),
    };
  }

  factory MeasurementMessage.fromMap(Map<String, dynamic> map) {
    return MeasurementMessage(
      deviceID: map['deviceID'] as String,
      measurements: List<Measurement>.from(
        (map['measurements'] as List<dynamic>).map<Measurement>(
          (x) => Measurement.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MeasurementMessage.fromJson(String source) =>
      MeasurementMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MeasurementMessage(deviceID: $deviceID, measurements: $measurements)';

  @override
  bool operator ==(covariant MeasurementMessage other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.deviceID == deviceID &&
        listEquals(other.measurements, measurements);
  }

  @override
  int get hashCode => deviceID.hashCode ^ measurements.hashCode;
}
