import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/company/company_event.dart';
import 'package:online_customer_care/bloc/company/company_state.dart';
import 'package:online_customer_care/repositories/company_repository.dart';

class CompanyBloc extends Bloc<CompanyEvent,CompanyState>{
  final CompanyRepository cr;
  CompanyBloc({@required this.cr}):
      assert(cr != null), super(CompanyLoading());
  @override
  Stream<CompanyState>mapEventToState(CompanyEvent event) async*{
    if(event is CompanyLoad){
      yield CompanyLoading();
      try{
        final comp = await cr.getCompanyList();
        yield CompanyLoadSuccess(comp);

      }catch(_){
        yield CompanyOperationFailure();
      }
    }
    if(event is CompanyUpdate){
      try{
        await cr.updateCompany(event.company);
        final company = await cr.getCompanyList();
        yield CompanyLoadSuccess(company);
      }catch(_){
        yield CompanyOperationFailure();
      }
    }
    if (event is CompanyCreate) {
      try {
        await cr.createCompany(event.company);
        final company = await cr.getCompanyList();
        yield CompanyLoadSuccess(company);
      } catch (_) {
        yield CompanyOperationFailure();
      }
    }
    if (event is CompanyDelete) {
      try {
        await cr.deleteCompany(event.company.ID);
        final company = await cr.getCompanyList();
        yield CompanyLoadSuccess(company);
      } catch (_) {
        yield CompanyOperationFailure();
      }
    }

  }
}