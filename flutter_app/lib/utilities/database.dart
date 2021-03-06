

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // Filesystem locations
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseFileRoutines {

  static final _databaseName = "JourneyData.db";

  static final journeyTable = "journey";
  static final dateImagesTable = "dateImage";

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<Database> _initDatabase() async {
    var dir = await _localPath;
    String path = join(dir, _databaseName);
    return await openDatabase(path, onCreate: _onCreate,version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $journeyTable (
            id TEXT NOT NULL PRIMARY KEY,
            title TEXT NOT NULL,
            icon INTEGER NOT NULL
          );
          ''');

    await db.execute('''          
          CREATE TABLE $dateImagesTable (
            date TEXT NOT NULL,
            image_path TEXT NOT NULL PRIMARY KEY,
            journey_id TEXT NOT NULL,
            FOREIGN KEY (journey_id) REFERENCES $journeyTable(id)
          );
   ''');
  }
  
  Future<void>  saveJourney(String uuid, Journey saveJourney) async {
    int icon = saveJourney.icon.icon.codePoint;
    String title = saveJourney.title;
    Database db = await database;
    await db.rawQuery('''
    INSERT OR REPLACE INTO  $journeyTable(id,title,icon) VALUES ('$uuid','$title',$icon);
    ''');

    /*await db.rawQuery('''
      EXISTS(SELECT * FROM $journeyTable WHERE id = $uuid)
        UPDATE $journeyTable SET title = $title, icon = $icon WHERE id = $uuid
      ELSE
        INSERT INTO $journeyTable (id, title, icon) VALUES ($uuid, $title, $icon);
    ''');*/
    for (dateImage di in saveJourney.dateImages) {
      String date = di.dateTime.toString();
      String imagePath = di.fileImage.file.path;
      await db.rawQuery('''
        INSERT OR REPLACE INTO  $dateImagesTable(journey_id,date,image_path) VALUES ('$uuid','$date','$imagePath');
      ''');
      /*await db.rawQuery('''
        NOT EXISTS(SELECT * FROM $dateImagesTable WHERE journey_id = $uuid AND date = $date)
          INSERT INTO $dateImagesTable (date, image_path, journey_id) VALUES ($date, $imagePath, $uuid);
      ''');*/
    }
  }

  Future<Map<String, Journey>> getJourneys() async {
    Map<String, Journey> journeys = {};
    Database db = await database;
    List<Map> journeyMaps = await db.rawQuery('SELECT id FROM $journeyTable');
    print("list of maps (journeyMaps): " + journeyMaps.toString());
    for (Map journeyMap in journeyMaps) {
      print(journeyMap.values.elementAt(0));
      String uuid = journeyMap.values.elementAt(0);
      Journey currentJourney = await _getJourney(uuid);
      journeys[uuid] = currentJourney;
    }
    return journeys;
  }

  Future<Journey> _getJourney(String uuid) async {
    Database db = await database;
    List<Map> journeys = await db.rawQuery("SELECT * FROM $journeyTable WHERE id = '$uuid' "); // should have one value returned in map
    List<Map> dateImagesPairs = await db.rawQuery("SELECT * FROM $dateImagesTable WHERE journey_id = '$uuid' "); // can have many
    Map journeyMap = journeys.elementAt(0);
    String title = journeyMap["title"];

    Icon icon = Icon(IconData(journeyMap["icon"],fontFamily: "MaterialIcons"));
    List<dateImage> dateImages = [];
    for (Map dateImagePair in dateImagesPairs) {
      dateImages.add(dateImage(
        dateTime: DateTime.parse(dateImagePair["date"]),
        fileImage: FileImage(File(dateImagePair["image_path"]))
      ));
    }
    return Journey(title: title, icon: icon, dateImages: dateImages);
  }

}