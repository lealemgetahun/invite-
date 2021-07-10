import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/company/bloc.dart';
import 'package:online_customer_care/models/company_argument.dart';
import 'package:online_customer_care/views/AddCompany.dart';
import 'package:online_customer_care/views/AdminCompanyDetail.dart';
import 'package:online_customer_care/views/CompanyDetail.dart';
import 'package:online_customer_care/views/Home.dart';
import 'package:online_customer_care/views/LogIn.dart';

import 'package:online_customer_care/views/delete_dialog.dart';
import 'package:online_customer_care/views/logout.dart';

class AdminCompanyList extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Companies",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              final result = await showDialog(
                  context: context,
                  builder: (_) => LogoutDialoge());

              if(result == true){

                loggedEvent l = loggedEvent.loginStatus;
                BlocProvider.of<LoggedBloc>(context).add(l);
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));
              }
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepOrange, Colors.grey])),
        child: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (_, state) {
            if (state is CompanyOperationFailure) {
              return Center(
                child: Text('Could not do company operation'),
              );
            }
            if (state is CompanyLoadSuccess) {
              final companies = state.company;
              return ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (_, index) => Dismissible(
                        key: ValueKey(companies[index].ID),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {},
                        confirmDismiss: (direction) async {
                          final result = await showDialog(
                              context: context,
                              builder: (_) => DeleteDialoge());
                          print(".............................$result");
                          if (result) {
                            final CompanyEvent event =
                                CompanyDelete(companies[index]);
                            BlocProvider.of<CompanyBloc>(context).add(event);
                          }
                          return result;
                        },
                        child: GestureDetector(
                            child: Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.network(
                                      "https://png.pngtree.com/png-clipart/20190515/original/pngtree-abstract-digital-technology-background-futuristic-structure-elements-concept-background-design-png-image_3527873.jpg"),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            companies[index].FullName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              //Ratting()
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              CompanyArgument c = new CompanyArgument(c: companies[index],edit: true);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAndUpdateCompany(c)));
                            }),
                      ));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
           CompanyArgument c = new CompanyArgument(edit: false);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAndUpdateCompany(c)));
    },
        child: Icon(Icons.add),
      ),
    );
  }
}
