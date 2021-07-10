
import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/comment.dart';


abstract class CommentEvent extends Equatable{
  const CommentEvent();
}
class CommentLoad extends CommentEvent{
  const CommentLoad();

  @override
  List<Object> get props => [];

}
class CommentCreate extends CommentEvent{
  final Comment comment;
  const CommentCreate(this.comment);

  @override
  List<Object> get props => [comment];

}
class CommentUpdate extends CommentEvent{
  final Comment comment;
  const CommentUpdate(this.comment);

  @override
  List<Object> get props => [comment];
}
class CommentDelete extends CommentEvent{
  final Comment comment;
  const CommentDelete(this.comment);

  @override
  List<Object> get props => [comment];

}