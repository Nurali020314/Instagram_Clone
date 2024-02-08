import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/auth/backend/authenticator.dart';
import 'package:untitled2/state/auth/models/auth_result.dart';
import 'package:untitled2/state/auth/models/auth_state.dart';
import 'package:untitled2/state/posts/typedefs/user_id.dart';
import 'package:untitled2/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userID = _authenticator.userId;
    if (result == AuthResult.success && userID != null) {
      await saveUserInfo(
        userID: userID,
      );
    }
    state = AuthState(result: result, isLoading: false, userId: userID);
  }

  Future<void> loginWithFaceBook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userID = _authenticator.userId;
    if (result == AuthResult.success && userID != null) {
      await saveUserInfo(
        userID: userID,
      );
    }
    state = AuthState(result: result, isLoading: false, userId: userID);
  }

  Future<void> saveUserInfo({required UserId userID}) =>
      _userInfoStorage.saveUserInfo(
          userId: userID,
          displayName: _authenticator.displayName,
          email: _authenticator.email);
}
