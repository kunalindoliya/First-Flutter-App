import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget{
  final String address;

  AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).backgroundColor, width: 2.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: Text(address,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}