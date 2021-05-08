import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';

class journeyScreen extends StatefulWidget {
  @override

  journeyScreen({
  @required String journeyUuid
  });

  _journeyScreenState createState() => _journeyScreenState();
}

class _journeyScreenState extends State<journeyScreen> {
  journeyBloc journey_bloc;
  AppState state;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = AppStateContainer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    journey_bloc = state.blocProvider.journey_bloc;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("flux"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_outlined, color: AppColors.plusColor),
        backgroundColor: AppColors.floatingActionButtonColor,
      ),
    );
  }
}