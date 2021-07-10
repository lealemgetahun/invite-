import 'dart:convert';

import 'package:online_customer_care/models/api_responce.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:http/http.dart' as http;
class CompanyService {
  static const API = 'http://192.168.43.6:8282';

  static const headers = {
    //'apiKey': '724d32be-4988-4264-a371-030b458100e1',
    'Content-Type': 'application/json'};

  Future<APIResponse<List<Company>>> getCompanyList() {
    print(".............................................");
    return http.get(API + '/companies',headers: headers).then((data) {
      print("...................${data.statusCode}");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <Company>[];
        for (var item in jsonData) {
          notes.add(Company.fromJson(item));
          print(Company.fromJson(item));
        }
        return APIResponse<List<Company>>(data: notes);
      }
      return APIResponse<List<Company>>(
          error: true, errorMessage: 'An error occurred1');
    });

  }

 Future<APIResponse<Company>> getCompany(int ID) {
    return http.get(API + '/companies/' + '$ID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Company>(data: Company.fromJson(jsonData));
      }
      return APIResponse<Company>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<Company>(error: true, errorMessage: 'An error occurred'));
  }
/*
  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(API + '/notes', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
  }

  Future<APIResponse<bool>> updateCompany(String noteID, NoteManipulation item) {
    return http.put(API + '/notes/' + noteID, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}*/
}