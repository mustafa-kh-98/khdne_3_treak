import 'package:dio/dio.dart';

import '../../../../core/utils/user_manager.dart';
import '../../generic/generic.dart';
import '../../models/vehicle_models/response/my_vehicle_response_dto.dart';
import '../../provider/api_provider.dart';

class VehicleRepo{

  getMyVehicles({
    Function()? beforeSend,
    Function(GenericResponse<List<MyVehiclesResponseDto>> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiProvider.instance.get<List<MyVehiclesResponseDto>>(
      'Vehicle',
      token:UserManager.manager.token,
      beforeSend: beforeSend,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
  getMyVehiclesType({
    Function()? beforeSend,
    Function(GenericResponse<List<Type>> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiProvider.instance.get<List<Type>>(
      'VehicleType',
      token:UserManager.manager.token,
      beforeSend: beforeSend,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
  addNewVehicle({
    required FormData data,
    Function()? beforeSend,
    Function(GenericResponse<MyVehiclesResponseDto> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiProvider.instance.post<MyVehiclesResponseDto>(
      'Vehicle',
      token:UserManager.manager.token,
      beforeSend: beforeSend,
      data: data,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}