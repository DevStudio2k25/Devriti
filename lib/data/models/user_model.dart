import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? ageGroup;

  @HiveField(4)
  final String? emergencyContact;

  @HiveField(5)
  final bool isGuest;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String? photoUrl;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.ageGroup,
    this.emergencyContact,
    required this.isGuest,
    required this.createdAt,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      ageGroup: json['ageGroup'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      isGuest: json['isGuest'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'ageGroup': ageGroup,
      'emergencyContact': emergencyContact,
      'isGuest': isGuest,
      'createdAt': createdAt.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? ageGroup,
    String? emergencyContact,
    bool? isGuest,
    DateTime? createdAt,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      ageGroup: ageGroup ?? this.ageGroup,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt ?? this.createdAt,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
