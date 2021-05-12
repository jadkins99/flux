import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/database.dart';
import 'package:uuid/uuid.dart';

class journeyBloc{

  Map<String,journey> _journeys;
  DatabaseFileRoutines databaseFileRoutines;

  bool initialized = false;

  List<Future<Map<String, journey>>> futures;

  Map<String,journey> get journeys => this._journeys;

  @override
  journeyBloc() {
    this.futures = [];
    this._journeys = new Map<String, journey>();
    this.databaseFileRoutines = DatabaseFileRoutines();
  }

  Future<Map<String, journey>> getJourneys() async {

  }

  addOrUpdateJourney(String uuid, journey journey) {

    this._journeys[uuid] = journey;
  }




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