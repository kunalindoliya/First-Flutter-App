import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final List<String> products;
  Product(this.products);

  Widget _buildProductItem(BuildContext context,int index){
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text(products[index])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return products.length>0 ? ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: products.length,
    ): Center(child: Text("No Products Found, Please Add Some!"),
    );
  }
}
