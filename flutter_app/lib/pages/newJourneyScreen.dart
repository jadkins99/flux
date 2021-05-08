import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';
import 'package:flutter_app/widgets/coloredTextField.dart';
import 'package:flutter_app/widgets/iconPicker.dart';

class newJourneyScreen extends StatefulWidget {
  @override
  newJourneyScreen({@required String journeyUuid});

  _newJourneyScreenState createState() => _newJourneyScreenState();
}

class _newJourneyScreenState extends State<newJourneyScreen> {
  journeyBloc journey_bloc;
  AppState state;

  final journeyNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = AppStateContainer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    journey_bloc = state.blocProvider.journey_bloc;

    IconData newJourneyIcon = Icons.image;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Start a new Journey"),
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
                        controller: journeyNameController),
                    Padding(padding: EdgeInsets.all(12.0)),
                    IconPicker(callback: (icon) {
                      newJourneyIcon = icon;
                    },)
                  ],
                ),
              ),
              MaterialButton(
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  color: AppColors.inputColor,
                  onPressed: () {
                    // make a new, empty journey and submit it to the bloc
                    
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
