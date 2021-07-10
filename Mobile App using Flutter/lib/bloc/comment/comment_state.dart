

import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/comment.dart';
import 'package:online_customer_care/models/models.dart';

abstract class CommentState extends Equatable{
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState{}

class CommentLoadSuccess extends CommentState{
  final List<Comment> comment;
  CommentLoadSuccess([this.comment = const[]]);

  @override
  List<Object> get props => [comment];
}

class CommentOperationFailure extends CommentState{}