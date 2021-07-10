import 'dart:convert';

import 'package:online_customer_care/models/api_responce.dart';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/comment.dart';
import 'package:online_customer_care/models/user.dart';
class CommentService {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<APIResponse<List<Comment>>> getCommentList() {
    print(".............................................");
    return http.get(API + '/comments',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <Comment>[];
        for (var item in jsonData) {
          notes.add(Comment.fromJson(item));

        }
        return APIResponse<List<Comment>>(data: notes);
      }
      return APIResponse<List<Comment>>(
          error: true, errorMessage: 'An error occurred1');
    });

  }

  Future<APIResponse<Comment>> getComment(int ID) {
    return http.get(API + '/comments/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Comment>(data: Comment.fromJson(jsonData));
      }
      return APIResponse<Comment>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<Comment>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> createComment(Comment item) {
    return http.post(API + '/comments', headers: headers, body: json.encode(item.commentToJson(item))).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred1');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred2'));
  }

  Future<APIResponse<bool>> updateComment(int ID, Comment item) {
    return http.put(API + '/comments/' + '$ID', headers: headers, body: json.encode(item.commentToJson(item))).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> deleteComment(int ID) {
    return http.delete(API + '/comments/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

}