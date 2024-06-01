import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImageUploadScreen'),
      ),
      body: Row(
        children: [
          Container(
            height: 200,
            width: 200,
            child: ImagePickerWidget(),
          )
        ],
      ),
    );
  }
}
