class AddtoCartReqModel {
  int? userId;
  List<CartProducts>? products;

  AddtoCartReqModel({this.userId, this.products});

  AddtoCartReqModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products!.add(CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  int? productId;
  int? quantity;

  CartProducts({this.productId, this.quantity});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
