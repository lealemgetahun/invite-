import 'dart:convert';
import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:http/http.dart' as http;

class CompanyDataProvider {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<List<Company>> getCompanyList() {
    print(".............................................");
    return http.get(API + '/companies',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final service = <Company>[];
        for (var item in jsonData) {
          service.add(Company.fromJson(item));
        }
        return  service;
      }

      return throw Exception('Failed to load Company');

    });

  }

  Future<Company> getCompany(int ID) {
    return http.get(API + '/companies/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Company.fromJson(jsonData);
      }return throw Exception('Failed to load Company');
    });
  }

  Future<void> createCompany(Company item) {
    return http.post(API + '/companies', headers: headers, body: json.encode(item.companyToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to create company.');
      }
    });

  }

  Future<void> updateCompany(Company item) {
    return http.put(API + '/companies/' + '${item.ID}', headers: headers, body: json.encode(item.companyToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to update company.');
      }
    });
  }

  Future<void> deleteCompany(int id) {
    return http.delete(API + '/companies/' + '$id', headers: headers).then((data) {

      if (data.statusCode != 200) {
        throw Exception('Failed to delete company.');
      }
    });
  }
}
