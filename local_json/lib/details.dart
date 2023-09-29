// ignore_for_file: prefer_const_constructors, prefer_is_empty, non_constant_identifier_names, avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:convert';

import 'items.dart';

class DetailsPage extends StatefulWidget {
  int position;
  DetailsPage(this.position);
  @override
  State createState() {
    return DetailsState();
  }
}

class DetailsState extends State<DetailsPage> {
  List<Items>? list_items;
  // ignore: prefer_typing_uninitialized_variables
  var imagepath;

  @override
  void initState() {
    super.initState();
    list_items = List.empty(growable: true);

    if (widget.position == 1) imagepath = "spices.png";
    if (widget.position == 2) imagepath = "dry_fruite.png";
    if (widget.position == 3) imagepath = "vegetables.png";
    if (widget.position == 4) imagepath = "dry_fruite.png";

    readData(widget.position);
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: Colors.white),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[500],
          ),
          Image.asset(
            imagepath,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (list_items!.length == 0)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      for (final item in list_items!)
                        Card(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                color: Colors.white70,
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      item.name_telugu,
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 18),
                                    ),
                                    Text(
                                      item.name_english,
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 18),
                                    ),
                                    Text(
                                      item.name_catala,
                                      style: TextStyle(
                                          color: Colors.pink, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  readData(int which) async {
    String? file;
    switch (which) {
      case 1:
        file = "spices.json";
        break;
      case 2:
        file = "dry_fruites.json";
        break;
      case 3:
        file = "vegetable.json";
        break;
      case 4:
        file = "pulses.json";
        break;
    }
    await DefaultAssetBundle.of(context).loadString("assets/$file").then((s) {
      setState(() {
        var response = json.decode(s);
        List<dynamic> list_telugu = response['telugu'];
        List<dynamic> list_english = response['english'];
        List<dynamic> list_catala = response['catala'];

        for (var k = 0; k < list_telugu.length; k++) {
          list_items!
              .add(Items(list_english[k], list_telugu[k], list_catala[k]));
        }
      });
    }).catchError((error) {
      print(error);
    });
  }
}
