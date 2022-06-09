// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import './main.dart';
import 'package:http_parser/http_parser.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerJenis = new TextEditingController();
  TextEditingController controllerNamaPaket = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerIdOutlet = new TextEditingController();
  // Future<File> _image;
  // final picker = ImagePicker();
  
late var _image; 

  //PROBLEM disni
  Future getImage(media) async {
    var img = await ImagePicker().pickImage(source: media);
    setState(() {
      _image = img;
    });
  }
  
  // choiceImage() {
  //   // var pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   // String img = pickedImage.path;
  //   setState((){
  //     file = ImagePicker().pickImage(source: ImageSource.gallery);
  //   });
  // }

  
  // File? image;

  // Future getImage() async {
  //   // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   var image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
  //   // final selectedImage = File(image.path);
  //   setState(() {
  //     this.image = image;
  //   });
  // }

  //  _pilihGallery() async {
  //   var image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
  //   setState(() {
  //     controllerImage : image;
  //   });
  // }
  

  void addData() async {
    var url = "http://localhost:8080/paket/";
    var request = new http.MultipartRequest("POST", Uri.parse(url)); 
    // body: {
    //   "jenis": controllerJenis.text,
    //   "nama_paket": controllerNamaPaket.text,
    //   "harga": controllerHarga.text,
    //   "image": _image,
    //   "id_outlet": controllerIdOutlet.text,
    // });
    request.fields["jenis"] = controllerJenis.text;
    request.fields["nama_paket"] = controllerNamaPaket.text;
    request.fields["harga"] = controllerHarga.text;
    request.files.add(new http.MultipartFile.fromBytes(_image, await File.fromUri(Uri.parse("<path/to/file>")).readAsBytes(), contentType: new MediaType('image', 'png')));
  }

  
  @override
  Widget build(BuildContext context) {
    // var placeholder = "Image"
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD DATA"),
        backgroundColor: Colors.indigo
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerNamaPaket,
                  decoration: new InputDecoration(hintText: "Package Name", labelText: "Package Name"),
                ),
                new TextField(
                  controller: controllerHarga,
                  decoration: new InputDecoration(hintText: "Price", labelText: "Price"),
                ),
                new TextField(
                  controller: controllerJenis,
                  decoration: new InputDecoration(hintText: "Category", labelText: "Category"),
                  keyboardType: TextInputType.number,
                ),
                new TextField(
                  controller: controllerIdOutlet,
                  decoration: new InputDecoration(hintText: "Outlet", labelText: "Outlet"),
                  keyboardType: TextInputType.number,
                ),
                
                IconButton(
                  icon: Icon(Icons.image), 
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
                
                
                new Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                ),
                new RaisedButton(
                  child: new Text("SAVE"),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new Home()));
                  },
                  shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0))
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
