import './connected_products.dart';
import '../models/product.dart';

mixin ProductsModel on ConnectedProducts {
  bool _showFavorites = false;

  //get creates getter method but it should not have parameters
  List<Product> get allProducts {
    return List<Product>.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List<Product>.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selProductIndex == null) return null;
    return products[selProductIndex];
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
    products[selProductIndex] = updatedProduct;
    selProductIndex = null;
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
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selProductIndex] = updateProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
