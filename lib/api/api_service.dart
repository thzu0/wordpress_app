import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/model/woocommerce/register_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    bool returnResponse = false;

    String authToken = base64.encode(
      utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}",
      ),
    );
    try {
      var response = await Dio().post(
        WoocommerceInfo.baseURl + WoocommerceInfo.customerURL,
        data: model.toJson(),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        returnResponse = true;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        returnResponse = false;
      } else {
        returnResponse = false;
      }
    }
    return returnResponse;
  }
}
