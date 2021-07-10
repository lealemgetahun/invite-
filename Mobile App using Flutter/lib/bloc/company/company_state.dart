

import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/models.dart';

abstract class CompanyState extends Equatable{
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyLoading extends CompanyState{

}

class CompanyLoadSuccess extends CompanyState{
  final List<Company> company;
  CompanyLoadSuccess([this.company = const[]]);

  @override
  List<Object> get props => [company];
}

class CompanyOperationFailure extends CompanyState{}