import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';
import 'package:flutter_app/widgets/expandableFab.dart';
import 'package:image_picker/image_picker.dart';

class journeyScreen extends StatefulWidget {
  final String journeyUuid;

  @override
  journeyScreen({@required this.journeyUuid});

  _journeyScreenState createState() => _journeyScreenState();
}

class _journeyScreenState extends State<journeyScreen> {
  journeyBloc journey_bloc;
  AppState state;

  File image;

  final ImagePicker _picker = ImagePicker();

  double _currentSliderValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = AppStateContainer.of(context);
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

    return Scaffold(
      backgroundColor: AppColors.background,
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
                image: (image == null ? NetworkImage('https://placeimg.com/900/480/any') : FileImage(image)),
              ),
            ),
            Column(
              children: [
                Spacer(),
                Slider(
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  value: _currentSliderValue,
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 18.0),
                )
              ],
            )
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
                      onPressed: getImageFromCamera,
                      icon: Icon(Icons.camera_alt)),
                  ActionButton(
                      onPressed: getImageFromGallery,
                      icon: Icon(Icons.camera_roll))
                ],
                distance: 112.0,
              ))),
    );
  }
}
