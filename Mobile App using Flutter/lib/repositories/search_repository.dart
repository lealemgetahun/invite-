

import 'package:meta/meta.dart';

import 'package:online_customer_care/data_provider/search_data.dart';

import 'package:online_customer_care/models/comp_vs_serv.dart';

import 'package:online_customer_care/models/models.dart';

class SearchRepository {

  final SearchDataProvider dataProvider;


  SearchRepository(
      {@required this.dataProvider})
      :assert(dataProvider != null);

  Future<List<Company>> searchByService(int id) async {
    return await dataProvider.searchByServiceId(id);
  }

  Future<List<Service>> searchByCompany(int id) async {
    return await dataProvider.searchByCompanyId(id);
  }
}



