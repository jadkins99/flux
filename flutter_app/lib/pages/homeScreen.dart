import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/journeyScreen.dart';
import 'package:flutter_app/pages/newJourneyScreen.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
              journeyCard(uuid: "BS"),
              journeyCard(uuid: "CS"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openNewJourneyScreen(
            context: context,
            fullScreen: false,
          );
        },
        child: Icon(Icons.add_outlined, color: AppColors.plusColor),
        backgroundColor: AppColors.floatingActionButtonColor,
      ),
    );
  }

  void _openNewJourneyScreen({BuildContext context, bool fullScreen}) {
    Navigator.push(
        context,
        // was material route!!! Using Cupertino is apparently not advisable
        CupertinoPageRoute(
            fullscreenDialog: fullScreen,
            builder: (context) => newJourneyScreen()
        )
    );
  }
}

class journeyCard extends StatefulWidget {
  String uuid;
  journeyCard({
    @required this.uuid,
  });

  @override
  _journeyCardState createState() => _journeyCardState();
}

class _journeyCardState extends State<journeyCard> {
  @override
  Widget build(BuildContext context) {
    journeyBloc journey_bloc =
        AppStateContainer.of(context).blocProvider.journey_bloc;
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://placeimg.com/900/480/any'),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.rice_bowl),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: Text("test", style: TextStyle(fontSize: 16.0))
                        )]
                ),
                )],
            ),
            onTap: () {
              // open the journey for this
              _openJourneyScreen(
                journeyUuid: widget.uuid,
                context: context,
                fullScreen: false,
              );
            },
          )),
    );
  }

  void _openJourneyScreen({String journeyUuid, BuildContext context, bool fullScreen}) {
    Navigator.push(
        context,
        // was material route!!! Using Cupertino is apparently not advisable
        CupertinoPageRoute(
          fullscreenDialog: fullScreen,
          builder: (context) => journeyScreen(journeyUuid: journeyUuid)
        )
    );
  }
}
