/// User Profile Model for Firestore
class UserProfileModel {
  String? name;
  String? email;
  String? phone;
  DateTime? dateOfBirth;
  String? gender;
  String? profession;
  String? address;
  String? emergencyContactName;
  String? emergencyContactRelation;
  String? emergencyContactPhone;
  DateTime? createdAt;

  UserProfileModel({
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.profession,
    this.address,
    this.emergencyContactName,
    this.emergencyContactRelation,
    this.emergencyContactPhone,
    this.createdAt,
  });

  // Calculate age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final today = DateTime.now();
    int age = today.year - dateOfBirth!.year;
    if (today.month < dateOfBirth!.month ||
        (today.month == dateOfBirth!.month && today.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'profession': profession,
      'address': address,
      'emergencyContactName': emergencyContactName,
      'emergencyContactRelation': emergencyContactRelation,
      'emergencyContactPhone': emergencyContactPhone,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      gender: json['gender'],
      profession: json['profession'],
      address: json['address'],
      emergencyContactName: json['emergencyContactName'],
      emergencyContactRelation: json['emergencyContactRelation'],
      emergencyContactPhone: json['emergencyContactPhone'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
