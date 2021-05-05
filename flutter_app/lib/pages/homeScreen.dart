import 'package:flutter/material.dart';
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

      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},

        child: Icon(Icons.add_outlined,
        color: AppColors.plusColor),
        backgroundColor: AppColors.floatingActionButtonColor,

      ),

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
    journeyBloc journey_bloc = AppStateContainer.of(context).blocProvider.journey_bloc;
    return Container(
      margin:EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            //children: [Image(image: journey_bloc.journeys[widget.uuid].dateImages[0].fileImage)],
            child: Image(image: NetworkImage('https://placeimg.com/640/480/any'),
                // width: 300,
                //height: 150,
                fit:BoxFit.fill),
            ),
            Row(
              children: <Widget>[Icon(Icons.rice_bowl),Text("test")],
            ),
          ],
        ),)
      ),
    );
  }
}

