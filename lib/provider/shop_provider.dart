import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/model/woocommerce/product_model.dart';

class ShopProvider with ChangeNotifier {
  APIService? _apiService;

  ShopProvider() {
    _apiService = APIService();
  }

  bool isLoading = false;

  List<Product> _product = <Product>[];
  List<Product> get product => _product;

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    final List<Product> response = await _apiService!.getProducts();
    _product = response;
    isLoading = false;
    notifyListeners();
  }

  void initializeData() {
    _apiService = APIService();
  }
}
