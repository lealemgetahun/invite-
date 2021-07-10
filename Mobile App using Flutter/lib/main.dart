import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_customer_care/bloc/user/bloc.dart';
import 'package:online_customer_care/data_provider/comment_data.dart';
import 'package:online_customer_care/repositories/comment_repository.dart';
import 'package:online_customer_care/repositories/company_repository.dart';
import 'package:online_customer_care/repositories/repositories.dart';
import 'package:online_customer_care/repositories/search_repository.dart';
import 'package:online_customer_care/repositories/service_repository.dart';
import 'package:online_customer_care/views/LogIn.dart';
import 'package:online_customer_care/views/course_route.dart';
import 'bloc/comment/comment_bloc.dart';
import 'bloc/comment/comment_event.dart';
import 'bloc/company/company_bloc.dart';
import 'bloc/company/company_event.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/search/search_event.dart';
import 'bloc/service/service_bloc.dart';
import 'bloc/service/service_event.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc_observer.dart';
import 'data_provider/company_data.dart';
import 'data_provider/search_data.dart';
import 'data_provider/service_data.dart';
import 'data_provider/user_data.dart';

void main() {
  final CompanyRepository companyRepository = CompanyRepository(
    dataProvider: CompanyDataProvider(),
  );
  final ServiceRepository serviceRepository = ServiceRepository(
    dataProvider: ServiceDataProvider(),
  );
  final SearchRepository searchRepository = SearchRepository(
      dataProvider: SearchDataProvider()
  );
  final UserRepository userRepository = UserRepository(
      dataProvider: UserDataProvider()
  );
  final CommentRepository commentRepository = CommentRepository(dataProvider: CommentDataProvider());
  runApp(MyApp(
    companyRepository: companyRepository,
    serviceRepository: serviceRepository,
    searchRepository: searchRepository,
    userRepository: userRepository,
    commentRepository: commentRepository,
  ));
}

class MyApp extends StatelessWidget {
  final CompanyRepository companyRepository;
  final ServiceRepository serviceRepository;
  final SearchRepository searchRepository;
  final UserRepository userRepository;
  final CommentRepository commentRepository;

  MyApp({@required this.companyRepository,
    @required this.serviceRepository,
    @required this.searchRepository,
    @required this.userRepository,      //TODO null assertion//
    @required this.commentRepository}) : assert(companyRepository != null && serviceRepository != null);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<CompanyBloc>(
            create: (context) =>
            CompanyBloc(cr: companyRepository)..add(CompanyLoad(),)
        ),
        BlocProvider<ServiceBloc>(
          create: (context) =>
          ServiceBloc( sr: this.serviceRepository)..add(ServiceLoad()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) =>
          SearchBloc( searchRepositoryr: this.searchRepository)..add(SearchLoad())),
        BlocProvider<UserBloc>(
            create: (context) =>
            UserBloc(userRepository: this.userRepository)..add(UserLoad())),
        BlocProvider<CommentBloc>(
            create: (context) =>
            CommentBloc(cr: this.commentRepository)..add(CommentLoad())),
        BlocProvider<LoggedBloc>(
          create: (context) => LoggedBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Course App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: CourseAppRoute.generateRoute,
      ),

    );
  }
}

