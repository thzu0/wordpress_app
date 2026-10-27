import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/model/woocommerce/product_category_model.dart';
import 'package:wordpress_app/model/woocommerce/product_model.dart';
import 'package:wordpress_app/model/wordpress/wordpress_post_model.dart';

class ShopProvider with ChangeNotifier {
  APIService? _apiService;

  ShopProvider() {
    _apiService = APIService();
  }

  /// لودینگ دسته‌بندی‌ها (فقط بار اول)
  bool isCategoryLoading = false;

  /// لودینگ محصولات دسته‌ی انتخاب‌شده (هر بار که دسته عوض میشه)
  bool isProductLoading = false;

  bool isLoadingPost = false;

  ///====================
  /// FOR STORE ALL CATEGORY NAMES
  ///====================
  List<ProductCategory> _productCategory = <ProductCategory>[];
  List<ProductCategory> get productCategory => _productCategory;

  ///============================
  /// FOR STORE ALL WORDPRESS POSTS
  ///============================
  List<WordpressPosts> _wordpressPosts = <WordpressPosts>[];
  List<WordpressPosts> get wordpressPosts => _wordpressPosts;

  ///====================
  /// FOR STORE PRODUCT WITH CATEGORY NAME
  ///====================
  List<Product> _productByCategory = <Product>[];
  List<Product> get productByCategory => _productByCategory;

  Future<void> getAllWordpressPosts() async {
    isLoadingPost = true;
    notifyListeners();
    final List<WordpressPosts> postResponse = await _apiService!.getPosts();
    _wordpressPosts = postResponse;
    isLoadingPost = false;
    notifyListeners();
  }

  /// دریافت دسته‌ها
  Future<void> getAllCategoryNames() async {
    isCategoryLoading = true;
    notifyListeners();

    try {
      _productCategory = await _apiService!.getProductCategory();
    } catch (e) {
      debugPrint('getAllCategoryNames error: $e');
      _productCategory = <ProductCategory>[];
    }

    isCategoryLoading = false;
    notifyListeners();
  }

  /// دریافت محصولات یک دسته
  Future<void> getProductsByCategory(String categoryID) async {
    isProductLoading = true;
    notifyListeners();

    try {
      _productByCategory = await _apiService!.getProductCategorybyId(
        categoryID,
      );
    } catch (e) {
      debugPrint('getProductsByCategory error: $e');
      _productByCategory = <Product>[];
    }

    isProductLoading = false;
    notifyListeners();
  }

  /// لود اولیه: اول دسته‌ها، بعد محصولات اولین دسته (بدون hardcode کردن '17')
  Future<void> loadHomeData({required String initialCategoryId}) async {
    await getProductsByCategory(initialCategoryId);
    if (_productCategory.isNotEmpty) {
      await getProductsByCategory(_productCategory.first.categoryId.toString());
    }
  }

  void initializeData() {
    _apiService = APIService();
  }
}
