import 'package:flutter/material.dart';

class journeyBloc{

  Map<String,journey> _journeys;

  Map<String,journey> get journeys => this._journeys;






}




class journey{
  String title;
 List<dateImage> dateImages;
  Icon icon;


  journey({
    @required this.title,
    @required this.dateImages,
    @required this.icon,

});
}


class dateImage{
  DateTime dateTime;
  FileImage fileImage;

  dateImage({
    @required this.dateTime,
    @required this.fileImage,
});

}