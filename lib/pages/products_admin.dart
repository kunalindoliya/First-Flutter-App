import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
class ProductAdminPage extends StatelessWidget {

  Widget _buildSideDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("All Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child:Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: "Create Product",icon: Icon(Icons.create),),
            Tab(text: "My Products",icon: Icon(Icons.list),)
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductEdit(),
          ProductList(null,null,null)
        ])
    ),
    );
  }
}
