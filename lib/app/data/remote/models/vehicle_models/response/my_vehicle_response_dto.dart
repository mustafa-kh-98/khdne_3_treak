class MyVehiclesResponseDto {
  final int? id;
  final int? vehicleTypeId;
  final int? userId;
  final String? model;
  final String? color;
  final int? boardNumber;
  final String? vehicleImage;
  final String? mechanicImage;
  final String? boardImage;
  final String? idImage;
  final String? delegateImage;
  final String? createdAt;
  final String? updatedAt;
  final Type? type;

  MyVehiclesResponseDto({
    this.id,
    this.vehicleTypeId,
    this.userId,
    this.model,
    this.color,
    this.boardNumber,
    this.vehicleImage,
    this.mechanicImage,
    this.boardImage,
    this.idImage,
    this.delegateImage,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory MyVehiclesResponseDto.fromJson(Map<String, dynamic> json) => MyVehiclesResponseDto(
    id: json["id"],
    vehicleTypeId: json["vehicle_type_id"],
    userId: json["user_id"],
    model: json["model"],
    color: json["color"],
    boardNumber: json["board_number"],
    vehicleImage: json["vehicle_image"],
    mechanicImage: json["mechanic_image"],
    boardImage: json["board_image"],
    idImage: json["id_image"],
    delegateImage: json["delegate_image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_type_id": vehicleTypeId,
    "user_id": userId,
    "model": model,
    "color": color,
    "board_number": boardNumber,
    "vehicle_image": vehicleImage,
    "mechanic_image": mechanicImage,
    "board_image": boardImage,
    "id_image": idImage,
    "delegate_image": delegateImage,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": type?.toJson(),
  };
}

class Type {
  final int? id;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  Type({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
