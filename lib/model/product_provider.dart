import 'package:flutter/material.dart';
import 'package:timbu/model/product.dart';
import 'package:timbu/service/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final TimbuApi api;
  bool isLoading = false;
  String _errorMessage = '';
  List<Product> productsList = [];

  ProductProvider({required this.api});

  // get list of products
  List<Product> getProductsList() {
    return productsList;
  }

  bool getIsLoading() {
    return isLoading;
  }

  String get errorMessage => _errorMessage;

  // fetch products from API
  Future<void> fetchProducts() async {
    isLoading = true;
    _errorMessage = "";
    notifyListeners();

    try {
      productsList = await api.fetchProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
