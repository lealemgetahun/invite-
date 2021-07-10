import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/user/bloc.dart';
import 'package:online_customer_care/bloc/user/user_event.dart';
import 'package:online_customer_care/data_provider/user_data.dart';
import 'package:online_customer_care/models/login.dart';
import 'package:online_customer_care/views/AdminCompanyDetail.dart';
import 'package:online_customer_care/views/AdminCompanyList.dart';
import 'package:online_customer_care/views/Signup.dart';
import 'ClipedHead.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          WavyHeader(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: Text("LOGIN", style: TextStyle(fontSize: 30)),
          ),
          Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                        cursorColor: Colors.deepOrange,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'UserName'),
                        onSaved: (value) => {
                          setState(
                                () {
                              this._user['userName'] = value;
                            },
                          )
                        }),
                    TextFormField(
                        obscureText: true,
                        cursorColor: Colors.deepOrange,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'password'),
                        onSaved: (value) => {
                          setState(
                                () {
                              this._user['password'] = value;
                            },
                          )
                        }
                    ),
                  ])),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(100, 40, 0, 0),
                child: RaisedButton(
                  child: Text('LOGIN'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      LoginModel lg = LoginModel(password: _user['password'],username: _user['userName']);
                      final UserEvent event = LoginEvent(lg);
                      BlocProvider.of<UserBloc>(context).add(event);

                      context
                          .read<LoggedBloc>()
                          .add(loggedEvent.loginStatus);
                      if(_user['password']== 'adminpass'&& _user['userName']=='admin'){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminCompanyList()));
                      }else{
                        Navigator.pop(context);
                      }

                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 40, 0, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  child: Text('SINUP'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>
                   SignUp()));
                  },
                ),
              )
            ],
          ),

        ],
      ),)
    );
  }
}
enum loggedEvent{
  loginStatus
}
class LoggedBloc extends Bloc<loggedEvent, bool> {
  LoggedBloc() : super(false);

  //async generator of states from events
  @override
  Stream<bool> mapEventToState(loggedEvent event) async* {
    if (event == loggedEvent.loginStatus) {
      yield !state;
    }
  }
}
