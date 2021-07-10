import 'dart:convert';

import 'package:online_customer_care/models/api_responce.dart';
import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/service.dart';

class ServiceService {
  static const String API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<APIResponse<List<Service>>> getServiceList() {
    print(".............................................");
    return http.get(API + '/services', headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <Service>[];
        for (var item in jsonData) {
          notes.add(Service.fromJson(item));
        }
        return APIResponse<List<Service>>(data: notes);
      }
      return APIResponse<List<Service>>(
          error: true, errorMessage: 'An error occurred1');
    });
  }

  Future<APIResponse<Service>> getService(int ID) {
    return http.get(API + '/companies/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Service>(data: Service.fromJson(jsonData));
      }
      return APIResponse<Service>(
          error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) =>
        APIResponse<Service>(error: true, errorMessage: 'An error occurred'));
  }
}