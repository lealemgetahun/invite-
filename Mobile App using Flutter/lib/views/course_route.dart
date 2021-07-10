import 'package:flutter/material.dart';
import 'package:online_customer_care/bloc/company/company_event.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:online_customer_care/views/CompanyDetail.dart';
import 'package:online_customer_care/views/company.dart';
import 'package:online_customer_care/views/walkThrough.dart';

import 'Home.dart';
import 'Signup.dart';



class CourseAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => WalkTHrough());
    }/*
    if(settings.name == '/add'){
      CompanyArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context)=> AddAndUpdateCompany(args));
    }*/
    if(settings.name == '/companyList'){
      List<Company> c = settings.arguments;
      return MaterialPageRoute(builder: (context)=> CompanyListD());
    }
    if(settings.name == '/home'){
      return MaterialPageRoute(builder: (context)=> Home());
    }
    if(settings.name == '/companyDetail'){
      return MaterialPageRoute(builder: (context)=> CompanyDetail());
    }
    if(settings.name == '/signUp'){
      return MaterialPageRoute(builder: (context)=> SignUp());
    }
    //return MaterialPageRoute(builder: (context) => CompanyList());
  }
}



class CourseArgument {
  final Company company;
  final bool edit;
  CourseArgument({this.company, this.edit});
}
