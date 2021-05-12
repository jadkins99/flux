import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter_app/utilities/styles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';
import 'package:flutter_app/widgets/expandableFab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/pages/editScreen.dart';
class journeyScreen extends StatefulWidget {
  final String journeyUuid;

  List<dateImage> dateImages;

  @override
  journeyScreen({@required this.journeyUuid});

  _journeyScreenState createState() => _journeyScreenState();
}

class _journeyScreenState extends State<journeyScreen> {
  journeyBloc journey_bloc;
  AppState state;
  journeyBloc bloc;
  File image;
  int currentImageIndex = 0;
  final ImagePicker _picker = ImagePicker();

  double _currentSliderValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = AppStateContainer.of(context);
    bloc = state.blocProvider.journey_bloc;

    widget.dateImages = bloc.journeys[widget.journeyUuid].dateImages;
  }

  Future<File> getImage(ImageSource src) async {
    final pickedFile = await _picker.getImage(source: src);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    return image;
  }

  Future<File> getImageFromCamera() async {
    return await getImage(ImageSource.camera);
  }

  Future<File> getImageFromGallery() async {
    return await getImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    journey_bloc = AppStateContainer.of(context).blocProvider.journey_bloc;
    var journey = journey_bloc.journeys[widget.journeyUuid];

    print(journey.dateImages);


    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(

        title: Row(
          children: [
            Text(journey.title,
          style: TextStyle(color:AppColors.textColor),),
          Spacer(),
            IconButton(icon: Icon(Icons.more_vert), onPressed: (){
              Navigator.push(context,  CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => editScreen(journeyUuid: widget.journeyUuid,journey: journey,)
              )
              );

            })
        ]
        ),
        backgroundColor: AppColors.appBarColor,

      ),

      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Ink.image(
                fit: BoxFit.cover,
                image: (widget.dateImages.elementAt(currentImageIndex).fileImage),
              ),
            ),
            Column(
              children: [
                Spacer(),
                Row(
                    children: [Text(widget.dateImages.elementAt(currentImageIndex).dateTime.toString())]
                ),
                Slider(
                  min: 0.0,
                  max: (widget.dateImages.length -1 ).toDouble(),
                  divisions: max(widget.dateImages.length - 1, 1),
                  value: _currentSliderValue,
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                      print(_currentSliderValue);
                      currentImageIndex = value.toInt();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 18.0),
                )
              ],
            ),

          ],
        ),
    ),
      floatingActionButton: Opacity(
          opacity: 1.0,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50),
              child: ExpandableFab(
                children: [
                  ActionButton(
                      onPressed: (){

                        Future<File> newImage = getImageFromCamera();


                        newImage.then((value) {
                          if(value != null) {
                            Journey jouney = bloc.journeys[widget.journeyUuid];
                            journey.dateImages.add(dateImage(dateTime: DateTime
                                .now(), fileImage: FileImage(value)));
                            bloc.addOrUpdateJourney(widget.journeyUuid, jouney);


                            // bloc.journeys[widget.journeyUuid].dateImages.add(dateImage(dateTime: DateTime.now(),fileImage: FileImage(value)));
                            setState(() {});
                          }
                        });



                      },
                      icon: Icon(Icons.camera_alt)),
                  ActionButton(
                      onPressed: (){

                      Future<File> newImage = getImageFromGallery();

                      newImage.then((value) {
                        if(value != null) {
                          Journey jouney = bloc.journeys[widget.journeyUuid];
                          journey.dateImages.add(dateImage(dateTime: DateTime
                              .now(), fileImage: FileImage(value)));
                          bloc.addOrUpdateJourney(widget.journeyUuid, jouney);


                          // bloc.journeys[widget.journeyUuid].dateImages.add(dateImage(dateTime: DateTime.now(),fileImage: FileImage(value)));
                          setState(() {});
                        }
                      });



    },

                      icon: Icon(Icons.camera_roll))
                ],
                distance: 112.0,
              ))),
    );
  }
}


