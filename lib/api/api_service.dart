import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/model/woocommerce/login_model.dart';
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
      debugPrint('Dio error: ${e.type} | ${e.message} | ${e.response?.data}');
      returnResponse = false;
    }
    return returnResponse;
  }

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    late LoginResponseModel loginModel;
    try {
      var response = await Dio().post(
        WoocommerceInfo.tokenURL,
        data: {'username': username, 'password': password},
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        loginModel = LoginResponseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      debugPrint('Status: ${e.response?.statusCode}');
      debugPrint('Body: ${e.response?.data}');
    }
    return loginModel;
  }
}
