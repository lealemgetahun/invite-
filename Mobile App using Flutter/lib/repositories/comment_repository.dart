
import 'package:meta/meta.dart';
import 'package:online_customer_care/data_provider/comment_data.dart';
import 'package:online_customer_care/models/comment.dart';


class CommentRepository {
  final CommentDataProvider dataProvider;

  CommentRepository({@required this.dataProvider}) :
        assert(dataProvider != null);

  Future<List<Comment>> getCommentList() async {
    return await dataProvider.getCommentList();
  }

  Future<Comment> getComment(int id) async {
    return await dataProvider.getComment(id);
  }

  Future<void> updateComment( Comment c) async {
    return await dataProvider.updateComment( c);
  }
  Future<void> deleteComment(int id) async {
    return await dataProvider.deleteComment(id);
  }
  Future<void> createComment(Comment c) async {
    return await dataProvider.createComment(c);
  }



}