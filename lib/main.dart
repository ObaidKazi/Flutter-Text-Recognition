import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(TextRecoginition()  );

class TextRecoginition extends StatefulWidget{
  @override
 createState()=>_TextRecognition();
}
class  _TextRecognition extends State<TextRecoginition> {
  File _imageFile;
  var _getText;
  void _getImagesAndDetectText() async{
    final imageFile=await ImagePicker.pickImage(source: ImageSource.gallery); 
    final image=FirebaseVisionImage.fromFile(imageFile);
    final textrec=FirebaseVision.instance.textRecognizer();
    final gettext=await textrec.processImage(image);
    setState(() {
     _imageFile=imageFile;
     _getText=gettext.text;
     });
    
  }

  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
      appBar: AppBar(
        title: Text("Text Recognition"),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('No image selected.')
            : Text(_getText),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImagesAndDetectText,
        tooltip: 'Pick an Image',
        child: Icon(Icons.add_a_photo),
      ),
    )
  );
  }
  
}

