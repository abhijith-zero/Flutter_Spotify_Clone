import 'dart:convert';

import 'package:client/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
    required String confirm_password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/auth/signup"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": name,
          "email": email,
          "password": password,
          "confirm_password": confirm_password,
        }),
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      print(responseData);
      if (response.statusCode != 201) {
        return Left(AppFailure(responseData['detail'] ?? 'Signup failed'));
      }
      return Right(UserModel.fromMap(responseData));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      print(responseData);
      if (response.statusCode != 200) {
        return Left(AppFailure(responseData['detail'] ?? 'Login failed'));
      }
      //

      return Right(
        UserModel.fromMap(
          responseData['user'],
        ).copyWith(token: responseData['access_token']),
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> getCurrentUserData({
    required String token,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/auth/"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      print(response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      print(responseData);
      if (response.statusCode != 200) {
        return Left(AppFailure(responseData['detail'] ?? 'Invalid token'));
      }
      //
      return Right(UserModel.fromMap(responseData).copyWith(token: token));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
