import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/model/woocommerce/login_model.dart';
import 'package:wordpress_app/model/woocommerce/product_category_model.dart';
import 'package:wordpress_app/model/woocommerce/product_model.dart';
import 'package:wordpress_app/model/woocommerce/register_model.dart';
import 'package:wordpress_app/model/wordpress/wordpress_post_model.dart';

class APIService {
  ///=================================
  /// Create customer with signup page
  ///=================================

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

  ///=============================================
  /// Get your email and pass from API with use JWT
  ///=============================================

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

  ///=========================
  /// Get the product from API
  ///=========================

  Future<List<Product>> getProducts() async {
    final String productURL =
        "${WoocommerceInfo.baseURl}${WoocommerceInfo.productURL}?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";

    List<Product> productList = <Product>[];

    try {
      Response response = await Dio().get(
        productURL,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        productList = (response.data as List)
            .map((i) => Product.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productList;
  }

  ///============================================================
  ///============================================================
  ///============================================================

  Future<List<ProductCategory>> getProductCategory() async {
    final String productCategoryURL =
        "${WoocommerceInfo.baseURl}${WoocommerceInfo.productCategoryURL}?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";

    List<ProductCategory> productCategoryList = <ProductCategory>[];

    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        productCategoryList = (response.data as List)
            .map((i) => ProductCategory.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productCategoryList;
  }

  ///============================================================
  ///============================================================
  ///============================================================

  Future<List<Product>> getProductCategorybyId(String catID) async {
    final String productCategoryURL =
        "${WoocommerceInfo.baseURl}${WoocommerceInfo.productURL}?category=$catID&consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";

    List<Product> productCategoryList = <Product>[];

    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        productCategoryList = (response.data as List)
            .map((i) => Product.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return productCategoryList;
  }

  ///============================================================
  ///============================================================
  ///============================================================

  Future<List<WordpressPosts>> getPosts() async {
    final String postURL = WoocommerceInfo.baseURLPosts;
    List<WordpressPosts> postList = <WordpressPosts>[];

    try {
      Response response = await Dio().get(
        postURL,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        postList = (response.data as List)
            .map((i) => WordpressPosts.fromJson(i))
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return postList;
  }
}
