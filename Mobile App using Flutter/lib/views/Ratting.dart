import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/comment/bloc.dart';
import 'package:online_customer_care/bloc/user/bloc.dart';
import 'package:online_customer_care/models/comment.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:quick_feedback/quick_feedback.dart';

class Ratting extends StatefulWidget{
  final int maxRate;
  final Company company;

  Ratting([this.maxRate = 5,this.sate,this.company]);
  bool sate;

  @override
  State<StatefulWidget> createState()=> _RattingState();
  }

class _RattingState extends State<Ratting> {

  Widget _buildStar(int index){
    return Icon(Icons.star_border,size: 20,);
  }

  Widget _buildBody(String name){

    final stars = List<Widget>.generate(this.widget.maxRate, (index){
      return GestureDetector(
        child: _buildStar(index),

        onTap: (){
          widget.sate?
           _showFeedback(context,name)
          :Text("Please Log in");
        },
      );
    });
    return Row(
      children: <Widget>[
        Row(
          children: stars,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserBloc,UserState>(builder: (context,state){
      if(state is UserLoadSuccess){

        return _buildBody(state.user[0].Username);
      }return CircularProgressIndicator();
    });

  }

  void _showFeedback(context,String name) {
    showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a comment', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
          'Comment', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) {
            print('$feedback');
            //TODO: add event
           // map { rating: some number, feedback: 'some feedback' }
            Comment c =  Comment(
              comp_id: widget.company.ID,
              Message: feedback['feedback'] as String,
              Rate: feedback['rating'] as int,
              Username: name
            );
            final CommentEvent event = CommentCreate(c);
            BlocProvider.of<CommentBloc>(context).add(event);
            Navigator.of(context).pop();
          },
          askLaterText: 'ASK LATER',
//          onAskLaterCallback: () {
//             //TODO: CLEAR COMMENT
//          },
        );
      },
    );
  }
}

