import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/search/bloc.dart';
import 'package:online_customer_care/models/company.dart';
import 'package:online_customer_care/models/models.dart';
import 'package:online_customer_care/repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  final SearchRepository searchRepositoryr;
  SearchBloc({@required this.searchRepositoryr}):
      assert(searchRepositoryr != null), super(SearchLoading());
  @override
  Stream<SearchState>mapEventToState(SearchEvent event) async*{
    if(event is SearchLoad){
      yield SearchLoadSuccess();
    }

    if (event is SearchByServ) {
      try {
        await searchRepositoryr.searchByService(event.i);
        final List<Company> companies = await searchRepositoryr.searchByService(event.i);
        yield SearchLoadSuccess(companies,null);
      } catch (_) {
        yield SearchOperationFailure();
      }
    }
    if(event is SearchByComp){
      try{
        final List<Service> services = await searchRepositoryr.searchByCompany(event.i);
        yield SearchLoadSuccess(null,services);

      }catch(_){
        yield SearchOperationFailure();
      }
    }

  }
}