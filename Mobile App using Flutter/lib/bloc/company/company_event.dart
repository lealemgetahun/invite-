
import 'package:equatable/equatable.dart';
import 'package:online_customer_care/models/company.dart';

abstract class CompanyEvent extends Equatable{
  const CompanyEvent();
}
class CompanyLoad extends CompanyEvent{
  const CompanyLoad();

  @override
  List<Object> get props => [];

}
class CompanyCreate extends CompanyEvent{
  final Company company;
  const CompanyCreate(this.company);

  @override
  List<Object> get props => [company];

}
class CompanyUpdate extends CompanyEvent{
  final Company company;
  const CompanyUpdate(this.company);

  @override
  List<Object> get props => [company];
}
class CompanyDelete extends CompanyEvent{
  final Company company;
  const CompanyDelete(this.company);

  @override
  List<Object> get props => [company];

}