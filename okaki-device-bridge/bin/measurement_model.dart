// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Measurement {
  final String sensorID;
  final String sensorTypeID;
  final String value;
  Measurement({
    required this.sensorID,
    required this.sensorTypeID,
    required this.value,
  });

  Measurement copyWith({
    String? sensorID,
    String? sensorTypeID,
    String? value,
  }) {
    return Measurement(
      sensorID: sensorID ?? this.sensorID,
      sensorTypeID: sensorTypeID ?? this.sensorTypeID,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensorID': sensorID,
      'sensorTypeID': sensorTypeID,
      'value': value,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      sensorID: map['sensorID'] as String,
      sensorTypeID: map['sensorTypeID'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Measurement.fromJson(String source) =>
      Measurement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Measurement(sensorID: $sensorID, sensorTypeID: $sensorTypeID, value: $value)';

  @override
  bool operator ==(covariant Measurement other) {
    if (identical(this, other)) return true;

    return other.sensorID == sensorID &&
        other.sensorTypeID == sensorTypeID &&
        other.value == value;
  }

  @override
  int get hashCode =>
      sensorID.hashCode ^ sensorTypeID.hashCode ^ value.hashCode;
}
