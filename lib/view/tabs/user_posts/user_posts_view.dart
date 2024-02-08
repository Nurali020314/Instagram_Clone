
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled2/state/posts/providers/user_post_provider.dart';
import 'package:untitled2/view/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:untitled2/view/components/animations/error_animation_view.dart';
import 'package:untitled2/view/components/animations/loading_animation_view.dart';
import 'package:untitled2/view/components/post/posts_grid_view.dart';

import '../../constants/string.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final posts=ref.watch(userPostsProvider);
    return RefreshIndicator(
        onRefresh:(){
          ref.refresh(userPostsProvider);
          return Future.delayed(const Duration(seconds: 1));
        },
      child: posts.when(
          data: (posts){
            if(posts.isEmpty){
              return EmptyContentsWithTextAnimationView(text: Strings.youHaveNoPosts);
            }else{
              return PostsGridView(posts: posts);
            }
          },
          error: (error,stackTrace){
            return const ErrorAnimationView();
          },
          loading:(){
         return const LoadingAnimationView();
          }),
        );
  }
}
