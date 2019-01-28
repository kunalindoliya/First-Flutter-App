import 'package:flutter/material.dart';

import './product_edit.dart';
import '../models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductList(this.products, this.updateProduct,this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          background: Container(color: Colors.red,),
          onDismissed: (DismissDirection direction){
            if(direction==DismissDirection.endToStart){
              deleteProduct(index);
            }else if(direction==DismissDirection.startToEnd){
              print("Start to end");
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].image),
                ),
                title: Text(products[index].title),
                subtitle: Text("\$${products[index].price.toString()}"),
                trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductEdit(
                          product: products[index],
                          updateProduct: updateProduct,
                          productIndex: index,
                        );
                      }));
                    }),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
