import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';

class IconPicker extends StatefulWidget {
  IconData selectedIcon;

  List<IconData> icons = [
    Icons.accessibility_new,
    Icons.alarm,
    Icons.all_inbox,
    Icons.analytics,
    Icons.article,
    Icons.assignment_turned_in,
    Icons.book,
    Icons.bookmark,
    Icons.build,
    Icons.class_,
    Icons.face,
    Icons.favorite,
    Icons.fingerprint,
    Icons.home,
    Icons.hourglass_full,
    Icons.lock,
    Icons.nightlight_round,
    Icons.brush,
    Icons.code,
    Icons.videogame_asset,
    Icons.pets,
    Icons.pregnant_woman,
    Icons.rowing,

    Icons.park,
    Icons.grass
  ];

  Function callback;

  IconPicker({
    @required this.callback,
    @required this.selectedIcon,
  });

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: AppColors.inputColor, width: 1.0),
              bottom: BorderSide(color: AppColors.inputColor, width: 1.0),
            )),
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      widget.selectedIcon,
                      color: AppColors.inputColor,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),),
                    Text("Pick an icon",
                        style: TextStyle(
                          color: AppColors.inputColor,
                          fontSize: 16.0,
                        ))
                  ],
                ))),
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
          showModalBottomSheet(
              context: context, builder: _buildIconPickerBottomSheet);
        });
  }

  Widget _buildIconPickerBottomSheet(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        for (var icon in widget.icons)
          IconButton(
              onPressed: () {
                setState(() {
                  widget.selectedIcon = icon;
                  widget.callback(icon);
                });
                Navigator.pop(context);
              },
              icon: Icon(icon))
      ],
    );
  }
}
