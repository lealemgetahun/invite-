
class User{
  int id;
  String Fname;
  String Lname;
  String Email;
  String Phone;
  String Username;
  String Password;

  User({this.id,
    this.Fname,
    this.Lname,
    this.Email,
    this.Phone,
    this.Username,
    this.Password
  });
  factory User.fromJson(Map<String, dynamic> item) => _$UserFromJson(item);
  userToJson(User user) => _$UserToJson(user);

}

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      Fname: json['Fname'] as String,
      Lname: json['Lname'] as String,
      Email: json['Email'] as String,
      Phone: json['Phone'] as String,
      Username: json['Username'] as String,
      Password: json['Password'] as String

  );
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Fname': instance.Fname,
      'Lname': instance.Lname,
      'Email': instance.Email,
      'Phone': instance.Phone,
      'Username': instance.Username,
      'Password': instance.Password,

    };