import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/model/woocommerce/addtocart_request_model.dart';
import 'package:wordpress_app/model/woocommerce/addtocart_response_model.dart';
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

  ///====================
  /// FOR ITEMS IN SHOPPING CART
  ///====================
  List<CartItem>? _itemsinCart;
  List<CartItem>? get itemsinCart => _itemsinCart;

  ///---------------------------------------------------------------
  /// PROVIDER PART
  ///---------------------------------------------------------------

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

  /// محصول جدید رو به سبد خرید اضافه می‌کنه و با سرور همگام می‌کنه.
  /// مراحل:
  /// 1. یه درخواست (reqModel) می‌سازه که شامل همه‌ی محصولات فعلی سبده.
  /// 2. اگه سبد خالی/مقداردهی‌نشده بود، اول initializeData() صداش می‌زنه.
  /// 3. همه‌ی آیتم‌های فعلی _itemsinCart رو توی reqModel.products می‌ریزه.
  /// 4. دنبال محصول تکراری (همون productId که داره اضافه میشه) می‌گرده و حذفش می‌کنه،
  ///    تا بعد نسخه‌ی جدید (product) جایگزینش بشه — یعنی به‌جای افزودن تکراری، آپدیت می‌کنه.
  /// 5. محصول جدید رو اضافه می‌کنه و درخواست رو به API می‌فرسته.
  /// 6. اگه جواب موفق بود، _itemsinCart رو با دیتای جدید از سرور جایگزین می‌کنه
  ///    و onCallBack رو صدا می‌زنه و UI رو با notifyListeners() آپدیت می‌کنه.
  Future<void> addToCart(CartProducts product, Function onCallBack) async {
    AddtoCartReqModel reqModel = AddtoCartReqModel();
    reqModel.products = <CartProducts>[];

    if (_itemsinCart == null) initializeData();

    _itemsinCart!.forEach((element) {
      reqModel.products!.add(
        CartProducts(productId: element.productId, quantity: element.quantity),
      );
    });

    CartProducts? duplicatedProductID = reqModel.products!.firstWhereOrNull(
      (prod) => prod.productId == product.productId,
    );

    if (duplicatedProductID != null) {
      reqModel.products!.remove(duplicatedProductID);
    }

    reqModel.products!.add(product);

    await _apiService!.addtoCart(reqModel).then((cartResModel) {
      if (cartResModel.data != null) {
        List<CartItem>? newCartResModels = cartResModel.data;
        _itemsinCart = [];
        _itemsinCart!.addAll(newCartResModels!);
      }

      onCallBack(cartResModel);
      notifyListeners();
    });
  }

  void initializeData() {
    _apiService = APIService();
    _itemsinCart = <CartItem>[];
  }
}
