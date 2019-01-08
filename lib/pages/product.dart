import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/products/address_tag.dart';
import '../widgets/products/price_tag.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> _product;

  ProductPage(this._product);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you Sure?"),
            content: Text("This cannot be undone"),
            actions: <Widget>[
              FlatButton(
                child: Text("DISCARD"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("CONTINUE"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(_product['title']),
          ),
          body: Column(
            children: <Widget>[
              Image.asset(_product['image']),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        _product["title"],
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'oswald'),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                     PriceTag(_product['price'].toString())
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Description:",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'oswald'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      _product['description'],
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'oswald'),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 AddressTag("Delhi,India")
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  color: Colors.red,
                  onPressed: () => _showWarningDialog(context),
                ),
              )
            ],
          )),
    );
  }
}
