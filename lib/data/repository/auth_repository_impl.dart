// ignore_for_file: unused_field

import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:fpdart/fpdart.dart';

import '../../domain/errors/failure.dart';
import '../../domain/providers/user_provider.dart';
import '../../domain/repository/auth_repository.dart';
import '../api/api_endpoints.dart';
import '../api/base_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final UserProvider _userProvider;

  AuthRepositoryImpl({
    required ApiClient apiClient,
    required UserProvider userProvider,
  }) : _apiClient = apiClient,
       _userProvider = userProvider;

  // @override
  // Future<Either<Failure, LoginModel>> checkUser(AuthParams params) async {
  //   try {
  //     final response = await _apiClient.post(
  //       ApiEndpoints.checkUser,
  //       data: params.toJson(),
  //       converter: (response) {
  //         return LoginModel.fromJson(response);
  //       },
  //     );

  //     return response.fold(
  //       (failure) {
  //         log("Error Check User: ${failure.message}");
  //         return Left(Failure.serverFailure(message: failure.message));
  //       },
  //       (success) {
  //         return Right(success);
  //       },
  //     );
  //   } catch (e) {
  //     log('Forgot password failed: ${e.toString()}');
  //     return Left(Failure.serverFailure(message: e.toString()));
  //   }
  // }
}
