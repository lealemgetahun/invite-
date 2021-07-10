
import 'package:meta/meta.dart';
import 'package:online_customer_care/data_provider/service_data.dart';
import 'package:online_customer_care/models/service.dart';


class ServiceRepository {
  final ServiceDataProvider dataProvider;

  ServiceRepository({@required this.dataProvider}) :
        assert(dataProvider != null);

  Future<List<Service>> getServiceList() async {
    return await dataProvider.getServiceList();
  }

  Future<Service> getService(int id) async {
    return await dataProvider.getService(id);
  }

  Future<void> updateService(Service serv) async {
    return await dataProvider.updateService(serv);
  }
  Future<void> deleteService(int id) async {
    return await dataProvider.deleteService(id);
  }
  Future<void> createService(Service serv) async {
    return await dataProvider.createService(serv);
  }



}