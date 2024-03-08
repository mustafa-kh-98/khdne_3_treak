import 'package:dio/dio.dart';

import '../../generic/generic.dart';
import '../../models/auth_models/request/login_request_dto.dart';
import '../../models/auth_models/response/user_response.dart';
import '../../provider/api_provider.dart';

class AuthRepo{
  loginWithPhoneAndPass({
    required LoginRequestDto loginRequestDto,
    Function()? beforeSend,
    Function(GenericResponse<UserResponseDto> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiProvider.instance.post<UserResponseDto>(
      'login',
      beforeSend: beforeSend,
      onSuccess: onSuccess,
      data: loginRequestDto.toJson(),
      onError: onError,
    );
  }
  register({
    required FormData formData,
    Function()? beforeSend,
    Function(GenericResponse<UserResponseDto> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiProvider.instance.post<UserResponseDto>(
      'register',
      beforeSend: beforeSend,
      onSuccess: onSuccess,
      data: formData,
      onError: onError,
    );
  }

}