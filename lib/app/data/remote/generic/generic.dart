import '../models/auth_models/response/user_response.dart';
import '../models/vehicle_models/response/my_vehicle_response_dto.dart';

class GenericResponse<T> {
  bool? succeeded;
  String? message;
  T data;
  Pagination? pagination;

  GenericResponse({
    required this.succeeded,
    required this.message,
    required this.data,
    required this.pagination,
  });

  static fromJson<T>(json) {
    dynamic map = {};
    if (json is List || (json is Map && !json.containsKey("data"))) {
      map["data"] = json;
    } else {
      map = json;
    }
    return GenericResponse(
      succeeded: map["succeeded"],
      message: map["message"],
      data: _converter<T>(map["data"] ?? <String, dynamic>{}),
      pagination: map["pagination"] == null
          ? null
          : Pagination.fromJson(map["pagination"]),
    );
  }

  static T _converter<T>(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (T == MyVehiclesResponseDto) {
        return MyVehiclesResponseDto.fromJson(json) as T;
      }
      if (T == UserResponseDto) {
        return UserResponseDto.fromJson(json) as T;
      }
    } else if (json is List) {
      if (<MyVehiclesResponseDto>[] is T) {
        return List<MyVehiclesResponseDto>.from(
            json.map((e) => MyVehiclesResponseDto.fromJson(e))) as T;
      } else if (<Type>[] is T) {
        return List<Type>.from(json.map((e) => Type.fromJson(e))) as T;
      }
    }
    throw '$T is not provided';
  }
}

class Pagination {
  final int pageSize;
  final int currentPage;
  final int total;

  Pagination({
    required this.pageSize,
    required this.currentPage,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      pageSize: json["pageSize"],
      currentPage: json["pageNum"],
      total: json["totlaRecords"],
    );
  }
}
