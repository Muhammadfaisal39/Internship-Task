import 'package:flutter/material.dart';

import '../Product_Services/ProductsModel.dart';


class FProduct {
  final String? title;
  final List<String>? images;
  final double price;
  final double rating;

  FProduct({this.title, this.images, required this.price, required this.rating});
}

class FavoritesProvider with ChangeNotifier {
  List<Product> _favorites = [];
  String _searchQuery = "";

  List<Product> get favorites {
    if (_searchQuery.isEmpty) {
      return _favorites;
    } else {
      return _favorites.where((product) {
        return product.title!.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  void addFavorite(Product product) {
    _favorites.add(product);
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favorites.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }

  void searchFavorites(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
