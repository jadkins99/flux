import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class firstImagePicker extends StatefulWidget {
  Function callback;

  firstImagePicker({
    @required this.callback

});

  @override
  _firstImagePickerState createState() => _firstImagePickerState();
}

class _firstImagePickerState extends State<firstImagePicker> {


  File image;
  final ImagePicker _picker = ImagePicker();

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

  Widget _buildImagePickerBottomSheet(BuildContext context) {
    return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Camera Roll'),
          onPressed: () {
          Future<File> image = getImageFromGallery();
          image.then((File image){
          widget.callback(image);
          Navigator.pop(context);
          }); }

          ),
          CupertinoActionSheetAction(
              child: Text('Camera'),
            onPressed: () {
             Future<File> image = getImageFromCamera();
              image.then((File image){
                widget.callback(image);
                Navigator.pop(context);
              });

            }
    )
    ]

    );
    }





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

                    Padding(padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),),
                    Text("Start your journey",
                        style: TextStyle(
                          color: AppColors.inputColor,
                          fontSize: 16.0,
                        ))
                  ],
                ))),
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
          showModalBottomSheet(
              context: context, builder: _buildImagePickerBottomSheet);
        });
  }
}







