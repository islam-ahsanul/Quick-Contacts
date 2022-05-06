import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImgaeInput extends StatefulWidget {
  ImgaeInput({
    Key? key,
    required this.onSelectImage,
    required this.fromEdit,
  }) : super(key: key);

  final Function onSelectImage;
  var fromEdit;

  @override
  State<ImgaeInput> createState() => _ImgaeInputState();
}

class _ImgaeInputState extends State<ImgaeInput> {
  var _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: 600,
    );
    // if (imageFile == null) {
    //   return;
    // }
    setState(() {
      _storedImage = File(imageFile!.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 10,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: _storedImage != null
                ? ClipOval(
                    child: Image.file(
                      _storedImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : widget.fromEdit != null
                    ? ClipOval(
                        child: Image.file(
                          widget.fromEdit,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          'assets/images/cont_icon.png',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
            alignment: Alignment.center,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        // ElevatedButton.icon(
        //   onPressed: _takePicture,
        //   icon: Icon(Icons.camera),
        //   label: Text('Take picture'),
        // ),
        IconButton(
          iconSize: 35,
          onPressed: _takePicture,
          icon: Icon(Icons.add_a_photo_rounded),
        ),
      ],
    );
  }
}
