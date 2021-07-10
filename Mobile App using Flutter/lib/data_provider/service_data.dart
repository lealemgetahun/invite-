import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_customer_care/models/service.dart';

class ServiceDataProvider {
  static const String API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<List<Service>> getServiceList() {
    print(".............................................");
    return http.get(API + '/services', headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final service = <Service>[];
        for (var item in jsonData) {
          service.add(Service.fromJson(item));
        }
        return  service;
      }
      return throw Exception('Failed to load Service');
    });
  }

  Future<Service> getService(int ID) {
    return http.get(API + '/services/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return  Service.fromJson(jsonData);
      }
      throw Exception('Failed to load Service');
    });
  }

  Future<void> createService(Service item) {
    return http.post(API + '/services', headers: headers, body: json.encode(item.serviceToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to create service.');
      }
    });

  }

  Future<void> updateService(Service item) {
    return http.put(API + '/services/' + '${item.id}', headers: headers, body: json.encode(item.serviceToJson(item))).then((data) {
      if (data.statusCode != 200) {
        throw Exception('Failed to update service.');
      }
    });
  }

  Future<void> deleteService(int id) {
    return http.delete(API + '/services/' + '$id', headers: headers).then((data) {

      if (data.statusCode != 200) {
        throw Exception('Failed to delete service.');
      }
    });
  }
}

