import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';
import 'package:flutter_app/widgets/coloredTextField.dart';
import 'package:flutter_app/widgets/firstImagePicker.dart';
import 'package:flutter_app/widgets/iconPicker.dart';
import 'package:uuid/uuid.dart';

import 'dart:io';

import 'journeyScreen.dart';

class editScreen extends StatefulWidget {
  String journeyUuid;
  Journey journey;
  @override
  editScreen({@required  this.journeyUuid,@required this.journey});

  _editScreenState createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  journeyBloc journey_bloc;
  AppState state;
  IconData iconPicked;

  final titleController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = AppStateContainer.of(context);
    titleController.text = widget.journey.title;
  }

  @override
  Widget build(BuildContext context) {
    journey_bloc = state.blocProvider.journey_bloc;
    //titleController.text = widget.journey
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "Edit " + widget.journey.title,
          style: TextStyle(color:AppColors.textColor),),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 12.0,
                  ),
                ),
                child: Column(
                  children: [
                    ColoredTextField(
                        label: "Journey Name",
                        color: Colors.blue,
                        controller: titleController),
                    Padding(padding: EdgeInsets.all(12.0)),
                    IconPicker(
                      selectedIcon: widget.journey.icon.icon,
                      callback: (icon) {

                      iconPicked = icon;
                    },),
                    Padding(padding: EdgeInsets.all(12.0)),

                  ],
                ),
              ),
              MaterialButton(
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  color: AppColors.inputColor,
                  onPressed: () {
                    String uuid = widget.journeyUuid;
                    journey_bloc.addOrUpdateJourney(uuid, Journey(title: titleController.text, dateImages:
                    widget.journey.dateImages,icon: Icon(iconPicked)));


                    Navigator.pop(context);
                    Navigator.pop(context);

                  })
            ]),
      ),
    );
  }

  Row _makeDescription(String description) {
    return Row(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
          child: Text(description,
              style: TextStyle(
                  color: AppColors.displayTextColor, fontSize: 16)))
    ]);
  }
}
