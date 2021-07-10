
import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:online_customer_care/models/models.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();
}

class SearchLoad extends SearchEvent{
  const SearchLoad();

  @override
  List<Object> get props => [];

}
class SearchByServ extends SearchEvent{
  //final Company company;
  final int i;
  const SearchByServ(this.i);

  @override
  List<Object> get props => [i];

}
class SearchByComp extends SearchEvent{
  final int i;
  const SearchByComp(this.i);

  @override

  List<Object> get props => [i];


}

