import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/repositories/comment_repository.dart';
import 'package:online_customer_care/bloc/comment/bloc.dart';

class CommentBloc extends Bloc<CommentEvent,CommentState>{
  final CommentRepository cr;
  CommentBloc({@required this.cr}):
      assert(cr != null), super(CommentLoading());
  @override
  Stream<CommentState>mapEventToState(CommentEvent event) async*{
    if(event is CommentLoad){
      yield CommentLoading();
      try{
        final comment= await cr.getCommentList();
        yield CommentLoadSuccess(comment);

      }catch(_){
        yield CommentOperationFailure();
      }
    }
    if(event is CommentUpdate){
      try{
        await cr.updateComment(event.comment);
        final company = await cr.getCommentList();
        yield CommentLoadSuccess(company);
      }catch(_){
        yield CommentOperationFailure();
      }
    }
    if (event is CommentCreate) {
      try {
        await cr.createComment(event.comment);
        final comment = await cr.getCommentList();
        yield CommentLoadSuccess(comment);
      } catch (_) {
        yield CommentOperationFailure();
      }
    }
    if (event is CommentDelete) {
      try {
        await cr.deleteComment(event.comment.ID);
        final comment = await cr.getCommentList();
        yield CommentLoadSuccess(comment);
      } catch (_) {
        yield CommentOperationFailure();
      }
    }

  }
}