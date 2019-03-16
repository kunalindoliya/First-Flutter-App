import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
              placeholder: AssetImage("assets/food.jpg"),
              height: 300.0,
              fit: BoxFit.cover,
              image: NetworkImage(product.image)),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'oswald'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                PriceTag(product.price.toString()),
              ],
            ),
          ),
          AddressTag("Delhi,India"),
          Text(product.userEmail),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(
                  Icons.info,
                  size: 30.0,
                ),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                    icon: Icon(model.allProducts[productIndex].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      model.selectProduct(productIndex);
                      model.toggleProductFavoriteStatus();
                    });
              })
            ],
          )
        ],
      ),
    );
  }
}
