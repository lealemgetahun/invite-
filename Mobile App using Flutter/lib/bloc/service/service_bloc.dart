import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:online_customer_care/bloc/service/service_event.dart';
import 'package:online_customer_care/bloc/service/service_state.dart';

import 'package:online_customer_care/repositories/service_repository.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository sr;
  ServiceBloc({@required this.sr})
      : assert(sr != null),
        super(ServiceLoading());
  @override
  Stream<ServiceState> mapEventToState(ServiceEvent event) async* {
    if (event is ServiceLoad) {
      yield ServiceLoading();
      try {
        final serv = await sr.getServiceList();
        yield ServiceLoadSuccess(serv);
      } catch (_) {
        yield ServiceOperationFailure();
      }
    }
    if (event is ServiceUpdate) {
      try {
        await sr.updateService(event.serv);
        final serv = await sr.getServiceList();
        yield ServiceLoadSuccess(serv);
      } catch (_) {
        yield ServiceOperationFailure();
      }
    }
    if (event is ServiceCreate) {
      try {
        await sr.createService(event.serv);
        final serv = await sr.getServiceList();
        yield ServiceLoadSuccess(serv);
      } catch (_) {
        yield ServiceOperationFailure();
      }
    }
    if (event is ServiceDelete) {
      try {
        await sr.deleteService(event.serv.id);
        final serv = await sr.getServiceList();
        yield ServiceLoadSuccess(serv);
      } catch (_) {
        yield ServiceOperationFailure();
      }
    }
  }
}
