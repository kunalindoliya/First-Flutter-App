import 'package:flutter/material.dart';

import './pages/product.dart';
import './pages/products.dart';
import './pages/products_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, String>> products = [];

  void _addProduct(Map<String, String> productName) {
    setState(() {
      products.add(productName);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //brightness: Brightness.dark, for dark color
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      //home: AuthPage(),
      routes: {
        "/": (BuildContext context) =>
            ProductsPage(products, _addProduct, _deleteProduct),
        "/admin": (BuildContext context) => ProductAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                ProductPage(products[index]["title"], products[index]["image"]),
          );
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductsPage(products, _addProduct, _deleteProduct));
      },
    );
  }
}
