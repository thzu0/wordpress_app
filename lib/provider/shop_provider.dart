import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/model/woocommerce/product_category_model.dart';
import 'package:wordpress_app/model/woocommerce/product_model.dart';

class ShopProvider with ChangeNotifier {
  APIService? _apiService;

  ShopProvider() {
    _apiService = APIService();
  }

  bool isLoading = false;

  ///========================
  /// FOR STORE ALL PRODUCTS
  ///========================

  List<Product> _product = <Product>[];
  List<Product> get product => _product;

  ///====================
  /// FOR STORE ALL CATEGORY NAMES
  ///====================
  List<ProductCategory> _productCategory = <ProductCategory>[];
  List<ProductCategory> get productCategory => _productCategory;

  Future<void> getAllCategoryNames() async {
    isLoading = true;
    notifyListeners();
    final List<ProductCategory> categoryResponse = await _apiService!
        .getProductCategory();
    _productCategory = categoryResponse;
    isLoading = false;
    notifyListeners();
  }

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
