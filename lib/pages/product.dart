import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';
import '../widgets/products/address_tag.dart';
import '../widgets/products/price_tag.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

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
      child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
        final Product product=model.products[productIndex];
          return  Scaffold(
              appBar: AppBar(
                title: Text(product.title),
              ),
              body: Column(
                children: <Widget>[
                  Image.asset(product.image),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            product.title,
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'oswald'),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          PriceTag(product.price.toString())
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
                          product.description,
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
              ));
      })
    );
  }
}
