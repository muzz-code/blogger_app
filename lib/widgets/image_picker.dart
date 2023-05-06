import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function pickImage;

  ImagePickerWidget({required this.pickImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () => pickImage(),
          icon: const Icon(Icons.photo_camera),
          label: const Text('Pick Image'),
        ),
      ],
    );
  }
}
