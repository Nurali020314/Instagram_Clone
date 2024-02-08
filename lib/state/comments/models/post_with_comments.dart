import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled2/state/posts/models/post.dart';

import 'comment.dart';


@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;

  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) =>
      post == other.post &&
          const IterableEquality().equals(
            comments,
            other.comments,
          );

  @override
  int get hashCode => Object.hashAll([
    post,
    comments,
  ]);
}
