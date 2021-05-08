import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class journeyBloc{

  Map<String,journey> _journeys;

  Map<String,journey> get journeys => this._journeys;

  @override
  journeyBloc() {
    this._journeys = new Map<String, journey>();

    // TODO: REMOVE THIS! TESTING ONLY
    this._journeys["BS"] = journey(title: "BS", dateImages: <dateImage>[], icon: Icon(Icons.description));
    this._journeys["CS"] = journey(title: "CS", dateImages: <dateImage>[], icon: Icon(Icons.computer));
  }


  String addJourney(journey journey, [String uuid]) {
    // if this is a new journey, no uuid will be provided
    uuid = uuid ?? Uuid().v4();
    _journeys[uuid] = journey;
    return uuid;
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