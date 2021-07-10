
import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/login.dart';

import 'package:online_customer_care/models/user.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
}
class UserLoad extends UserEvent{
  const UserLoad();

  @override
  List<Object> get props => [];

}
class UserCreate extends UserEvent{
  final User user;
  const UserCreate(this.user);

  @override
  List<Object> get props => [user];

}
class UserUpdate extends UserEvent{
  final User user;
  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];
}
class UserDelete extends UserEvent{
  final User user;
  const UserDelete(this.user);

  @override
  List<Object> get props => [user];

}
class LoginEvent extends UserEvent{
  final LoginModel log;
  const LoginEvent(this.log);

  @override

  List<Object> get props => [log];


}