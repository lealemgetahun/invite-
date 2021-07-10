import 'dart:convert';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/login.dart';
import 'package:online_customer_care/models/user.dart';
class UserDataProvider {
  static const API = 'http://192.168.43.6:8282';
  static const headers = {
    'Content-Type': 'application/json'};

  Future<List<User>> getUserList() {
    print(".............................................");
    return http.get(API + '/users',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final users = <User>[];
        for (var item in jsonData) {
          users.add(User.fromJson(item));

        }
        return users;
      }
      return throw Exception('Failed to load user');
    });

  }

  Future <User> getUser(int ID) {
    return http.get(API + '/users/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return  User.fromJson(jsonData);
      }
      return throw Exception('Failed to load Company');
    });
  }

  Future<User> createUser(User item) {
    return http.post(API + '/users', headers: headers, body: json.encode(item.userToJson(item))).then((data) {
      print('.........................${data.statusCode}');
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return User.fromJson(jsonData);
      }
      else{
        throw Exception('Failed to load Company');
      }

    });
  }

  Future<void> updateUser( User item) {
    return http.put(API + '/users/' + '${item.id}', headers: headers, body: json.encode(item.userToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to load Company');
      }

    });
  }

  Future<void> deleteUser(int ID) {
    return http.delete(API + '/users/' + '$ID', headers: headers).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to load Company');
      }
    });
  }
  Future<User> login(LoginModel log){
    return http.post(API+'/login',headers: headers,body: jsonEncode(<String,String>{
      'username': log.username,
    'password': log.password})).then((data){
      if(data.statusCode == 200){
        final user = jsonDecode(data.body);
        return User.fromJson(user);
      }else{
        throw Exception('Failed to load Company');
      }
    });
  }
}