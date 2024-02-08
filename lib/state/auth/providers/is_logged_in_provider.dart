import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/auth/models/auth_result.dart';
import 'package:untitled2/state/auth/providers/auth_state_provider.dart';

final isLogggedProvider=Provider<bool>((ref) {
   final authState=ref.watch(authStateProvider);
   return authState.result==AuthResult.success;
});