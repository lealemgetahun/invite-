import 'dart:convert';

import 'package:online_customer_care/models/api_responce.dart';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/user.dart';
class UserService {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<APIResponse<List<User>>> getUserList() {
    print(".............................................");
    return http.get(API + '/users',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <User>[];
        for (var item in jsonData) {
          notes.add(User.fromJson(item));

        }
        return APIResponse<List<User>>(data: notes);
      }
      return APIResponse<List<User>>(
          error: true, errorMessage: 'An error occurred1');
    });

  }

  Future<APIResponse<User>> getUser(int ID) {
    return http.get(API + '/users/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<User>(data: User.fromJson(jsonData));
      }
      return APIResponse<User>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<User>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> createUser(User item) {
    return http.post(API + '/users', headers: headers, body: json.encode(item.userToJson(item))).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred1');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred2'));
  }

  Future<APIResponse<bool>> updateUser(int ID, User item) {
    return http.put(API + '/users/' + '$ID', headers: headers, body: json.encode(item.userToJson(item))).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> deleteUser(int ID) {
    return http.delete(API + '/users/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

}