class LoginRequestDto {
  final String? phoneNumber;
  final String? password;

  LoginRequestDto({
    this.phoneNumber,
    this.password,
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) => LoginRequestDto(
    phoneNumber: json["phone_number"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "password": password,
  };
}
