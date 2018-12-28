import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreateState();
  }
}
class _ProductCreateState extends State<ProductCreate>{
  String title;
  String description;
  double price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child:ListView(children: <Widget>[
      TextField(
        decoration: InputDecoration(labelText: 'Product Title'),
        onChanged: (String value){
        setState(() {
          title=value;
        });
      },),
      TextField(
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 4,
        onChanged: (String value){
        setState(() {
          description=value;
        });
      },),
      TextField(
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        onChanged: (String value){
        setState(() {
          price=double.parse(value);
        });
      },),
    ],
    ),
    );
  }
}
