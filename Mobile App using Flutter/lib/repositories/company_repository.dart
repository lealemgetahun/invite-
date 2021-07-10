import 'package:meta/meta.dart';
import 'package:online_customer_care/data_provider/company_data.dart';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/company.dart';

class CompanyRepository {
  final CompanyDataProvider dataProvider;

  CompanyRepository({@required this.dataProvider}) :
        assert(dataProvider != null);

  Future<List<Company>> getCompanyList() async {
    return await dataProvider.getCompanyList();
  }

  Future<Company> getCompany(int id) async {
    return await dataProvider.getCompany(id);
  }

  Future<void> updateCompany( Company c) async {
    return await dataProvider.updateCompany( c);
  }
  Future<void> deleteCompany(int id) async {
    return await dataProvider.deleteCompany(id);
  }
  Future<void> createCompany(Company c) async {
    return await dataProvider.createCompany(c);
  }



}