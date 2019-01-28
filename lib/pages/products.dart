import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/admin");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:_buildSideDrawer(context),
      appBar: AppBar(
        title: Text('All Products'),
        actions: <Widget>[IconButton(icon: Icon(Icons.favorite), onPressed: (){})],
      ),
      body: Products(products),
    );
  }
}
