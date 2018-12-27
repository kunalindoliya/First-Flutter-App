import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Product(this.products,{this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]["image"]),
          Text(products[index]["title"]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Details"),
                onPressed: () => Navigator.pushNamed<bool>(
                      context,'/product/'+index.toString())
                    .then((bool value){
                      if(value){
                        deleteProduct(index);
                      }
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return products.length > 0
        ? ListView.builder(
            itemBuilder: _buildProductItem,
            itemCount: products.length,
          )
        : Center(
            child: Text("No Products Found, Please Add Some!"),
          );
  }
}
