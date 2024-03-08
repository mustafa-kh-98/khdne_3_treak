
class UserResponseDto {
  final User? user;
  final String? token;

  UserResponseDto({
    this.user,
    this.token,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) => UserResponseDto(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  final int? id;
  final String? fullname;
  final String? phoneNumber;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.fullname,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    phoneNumber: json["phone_number"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone_number": phoneNumber,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
