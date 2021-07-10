import 'package:meta/meta.dart';

import 'package:online_customer_care/data_provider/user_data.dart';
import 'package:online_customer_care/models/login.dart';
import 'package:online_customer_care/models/login.dart';

import 'package:online_customer_care/models/user.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository({@required this.dataProvider}) :
        assert(dataProvider != null);

  Future<List<User>> getUserList() async {
    return await dataProvider.getUserList();
  }

  Future<User> getUser(int id) async {
    return await dataProvider.getUser(id);
  }

  Future<void> updateUser( User user) async {
    return await dataProvider.updateUser(user);
  }
  Future<void> deleteUser(int id) async {
    return await dataProvider.deleteUser(id);
  }
  Future<User> createUser(User user) async {
    return await dataProvider.createUser(user);
  }
  Future<User> Login(LoginModel log) async{
    return await dataProvider.login(log);
  }


}