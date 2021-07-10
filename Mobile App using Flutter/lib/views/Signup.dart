import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/user/bloc.dart';
import 'package:online_customer_care/bloc/user/user_bloc.dart';
import 'package:online_customer_care/models/models.dart';
import 'package:online_customer_care/views/ClipedHead.dart';
import 'package:online_customer_care/views/CompanyDetail.dart';
import 'package:online_customer_care/views/Home.dart';
import 'package:online_customer_care/views/LogIn.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SinUpState();
}

class SinUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();


  final Map<String, dynamic> _user = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      WavyHeader(),
      Container(
        margin: EdgeInsets.fromLTRB(120, 140, 0, 0),
        child: Text("SINUP", style: TextStyle(fontSize: 30)),
      ),
     Container(
       margin: EdgeInsets.fromLTRB(50, 175, 40, 0),
       child: SingleChildScrollView(
         child: Form(
           key: _formKey,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             TextFormField(
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter name';
                 }
                 return null;
               },
               decoration: InputDecoration(
                 labelText:'First Name'
               ),
               onSaved: (value)=>{
               setState(() {
                  this._user['fname']=value;
             }
             )}),
             TextFormField(
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter last name';
                 }
                 return null;
               },
               decoration: InputDecoration(
                   labelText:'Last Name'
               ),
               onSaved: (value)=>{
                 setState(()=>{
                  this._user['lname']=value
                 })
               },
             ),
             TextFormField(
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter Email';
                 }
                 return null;
               },
               decoration: InputDecoration(
                   labelText:'Email'
               ),
               onSaved: (value)=>{
               setState(()=>{
               this._user['email']=value
               })
               },
             ),
             TextFormField(
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter Phone';
                 }
                 return null;
               },
               decoration: InputDecoration(
                   labelText:'Phone'
               ),
               onSaved: (value)=>{
               setState(()=>{
               this._user['phone']=value
               })
               },
             ),
               TextFormField(
               cursorColor: Colors.deepOrange,
               validator: (value){
               if(value.isEmpty){
               return 'please enter username';
               }
               return null;
               },
               decoration: InputDecoration(
               labelText:'username'
               ),
               onSaved: (value)=>{
               setState(()=>{
               this._user['username']=value
               })
               },
               ),
             TextFormField(
               obscureText: true,
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter Password';
                 }
                 return null;
               },
               decoration: InputDecoration(
                   labelText:'Password'
               ),
               onSaved: (value)=>{
               setState(()=>{
               this._user['password']=value
               })
               },
             ),
             TextFormField(
               obscureText: true,
               cursorColor: Colors.deepOrange,
               validator: (value){
                 if(value.isEmpty){
                   return 'please enter Password';
                 }
                 //TODO :check if password and are comfirm password are the same
//                 if(value != _user['password']){
//                   return 'please confirm password';
//                 }
                 return null;
               },
               decoration: InputDecoration(
                   labelText:'Confirm Password'
               ),
               onSaved: (value)=>{
               setState(()=>{
               this._user['confirm']=value
               })
               },
             ),
             Row(
               children: [
                 Container(
                   margin: EdgeInsets.fromLTRB(80, 40, 0, 0),
                   child: RaisedButton(
                     child: Text('LOGIN'),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0)),
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                     },
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.fromLTRB(15, 40, 0, 0),
                   alignment: Alignment.center,
                   child: RaisedButton(
                     textColor: Colors.white,
                     child: Text('SINUP'),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0)),
                     onPressed: (){
                       final form = _formKey.currentState;
                       if (form.validate()) {
                         form.save();
                         User user = User(Fname: _user['fname'],Lname: _user['lname'],
                             Email: _user['email'],Phone: _user['phone'],Username: _user['username'],Password: _user['password']);
                         final UserEvent event = UserCreate(user);
                         BlocProvider.of<UserBloc>(context).add(event);
                         context
                             .read<LoggedBloc>()
                             .add(loggedEvent.loginStatus);
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                       }
                     },
                   ),
                 ),
               ],
             ),

             Container(
               alignment: Alignment.bottomRight,
             )
           ],

         ),
       ),
     )
     )
    ]));
  }
}
