class AddtoCartResModel {
  bool? status;
  List<CartItem>? data;

  AddtoCartResModel({this.status, this.data});

  AddtoCartResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CartItem>[];
      json['data'].forEach((v) {
        data!.add(CartItem.fromJson(v));
      });
    }
  }
}

// NABEGHEHA.COM
class CartItem {
  int? productId;
  String? productName;
  String? productRegularPrice;
  String? thumbnail;
  int? quantity;
  double? lineSubtotal;
  double? lineTotal;
  int? variationId;

  CartItem({
    this.productId,
    this.productName,
    this.productRegularPrice,
    this.thumbnail,
    this.quantity,
    this.lineSubtotal,
    this.lineTotal,
    this.variationId,
  });
  // NABEGHEHA.COM
  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    thumbnail = json['thumbnail'];
    quantity = json['qty'];
    lineSubtotal = double.parse(json['line_subtotal'].toString());
    lineTotal = double.parse(json['line_total'].toString());
    variationId = json['variation_id'];
  }
}
