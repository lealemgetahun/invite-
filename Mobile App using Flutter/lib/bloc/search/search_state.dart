

import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/models.dart';

abstract class SearchState extends Equatable{
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState{

}

class SearchLoadSuccess extends SearchState{
  final List<Company> companies;
  final List<Service> services;
  SearchLoadSuccess([this.companies = const[], this.services = const[]]);

  @override
  List<Object> get props => [companies,services];
}

class SearchOperationFailure extends SearchState{}