// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SensorModel {
  final String ownerId;
  final String gardenId;
  final String name;
  final String? comments;
  final String? sensorTypeID;
  final String? currentValue;
  SensorModel({
    required this.ownerId,
    required this.gardenId,
    required this.name,
    this.comments,
    this.sensorTypeID,
    this.currentValue,
  });

  SensorModel copyWith({
    String? ownerId,
    String? gardenId,
    String? name,
    String? comments,
    String? sensorTypeID,
    String? currentValue,
  }) {
    return SensorModel(
      ownerId: ownerId ?? this.ownerId,
      gardenId: gardenId ?? this.gardenId,
      name: name ?? this.name,
      comments: comments ?? this.comments,
      sensorTypeID: sensorTypeID ?? this.sensorTypeID,
      currentValue: currentValue ?? this.currentValue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerId': ownerId,
      'gardenId': gardenId,
      'name': name,
      'comments': comments,
      'sensorTypeID': sensorTypeID,
      'currentValue': currentValue,
    };
  }

  factory SensorModel.fromMap(Map<String, dynamic> map) {
    return SensorModel(
      ownerId: map['ownerID'] as String,
      gardenId: map['gardenID'] as String,
      name: map['name'] as String,
      comments: map['comments'] != null ? map['comments'] as String : "null",
      sensorTypeID:
          map['sensorTypeID'] != null ? map['sensorTypeID'] as String : "null",
      currentValue:
          map['currentValue'] != null ? map['currentValue'] as String : "null",
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorModel.fromJson(String source) =>
      SensorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SensorModel(ownerId: $ownerId, gardenId: $gardenId, name: $name, comments: $comments, sensorTypeID: $sensorTypeID, currentValue: $currentValue)';
  }

  @override
  bool operator ==(covariant SensorModel other) {
    if (identical(this, other)) return true;

    return other.ownerId == ownerId &&
        other.gardenId == gardenId &&
        other.name == name &&
        other.comments == comments &&
        other.sensorTypeID == sensorTypeID &&
        other.currentValue == currentValue;
  }

  @override
  int get hashCode {
    return ownerId.hashCode ^
        gardenId.hashCode ^
        name.hashCode ^
        comments.hashCode ^
        sensorTypeID.hashCode ^
        currentValue.hashCode;
  }
}
