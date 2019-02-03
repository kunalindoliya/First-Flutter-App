import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _showFavorites=false;

  //get creates getter method but it should not have parameters
  List<Product> get products {
    return List<Product>.from(_products);
  }

  List<Product> get displayedProducts {
    if(_showFavorites){
      return _products.where((Product product) =>product.isFavorite).toList();
    }
    return List<Product>.from(_products);
  }


  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get displayFavoritesOnly{
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) return null;
    return _products[selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updateProduct;
    _selectedProductIndex=null;
    notifyListeners();

  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode(){
    _showFavorites=!_showFavorites;
    notifyListeners();
  }
}
