import 'package:flutter/material.dart';

class WoocommerceInfo {
  //CONSUMERKEY & CONSUMERSECRET
  static String consumerKey = 'ck_d794947246d5f3d75ec248ec1bbe7fe24006506f';
  static String consumerSecret = 'cs_22973f4db9e9d6ba884bef05bf8aeff96382523d';

  // BASE URL WOOCOMMERCE
  static String baseURl = 'http://10.0.2.2/project/wordpress/wp-json/wc/v3/';

  //URL FOR AUTHENTICATION WITH JWT
  static String tokenURL =
      'http://10.0.2.2/project/wordpress/wp-json/jwt-auth/v1/token';

  // API ENDPOINTS
  static String customerURL = 'customers';
  static String productURL = 'products';

  /// host/port آدرس عکس رو با آدرس قابل دسترس از امولاتور عوض می‌کنه
  static String fixImageUrl(String url) {
    final base = Uri.parse(baseURl);
    final uri = Uri.parse(url);
    return uri
        .replace(
          scheme: base.scheme,
          host: base.host,
          port: base.hasPort ? base.port : null,
        )
        .toString();
  }
}

class Constants {
  static Color primaryColor = const Color(0xFF296E48);
  static Color blackColor = Colors.black54;

  static String titleOne = "گیاهان را بهتر از قبل درک کن";
  static String descriptionOne =
      "در مورد نگه داری گل و گیاهان \nمیتوانی اطلاعات کسب کنی";

  static String titleTwo = "با گیاهان جدید اشنا شو";
  static String descriptionTwo =
      "رز مشکی یا گل رز دوست داری؟ اینجا میتونی پیداش کنی";

  static String titleThree = "با یک گل بهار نمیشود گل بکار ";
  static String descriptionThree =
      "هر گلی نیاز داشته باشید در این اپلیکیشن پیدا میکنید";
}
