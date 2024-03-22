import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/remote/forum_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_info_api_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref {
  late SharedPreferences _sharedPreferences;
  static const _userKey = "User";
  static const _firstTimeAppOpen = 'firstTimeAppOpen';
  static const _appToken = 'Token';

  static Future setFirstTimeAppOpen(bool status) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setBool(_firstTimeAppOpen, status);
  }

  static Future<bool> getFirstTimeAppOpen() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getBool(_firstTimeAppOpen);
    if (res == null) {
      return true;
    }
    return res;
  }

  static Future<void> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userApiModel = UserApiModel(
      userInfo: user.userInfo.fromDomain(),
      karma: user.karma,
      followers: user.followers,
      following: user.following,
      forums: user.forums?.map((forum) => forum.fromDomain()).toList(),
    );
    final userJson = userApiModel.toJson();
    await prefs.setString(_userKey, jsonEncode(userJson));
  }

  static Future<User?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? res = prefs.getString(_userKey);
      if (res == null) {
        return null;
      }
      final Map<String, dynamic> decodedJson = json.decode(res);
      UserInfoApiModel userInfoApiModel =
          UserInfoApiModel.fromJson(decodedJson['userInfo']);
      UserApiModel userApiModel = UserApiModel.fromJson(decodedJson);
      UserApiModel userPref = UserApiModel(
        userInfo: userInfoApiModel,
        karma: userApiModel.karma,
        followers: userApiModel.followers,
        following: userApiModel.following,
        forums: userApiModel.forums?.map((forum) => forum).toList(),
      );
      final user = userPref.toDomain();
      print("User: $user");
      return user;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  static Future deleteUser() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_userKey);
  }

  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return Right(token);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
