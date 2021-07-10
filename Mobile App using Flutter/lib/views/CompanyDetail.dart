import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/comment/bloc.dart';
import 'package:online_customer_care/bloc/comment/comment_bloc.dart';
import 'package:online_customer_care/bloc/comment/comment_state.dart';
import 'package:online_customer_care/bloc/search/bloc.dart';
import 'package:online_customer_care/bloc/user/bloc.dart';
import 'package:online_customer_care/models/comment.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:online_customer_care/models/service.dart';
import 'package:online_customer_care/views/LogIn.dart';
import 'package:online_customer_care/views/ProfilePage.dart';
import 'package:online_customer_care/views/Ratting.dart';
import 'package:online_customer_care/views/Signup.dart';
import 'package:online_customer_care/views/delete_dialog.dart';
import 'package:online_customer_care/views/logout.dart';

import 'Home.dart';

class CompanyDetail extends StatefulWidget {
  static const companyDetailRoute = "/companyDetail";
  final Company company;

  CompanyDetail({this.company});

  @override
  State<CompanyDetail> createState() => CompanyDetailState();
}

class CompanyDetailState extends State<CompanyDetail> {
  bool viewComments = false;

  showComments() {
    setState(() {
      viewComments = true;
    });
  }

  hideComments() {
    setState(() {
      viewComments = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SearchEvent event = SearchByComp(widget.company.ID);
    BlocProvider.of<SearchBloc>(context).add(event);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Company Detail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          BlocBuilder<LoggedBloc, bool>(
            builder: (context, state) {
              return IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () async {
                    if (state) {
                      final result = await showDialog(
                          context: context, builder: (_) => LogoutDialoge());

                      if (result == true) {
                        loggedEvent l = loggedEvent.loginStatus;
                        BlocProvider.of<LoggedBloc>(context).add(l);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    }else {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    }
                  });
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepOrange, Colors.grey])),
          child: Column(children: [
            Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(''),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 175),
              child: Column(
                children: [
                  Text(
                    widget.company.FullName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Text(widget.company.Moto,
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.company.Address,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 25,
                ),
                BlocBuilder<LoggedBloc, bool>(
                  builder: (context, state) {
                    return Ratting(5, state, widget.company);
                  },
                ),
                //  Ratting(),
                SizedBox(height: 25),
              ],
            )),
            Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Comments',
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ],
                )),
            Container(
                //TODO: get comments
                child: Expanded(child: BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                if (state is CommentOperationFailure) {
                  return Center(child: Text("Failed To Get Comments"));
                }
                if (state is CommentLoadSuccess) {
                  final comments = state.comment;
//
//                  Dismissible(
//                      key: ValueKey(companies[index].ID),
//                      direction: DismissDirection.startToEnd,
//                      onDismissed: (direction) {},
//                      confirmDismiss: (direction) async {
//                        final result = await showDialog(
//                            context: context,
//                            builder: (_) => DeleteDialoge());
//                        print(".............................$result");
//                        if (result) {
//                          final CompanyEvent event =
//                          CompanyDelete(companies[index]);
//                          BlocProvider.of<CompanyBloc>(context).add(event);
//                        }
//                        return result;
//                      },


                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (_, index) =>Dismissible(
                      key: ValueKey(comments[index].ID),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {},
                      confirmDismiss: (direction) async {
                        final result = await showDialog(
                            context: context,
                            builder: (_) => DeleteDialoge());
                        print(".............................$result");
                        if (result) {
                      BlocBuilder<UserBloc,UserState>(builder: (context,state){
                        if(state is UserLoadSuccess){
                          if(state.user[0].Username == comments[index].Username){
                            CommentEvent e = CommentDelete(comments[index]);
                            BlocProvider.of<CommentBloc>(context).add(e);
                            return result;
                          }
                        }
                        return null;
                      },);
                        }
                        return result;
                      },
                      child: CommentBox(comments[index]),)
                  );
                }
                return CircularProgressIndicator();
              },
            ))),
            Text(
              "SERVICE",
              style: TextStyle(color: Colors.white),
            ),
            Container(child: Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is SearchOperationFailure) {
                  return Center(child: Text("Failed To load Text"));
                }
                if (state is SearchLoadSuccess) {
                  final services = state.services;
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return Column(
                        children: [serviceBox(services[index])],
                      );
                    },
                    itemCount: services.length,
                  );
                }
                return CircularProgressIndicator();
              }),
            ))
          ])),
    );
  }

  Widget serviceBox(Service service) {
    return Card(
      //shadowColor: Colors.grey,

      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${service.Name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            "${service.Description}",
          )
        ],
      ),
    );
  }

  List<Comment> comments;

  List<Comment> getComments() {
    return comments;
  }

  Widget CommentBox(Comment comment) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${comment.Username}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text('${comment.Message}', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
