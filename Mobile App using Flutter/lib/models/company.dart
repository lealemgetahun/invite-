

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Company extends Equatable {
  final int ID;
  final String FullName;
  final String Logo;
  final String Email;
  final String Phone;
  final String Address;
  final String Moto;
  final String Password;
  final int Rate;

  Company({this.ID,
    @required this.FullName,
    @required this.Logo,
    @required this.Email,
    @required this.Phone,
    @required this.Address,
    @required this.Moto,
    @required this.Password,
     this.Rate

  });
  factory Company.fromJson(Map<String, dynamic> item) => _$CompanyFromJson(item);

  @override
  List<Object> get props => [ID,FullName,Logo,Email,Phone,Address,Moto,Password,Rate];

  companyToJson(Company company) => _$CompanyToJson(company);

}


Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    ID: json['ID'] as int,
    FullName: json['FullName'] as String,
    Logo: json['Logo'] as String,
    Email: json['Email'] as String,
    Phone: json['Phone'] as String,
    Address: json['Address'] as String,
    Moto: json['Moto'] as String,
    Password: json['Password'] as String,
    Rate: json['Rate'] as int


  );

}
Map<String, dynamic> _$CompanyToJson(Company instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'FullName': instance.FullName,
      'Logo': instance.Logo,
      'Email': instance.Email,
      'Phone': instance.Phone,
      'Address': instance.Address,
      'Moto': instance.Moto,
      'Password': instance.Password,
      'Rate': instance.Rate

    };
