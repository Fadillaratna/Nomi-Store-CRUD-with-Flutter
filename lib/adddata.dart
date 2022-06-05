import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();
  TextEditingController controllerImage = new TextEditingController();

  void addData() {
    var url = "http://localhost/PHP-REST-API/adddata.php";
    http.post(Uri.parse(url), body: {
      "itemcode": controllerCode.text,
      "itemname": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text,
      "itemimage": controllerImage.text,
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: controllerCode,
                  decoration: new InputDecoration(hintText: "Item Code", labelText: "Item Code"),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(hintText: "Item Name", labelText: "Item Name"),
                ),
                new TextField(
                  controller: controllerPrice,
                  decoration: new InputDecoration(hintText: "Price", labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                new TextField(
                  controller: controllerStock,
                  decoration: new InputDecoration(hintText: "Stock", labelText: "Stock"),
                  keyboardType: TextInputType.number,
                ),
                new TextField(
                  controller: controllerImage,
                  decoration: new InputDecoration(hintText: "Image", labelText: "Image"),
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
