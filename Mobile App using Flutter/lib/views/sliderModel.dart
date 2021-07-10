import 'package:flutter/cupertino.dart';


class SliderModel {
  String _imagePath;
  String _title;
  String _description;

  SliderModel({String imagePath, String title, String description}) {
    this._imagePath = imagePath;
    this._title = title;
    this._description = title;
  }
  String get description => _description;

  setDescription(String value) {
    _description = value;
  }

  String get title => _title;

  setTitle(String value) {
    _title = value;
  }

  String get imagePath => _imagePath;

  setImagePath(String value) {
    _imagePath = value;
  }
}
List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();

  SliderModel sliderModel = new SliderModel();

  sliderModel.setImagePath("assets/meet_company.png");
  sliderModel.setTitle("Meet with your ideal company!!");
  sliderModel.setDescription('In this app you can see thousands of companies from around the world.');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("Don't forget to subscribe");
  sliderModel.setDescription("Thank you for joining us.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("Enjoy!!!");
  sliderModel.setDescription("");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  return slides;
}
List<SliderModel> getCatagorySlider(){
  List<SliderModel> slides = new List<SliderModel>();

  SliderModel sliderModel = new SliderModel();
  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("Thanks for reading");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("Health Care");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("Restorants");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.setImagePath('assets/search_company.png');
  sliderModel.setTitle("School");
  slides.add(sliderModel);
return slides;
}
