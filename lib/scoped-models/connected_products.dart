import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;
  bool _isLoading=false;

  void addProduct(
      String title, String description, String image, double price) {
    _isLoading=true;
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://img.huffingtonpost.com/asset/5b7d981c190000b606502692.jpeg?cache=Vbw27fsB2Q&ops=scalefit_720_noupscale',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    http
        .post("https://flutter-products-fe71b.firebaseio.com/products.json",
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseDate = json.decode(response.body);
      final Product newProduct = new Product(
          id: responseDate['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading=false;
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  //get creates getter method but it should not have parameters
  List<Product> get allProducts {
    return List<Product>.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List<Product>.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (_selProductIndex == null) return null;
    return _products[_selProductIndex];
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = new Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selProductIndex] = updatedProduct;
    notifyListeners();
  }

  void fetchProducts() {
    _isLoading=true;
    http
        .get("https://flutter-products-fe71b.firebaseio.com/products.json")
        .then((http.Response response) {
      final Map<String, dynamic> productListData =
          json.decode(response.body);
      final List<Product> fetchedProductList=[];
      productListData
          .forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            image: productData['image'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
            fetchedProductList.add(product);
      });
      _products=fetchedProductList;
      _isLoading=false;
      notifyListeners();
    });
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selProductIndex] = updateProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selProductIndex);
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: "hjakhkla", email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProductsModel{
  bool get isLoading{
    return _isLoading;
  }
}
