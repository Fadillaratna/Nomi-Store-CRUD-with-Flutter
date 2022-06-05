import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './editdata.dart';
import './main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({required this.index, required this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://localhost/PHP-REST-API/deleteData.php";
    http.post(Uri.parse(url), body: {'id': widget.list[widget.index]['id']});
  }

  void confirm(BuildContext context) {
    Alert(
      context: context,
      // type: AlertType.success,
      // desc:
      //     "Are You sure want to delete '${widget.list[widget.index]['item_name']}?'",
      // title: "Delete",
      content: Text( "Are You sure want to delete '${widget.list[widget.index]['item_name']}?'", style: new TextStyle(color: Colors.black, fontSize: 13), textAlign: TextAlign.center,),
      
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          color: Colors.indigo,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home(),
            ));
          },
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ).show();
    return;
  }

  // void confirm() {
  //   AlertDialog alertDialog = new AlertDialog(
  //     content: new Text("Are You sure want to delete '${widget.list[widget.index]['item_name']}'"),
  //     actions: <Widget>[
  //       new RaisedButton(
  //         child: new Text(
  //           "YES!",
  //           style: new TextStyle(color: Colors.black),
  //         ),
  //         color: Colors.red,
  // onPressed: () {
  //   deleteData();
  //   Navigator.of(context).push(new MaterialPageRoute(
  //     builder: (BuildContext context) => new Home(),
  //   ));
  // },
  //       ),
  //       new RaisedButton(
  //         child: new Text("NO", style: new TextStyle(color: Colors.black)),
  //         color: Colors.green,
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //     ],
  //   );

  //   showDialog(
  //       context: context,
  //       // child: alertDialog
  //       builder: (context) => AlertDialog(content: alertDialog));
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("${widget.list[widget.index]['item_name']}"),
          backgroundColor: Colors.indigo),
      body: new Container(
        // height: 500.0,
        padding: const EdgeInsets.all(20.0),
        // child: new Card(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Image.network(
                widget.list[widget.index]['item_image'],
                width: 300,
                height: 300,
                alignment: Alignment.center,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Text(
                "${widget.list[widget.index]['item_code']} - ${widget.list[widget.index]['stock']} available",
                style:
                    new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              ),
              new Text(
                widget.list[widget.index]['item_name'],
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
              new Text(
                "Rp ${widget.list[widget.index]['price']},-",
                style:
                    new TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new FlatButton(
                      child: new Text("EDIT",
                          style: new TextStyle(color: Colors.white)),
                      color: Colors.indigo,
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                            ),
                          )),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0))),
                  new SizedBox(width: 10),
                  new RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text("DELETE", style: TextStyle(fontSize: 12)),
                    onPressed: () => confirm(context),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(5.0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
