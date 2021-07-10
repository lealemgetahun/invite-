import 'package:equatable/equatable.dart';

class Comment extends Equatable{
   int ID;
   int comp_id;
   int Rate;
   String Username;
   String Message;


  Comment ({this.ID, this.comp_id,this.Rate,this.Username,this.Message,});
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  commentToJson(Comment comment) => _$CommentToJson(comment);

  @override
  List<Object> get props => [ID,comp_id,Rate,Username,Message];
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      ID: json['ID'] ,
      comp_id: json['Comp_id'] ,
      Rate: json['Rate'],
      Message: json['Message'] ,
      Username: json['Username'] as String,

  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'Comp_id': instance.comp_id,
      'Message': instance.Message,
      'Rate': instance.Rate,
      'Username': instance.Username,


    };
