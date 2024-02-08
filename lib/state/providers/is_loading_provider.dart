
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/auth/providers/auth_state_provider.dart';

import '../image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider=Provider<bool>((ref) {
  final authState=ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
   return authState.isLoading || isUploadingImage ;
});