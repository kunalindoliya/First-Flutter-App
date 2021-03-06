import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/product.dart';
import './pages/auth.dart';
import './pages/product.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './scoped-models/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model=MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
            //brightness: Brightness.dark, for dark color
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple
            //fontFamily: 'Oswald'
            ),
        //home: AuthPage(),
        routes: {
          "/": (BuildContext context) => AuthPage(),
          "/home": (BuildContext context) => ProductsPage(model),
          "/admin": (BuildContext context) => ProductAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') return null;
          if (pathElements[1] == 'product') {
            final String productId= pathElements[2];
            final Product product=model.allProducts.firstWhere((Product product){
              return product.id ==productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(product),
            );
          }
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),
    );
  }
}
