import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-models/main.dart';

class ProductList extends StatefulWidget {
  final MainModel model;

  ProductList(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.allProducts[index].title),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProduct(model.allProducts[index].id);
                model.deleteProduct();
              } else if (direction == DismissDirection.startToEnd) {
                print("Start to end");
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text("\$${model.allProducts[index].price.toString()}"),
                    trailing: _buildEditButton(context, index, model)),
                Divider()
              ],
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(model.allProducts[index].id);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEdit();
          })).then((_) => model.selectProduct(null));
        });
  }
}
