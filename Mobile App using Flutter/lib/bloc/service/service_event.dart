
import 'package:equatable/equatable.dart';

import 'package:online_customer_care/models/service.dart';

abstract class ServiceEvent extends Equatable{
  const ServiceEvent();
}

class ServiceLoad extends ServiceEvent{
  const ServiceLoad();

  @override
  List<Object> get props => [];

}
class ServiceCreate extends ServiceEvent{
  final Service serv;
  const ServiceCreate(this.serv);

  @override
  List<Object> get props => [serv];

}
class ServiceUpdate extends ServiceEvent{
  final Service serv;
  const ServiceUpdate(this.serv);

  @override
  List<Object> get props => [serv];
}
class ServiceDelete extends ServiceEvent{
  final Service serv;
  const ServiceDelete(this.serv);

  @override
  List<Object> get props => [serv];

}