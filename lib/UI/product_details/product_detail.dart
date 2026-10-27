import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:wordpress_app/UI/utils/custom_appbar.dart';
import 'package:wordpress_app/UI/utils/extension.dart';
import 'package:wordpress_app/constans/constans.dart';

import 'package:wordpress_app/model/woocommerce/product_model.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;

  const ProductDetail({super.key, this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');

  bool _isExpanded = false;

  // ارتفاع متن در حالت جمع‌شده
  static const double _collapsedHeight = 130;

  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  ///========================
  /// Make A Localhost To 10.0.2.2 For Emulator To Upload Images
  ///========================
  Widget _buildImage() {
    final images = widget.product?.images;
    if (images == null || images.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 80);
    }

    return Image.network(
      WoocommerceInfo.fixImageUrl(images[0].src.toString()),
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, size: 80),
    );
  }

  ///===================================
  /// Make fade For ShorDescription
  ///===================================
  Widget _buildDescription() {
    final text = widget.product!.shortDescription.toString().removeAllHtmlTags;
    final bgColor = Color.alphaBlend(
      Constants.primaryColor.withValues(alpha: 0.5),
      Theme.of(context).scaffoldBackgroundColor,
    );

    final textWidget = Text(
      text,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontFamily: 'Vazirmatn',
        color: Constants.blackColor.withValues(alpha: 0.7),
        height: 1.7,
        fontSize: 18,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ناحیه‌ی متن
        Expanded(
          child: _isExpanded
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: textWidget,
                )
              : Stack(
                  children: [
                    ClipRect(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: textWidget,
                      ),
                    ),
                    // فید ته متن
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 60,
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [bgColor.withValues(alpha: 0.7), bgColor],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),

        // دکمه‌ی ادامه / بستن
        TextButton(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Constants.primaryColor,
              ),
              Text(
                _isExpanded ? 'بستن' : 'ادامه',
                style: TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///==========================
  /// BUILD
  ///==========================

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///==================================
          /// APP BAR
          ///==================================
          CustomAppBar(appBarTitle: 'توضیحات محصول'),

          Positioned(
            top: 130.0,
            right: 20.0,
            left: 20.0,
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.8,
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  ///===========================
                  /// PRODUCT IMAGE
                  ///===========================
                  Positioned(
                    top: 40.0,
                    left: 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(height: 200, child: _buildImage()),
                    ),
                  ),

                  ///===========================
                  /// PLANT FEATURE
                  ///===========================
                  Positioned(
                    top: 20.0,
                    right: 0.0,
                    child: SizedBox(
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PlantFeature(
                            title: 'مدرس',
                            plantFeature: 'امیر طاها نجاران ',
                          ),

                          PlantFeature(title: 'پیشنیاز', plantFeature: 'ندارد'),

                          PlantFeature(title: 'سطح', plantFeature: 'پیشرفته'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 35.0,
                left: 30.0,
                right: 30.0,
              ),
              height: size.height * 0.55,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 30,
                            color: Constants.primaryColor,
                          ),
                          Text(
                            '4.9'.farsiNumber,
                            style: TextStyle(
                              fontFamily: 'Vazirmatn',
                              color: Constants.primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.product!.name.toString(),
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              SizedBox(
                                height: 19,
                                child: Image.asset(
                                  'assets/images/PriceUnit-green.png',
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                numberFormat
                                    .format(
                                      int.parse(
                                        widget.product!.price.toString(),
                                      ),
                                    )
                                    .farsiNumber,
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  color: Constants.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: _buildDescription()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String title;
  final String plantFeature;

  const PlantFeature({
    super.key,
    required this.title,
    required this.plantFeature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            fontFamily: 'Lalezar',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
      ],
    );
  }
}
