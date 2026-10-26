import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/widget/marquee_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> _plantTypes = [
    '| پیشنهادی |',
    '| آپارتمانی |',
    '| محل کار |',
    '| گل باغچه ایی |',
    '| گل سمی |',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShopProvider>(context, listen: false).getAllProducts();
    });
  }

  /// قیمت امن: اگه خالی یا نامعتبر بود کرش نمی‌کنه
  String formatPrice(NumberFormat numberFormat, dynamic price) {
    final parsed = num.tryParse(price?.toString() ?? '');
    if (parsed == null) return 'قیمت نامشخص';
    return '${numberFormat.format(parsed.toInt())} تومان';
  }

  /// آدرس عکس اولین تصویر محصول (یا null اگه نداشت)
  String? _imageOf(dynamic product) {
    final images = product.images;
    if (images == null || images.isEmpty) return null;
    return WoocommerceInfo.fixImageUrl(images[0].src.toString());
  }

  /// اسم اولین دسته‌بندی (یا رشته‌ی خالی)
  String _categoryOf(dynamic product) {
    final categories = product.categories;
    if (categories == null || categories.isEmpty) return '';
    return categories[0].name.toString();
  }

  Widget _networkImage(String? url, {BoxFit fit = BoxFit.contain}) {
    if (url == null) return const Icon(Icons.image_not_supported);
    return Image.network(
      url,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
    final Size size = MediaQuery.of(context).size;

    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ///===================================
                /// SEARCH BOX
                ///===================================
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mic,
                            color: Constants.blackColor.withValues(alpha: 0.6),
                          ),
                          const Expanded(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                textAlign: TextAlign.start,
                                showCursor: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(right: 5.0),
                                  hintText: 'جستجو...',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Vazirmatn',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Constants.blackColor.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///===================================
                /// CATEGORY
                ///===================================
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  height: 70.0,
                  width: size.width,
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _plantTypes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Text(
                            _plantTypes[index],
                            style: TextStyle(
                              fontFamily: 'Vazirmatn',
                              fontSize: 16,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              color: selectedIndex == index
                                  ? Constants.primaryColor
                                  : Constants.blackColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                ///===================================
                /// PRODUCT (افقی)
                ///===================================
                SizedBox(
                  height: size.height * 0.27,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.product.length,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final product = value.product[index];
                      final imageUrl = _imageOf(product);
                      final categoryName = _categoryOf(product);

                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18.0),
                          width: 215.0,
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              // دکمه علاقه‌مندی
                              Positioned(
                                top: 10,
                                right: 10.0,
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Constants.primaryColor,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),

                              // عکس
                              Positioned(
                                top: 45,
                                right: 45,
                                left: 45,
                                bottom: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _networkImage(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // قیمت (چپ) + دسته‌بندی و اسم (راست)
                              Positioned(
                                bottom: 14,
                                left: 14,
                                right: 14,
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            categoryName,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.white70,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          MarqueeText(
                                            product.name.toString(),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontFamily: 'Vazirmatn',
                                              color: Colors.white70,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: Text(
                                        formatPrice(
                                          numberFormat,
                                          product.price,
                                        ),
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Constants.primaryColor,
                                          fontSize: 13.0,
                                          fontFamily: 'Lalezar',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                ///===================================
                ///  TEXT
                ///===================================
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 15.0,
                    right: 20.0,
                  ),
                  child: const Text(
                    'مطالب وبلاگ',
                    style: TextStyle(
                      fontFamily: 'Vazirmatn',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ///===================================
                ///  PRODUCT 2 (لیست عمودی)
                ///===================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.product.length,
                    itemBuilder: (context, index) {
                      final product = value.product[index];
                      final imageUrl = _imageOf(product);
                      final categoryName = _categoryOf(product);

                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 90.0,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              // عکس (سمت راست)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: _networkImage(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // اسم و دسته‌بندی
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      categoryName,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Lalezar',
                                      ),
                                    ),
                                    Text(
                                      product.name.toString(),
                                      textAlign: TextAlign.right,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Vazirmatn',
                                        color: Constants.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // «کلیک کنید» (سمت چپ)
                              Text(
                                'کلیک کنید',
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Constants.primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
