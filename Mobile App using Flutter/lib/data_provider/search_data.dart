import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/models.dart';

class SearchDataProvider {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {

    'Content-Type': 'application/json'};

  Future<List<Company>> searchByServiceId(int servid) {
    print(".............................................");
    return http.get(API + '/searchByServ/'+'$servid', headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final lists = <Company>[];
        for (var item in jsonData) {
          lists.add(Company.fromJson(item));
        }
        return lists ;
      }
      return throw Exception('Failed to search Company');
    });
  }
  Future<List<Service>> searchByCompanyId(int compid) {
    print(".............................................");
    return http.get(API + '/searchByComp/'+'$compid', headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final lists = <Service>[];
        for (var item in jsonData) {
          lists.add(Service.fromJson(item));
        }
        return lists ;
      }
      return throw Exception('Failed to search Company');
    });
  }
}