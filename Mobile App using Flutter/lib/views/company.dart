import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/company/bloc.dart';
import 'package:online_customer_care/bloc/search/search_bloc.dart';
import 'package:online_customer_care/bloc/search/search_event.dart';
import 'package:online_customer_care/bloc/search/search_state.dart';

import 'package:online_customer_care/models/company.dart';
import 'package:online_customer_care/views/CompanyDetail.dart';
import 'package:online_customer_care/views/Ratting.dart';



class CompanyListD extends StatelessWidget {
  static const routeName = '/companyList';
  int id;
  List<Company> comp;
  CompanyListD({this.id});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Companies",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),
      body: BlocBuilder<CompanyBloc,CompanyState>(builder: (_,state){
        if(state is CompanyOperationFailure){
          return Text("Failed to load 1 company");
        }
        if(state is CompanyLoadSuccess){
          comp = state.company;
          print("..........................${comp[1].FullName}");
          return ListView.builder(
              itemCount: comp.length,
              itemBuilder: (_, index) => GestureDetector(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  comp[index].FullName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(comp[index].Moto),
                                Row(
                                  children: <Widget>[Ratting()],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //TODO: change the route to adminCompanyDetail
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompanyDetail(company:comp[index])))
              )
          );
        }
        return CircularProgressIndicator();

      },),

      //body: Center(child: Text("works")),
    );
  }

}
