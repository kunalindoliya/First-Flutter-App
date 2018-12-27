import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{
  final Function addProduct;
  ProductControl(this.addProduct);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
       addProduct({"title":"Choclate","image":"assets/food.jpg"});
      },
      child: Text('Add Product'),
    );
  }
}