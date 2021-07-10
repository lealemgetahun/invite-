import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:online_customer_care/bloc/service/bloc.dart';


import 'company.dart';

import 'sliderModel.dart';

class HomeContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<SliderModel> slides = new List<SliderModel>();
  int _currentIndex = 0;
  int _count = 7;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getCatagorySlider();
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(7),
          margin: EdgeInsets.fromLTRB(5, 25, 0, 0),
          child: Text(
            'Find Your Company',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
          ),
        ),
        Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 50.0),
                margin: EdgeInsets.fromLTRB(25, 160, 25, 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white)),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 170, 0, 25),
                child: Icon(
                  Icons.search,
                  size: 30,
                )),
          ],
        ),
        Container(
            margin: EdgeInsets.fromLTRB(90, 230, 0, 0),
            child: Text('Catagories',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
        Container(
          height: 600,
          margin: EdgeInsets.fromLTRB(5, 270, 5, 25),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18),
              color: Colors.deepOrange),
          child: Stack(children: <Widget>[
            PageView.builder(
              controller: pageController,
              onPageChanged: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              itemBuilder: (context, index) {
                return BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (_, state) {
                    if (state is ServiceOperationFailure) {
                      return Text(
                        'Could not do course operation',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    if (state is ServiceLoadSuccess) {
                      final services = state.serv;
                      print("..............................id at home.......${services[index].id}");
                      //_count = services.length;
                      return Stack(
                        ///margin: EdgeInsets.fromLTRB(5, 270, 0, 25),
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Card(
                            child: GestureDetector(
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/${services[index].Image}",
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Text(
                                      services[index].Name,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {


                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompanyListD(id: services[index].id,),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(75, 2, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < services.length; i++)
                                  if (i == _currentIndex) ...[
                                    circleBar(true)
                                  ] else
                                    circleBar(false),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                );
              },
              itemCount: _count,
            )
          ]),
        )
      ],
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.deepOrange : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
