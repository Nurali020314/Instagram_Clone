import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/image_upload/typedefs/is_loading.dart';
import 'package:untitled2/state/posts/notifiers/delete_post_state_notifier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
  (ref) => DeletePostStateNotifier(),
);
