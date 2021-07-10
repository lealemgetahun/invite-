import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/company/bloc.dart';
import 'package:online_customer_care/models/company_argument.dart';
import 'package:online_customer_care/models/models.dart';
import 'package:online_customer_care/views/AdminCompanyList.dart';
import 'package:online_customer_care/views/ClipedHead.dart';


class AddAndUpdateCompany extends StatefulWidget {
  CompanyArgument args;
  AddAndUpdateCompany(this.args);
  @override
  _AddAndUpdateCompanyState createState() => _AddAndUpdateCompanyState();
}

class _AddAndUpdateCompanyState extends State<AddAndUpdateCompany> {
  final _formKey = GlobalKey<FormState>();

  final Map<String,dynamic> _company = {};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(children: [
          WavyHeader(),
          Container(
            margin: EdgeInsets.fromLTRB(120, 140, 0, 0),
            child: Text('${widget.args.edit ? "Edit Company" : "Add Company"}'),
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
                          initialValue: widget.args.edit? widget.args.c.FullName : '',
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter company name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText:'Company Name'
                          ),
                          onSaved: (value)=>{
                            setState(() {
                              this._company["FullName"] = value;
                            },
                            )}
                      ),
                      TextFormField(
                        cursorColor: Colors.deepOrange,
                        initialValue: widget.args.edit? widget.args.c.Logo : '',
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter logo';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText:'Logo'
                        ),
                        onSaved: (value)=>{
                          setState(()=>{
                              this._company["Logo"] = value
                          })
                        },
                      ),
                      TextFormField(
                        cursorColor: Colors.deepOrange,
                        initialValue: widget.args.edit? widget.args.c.Email : '',
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
                            this._company["Email"] = value
                          })
                        },
                      ),
                      TextFormField(
                        cursorColor: Colors.deepOrange,
                        initialValue: widget.args.edit? widget.args.c.Phone : '',
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
                            this._company["Phone"] = value
                          })
                        },
                      ),
                      TextFormField(
                        cursorColor: Colors.deepOrange,
                        initialValue: widget.args.edit? widget.args.c.Moto : '',
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter moto';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText:'Moto'
                        ),
                        onSaved: (value)=>{
                          setState(()=>{
                            this._company["Moto"] = value
                          })
                        },
                      ),
                      TextFormField(
                        cursorColor: Colors.deepOrange,
                        initialValue: widget.args.edit? widget.args.c.Address : '',
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter Address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText:'Address'
                        ),
                        onSaved: (value)=>{
                          setState(()=>{
                            this._company["Address"] = value
                          })
                        },
                      ),

                      Container(
                        alignment: Alignment.center,
                        child: RaisedButton(
                          textColor: Colors.white,
                          child: Text('ADD'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                         onPressed: (){
                            final form = _formKey.currentState;
                            if(form.validate()){
                              form.save();
                              if(widget.args.edit == true){
                                final Company c = new Company(ID: widget.args.c.ID,FullName:this._company["FullName"],Logo: this._company["Logo"],Email: this._company["Email"],Phone: this._company["Phone"],Moto: this._company["Moto"],Address: this._company["Address"]);
                                final CompanyEvent event =  CompanyUpdate(c);
                                BlocProvider.of<CompanyBloc>(context).add(event);
                              }else{
                                final Company c = Company(FullName:this._company["FullName"],Logo: this._company["Logo"],Email: this._company["Email"],Phone: this._company["Phone"],Moto: this._company["Moto"],Address: this._company["Address"]);
                                final CompanyEvent event = CompanyCreate(c);
                                BlocProvider.of<CompanyBloc>(context).add(event);
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return AdminCompanyList();
                              }));
                            }

                         },
                        ),
                      )
                    ],
                  ),
                ),
              )
          )
        ]));
  }
}
