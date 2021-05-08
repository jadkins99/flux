import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
import 'package:flutter_app/blocs/app_state.dart';

class journeyScreen extends StatefulWidget {
  final PageController pageController = PageController();

  final String journeyUuid;

  @override
  journeyScreen({
    @required this.journeyUuid
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
    journey_bloc = AppStateContainer.of(context).blocProvider.journey_bloc;

    print(widget.journeyUuid);
    if (journey_bloc.journeys[widget.journeyUuid].dateImages.isEmpty) {
      // there are not yet any images associated with this Journey,
      // so jump straight to the new image screen
      WidgetsBinding.instance
          .addPostFrameCallback((duration) {widget.pageController.jumpToPage(1);});
    }

    return PageView(
      controller: widget.pageController,
      children: [
        journeySlideshowScreen(journeyUuid: widget.journeyUuid),
        journeyAddNewImageScreen(journeyUuid: widget.journeyUuid)
    ],);
  }
}

class journeySlideshowScreen extends StatefulWidget {
  final String journeyUuid;

  @override
  journeySlideshowScreen({
    @required this.journeyUuid
  });


  @override
  _journeySlideshowScreenState createState() => _journeySlideshowScreenState();
}

class _journeySlideshowScreenState extends State<journeySlideshowScreen> {
  journeyBloc journey_bloc;

  @override
  Widget build(BuildContext context) {
    journey_bloc = AppStateContainer.of(context).blocProvider.journey_bloc;
    var journey = journey_bloc.journeys[widget.journeyUuid];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}

class journeyAddNewImageScreen extends StatelessWidget {
  final String journeyUuid;
  journeyBloc journey_bloc;

  @override
  journeyAddNewImageScreen({
    @required this.journeyUuid
  });


  @override
  Widget build(BuildContext context) {
    // fetch journey
    journey_bloc = AppStateContainer.of(context).blocProvider.journey_bloc;
    var journey = journey_bloc.journeys[this.journeyUuid];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Add a new image to " + journey.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}

