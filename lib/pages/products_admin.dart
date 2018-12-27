import 'package:flutter/material.dart';

import './product_create.dart';
import './product_list.dart';
import './products.dart';

class ProductAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child:Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text("Choose"),
              ),
              ListTile(
                title: Text("All Products"),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ProductsPage()));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "Create Product",icon: Icon(Icons.create),),
            Tab(text: "My Products",icon: Icon(Icons.list),)
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductCreate(),
          ProductList()
        ])
    ),
    );
  }
}
