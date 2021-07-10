

import 'package:equatable/equatable.dart';

import 'package:online_customer_care/models/service.dart';

abstract class ServiceState extends Equatable{
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceLoading extends ServiceState{

}

class ServiceLoadSuccess extends ServiceState{
  final List<Service> serv;
  ServiceLoadSuccess([this.serv = const[]]);

  @override
  List<Object> get props => [serv];
}

class ServiceOperationFailure extends ServiceState{}