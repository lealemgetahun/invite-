

import 'package:flutter/material.dart';
import 'package:online_customer_care/views/sliderModel.dart';

import 'ClipedHead.dart';

class WalkTHrough extends StatefulWidget {
  @override
  _WalkTHroughState createState() => _WalkTHroughState();
}
class _WalkTHroughState extends State<WalkTHrough> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {

    super.initState();
    slides = getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.deepOrange : Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        itemBuilder: (context, index) {
          return SliderTile(
            imageAssetPath: slides[index].imagePath,
            title: slides[index].title,
            description: slides[index].description,
          );
        },
        itemCount: slides.length,
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  slides.length - 1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                );
              },
              child: Text("SKIP"),
            ),
            Row(
              children: <Widget>[
                for(int i = 0; i < slides.length; i++)
                  currentIndex == i
                      ? pageIndexIndicator(true)
                      : pageIndexIndicator(false)
              ],
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(
                  currentIndex + 1,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                );
              },
              child: Text("NEXT"),
            ),
          ],
        ),
      )
          : Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: Colors.deepOrange,
          child: GestureDetector(
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, '/home');
            },
          )
      ),
    );
  }
}

class SliderTile extends StatelessWidget {
  //initialising variables here
  String imageAssetPath;
  String title;
  String description;

  SliderTile({this.imageAssetPath, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      // TODO FIX HEIGHT height: 50,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WavyHeader(),
          Image.asset(imageAssetPath, height: 200),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
