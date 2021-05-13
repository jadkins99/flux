import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/database.dart';
import 'package:uuid/uuid.dart';
import 'package:rxdart/rxdart.dart';

class journeyBloc {

  Map<String,Journey> _journeys;
  Future<Map<String,Journey>> futureJourneys;
  DatabaseFileRoutines databaseFileRoutines;

// outputs
  StreamController journeyNotifier = BehaviorSubject<bool>();
  
  Stream<bool> get journeyNotification => journeyNotifier.stream;

  bool initialized = false;

  List<Future<Map<String, Journey>>> futures;

  Map<String,Journey> get journeys => this._journeys;

  @override
  journeyBloc() {
    this.futures = [];
    this._journeys = new Map<String, Journey>();
    this.databaseFileRoutines = DatabaseFileRoutines();
    
    futureJourneys = databaseFileRoutines.getJourneys();
    
    futureJourneys.then((value) {
      print("value: "+ value.toString());
      if (value!= null) {
        this._journeys = value;
      }
        this.initialized = true;
        this.journeyNotifier.add(true);

      
    });

  }
  
  
  

  
  close(){
    journeyNotifier.close();
  }
  
  /*Future<Map<String, journey>> getJourneys() async {
    return this._journeys;
  }*/

  addOrUpdateJourney(String uuid, Journey journey) {
    this._journeys[uuid] = journey;
    databaseFileRoutines.saveJourney(uuid,journey);
    journeyNotifier.add(true);
    
  }




}




class Journey{
  String title;
 List<dateImage> dateImages;
  Icon icon;


  Journey({
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