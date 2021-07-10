import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/comment.dart';

class CommentDataProvider {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {

    'Content-Type': 'application/json'};

  Future<List<Comment>> getCommentList() {
    print(".............................................");
    return http.get(API + '/comments',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        print("...................${data.statusCode}");
        final jsonData = json.decode(data.body);
        final comments = <Comment>[];
        print("...................${data.body}");
        for (var item in jsonData) {
          

//          Comment comm = Comment(ID: item['ID'],comp_id: item['Comp_id'],Rate: item['Rate'],
//                                Username: item['Username'],Message: item['Message'],Posted_at: item['Posted_at']);
          comments.add(Comment.fromJson(item));

        }
        return comments;
      }
      return throw Exception('Failed to load Comment');
    });

  }

  Future<Comment> getComment(int ID) {
    return http.get(API + '/comments/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Comment.fromJson(jsonData);
      }
      return throw Exception('Failed to load Company');
    });
  }

  Future<void> createComment(Comment item) {

    return http.post(API + '/comments', headers: headers, body: json.encode(item.commentToJson(item))).then((data) {
      print(">>>>>>>>>>>>>>>>>>>>>>>");
      print(data.statusCode);
      print(item.Username);
      if (data.statusCode != 200) {
        throw Exception('Failed to load Company');
      }
    });
  }

  Future<void> updateComment(Comment item) {
    return http.put(API + '/comments/' + '${item.ID}', headers: headers, body: json.encode(item.commentToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to load Company');
      }

    });
  }

  Future<void> deleteComment(int ID) {
    return http.delete(API + '/comments/' + '$ID', headers: headers).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to load Company');
      }

    });
  }

}