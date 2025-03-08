import 'package:ecommerce/model/product_item_model.dart';

class CartItem {
  final int id;
  final String title;
  final String imgUrl;
  final double price;
  final bool isSelected;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.price,
    this.quantity = 1,
    this.isSelected = true,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    int? id,
    String? title,
    String? imgUrl,
    double? price,
    int? quantity,
    bool? isSelected,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imgUrl': imgUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      imgUrl: json['imgUrl'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  factory CartItem.fromProductItem(ProductItemModel product) {
    return CartItem(
      id: product.id,
      title: product.title,
      imgUrl: product.imgUrl,
      price: product.price,
      quantity: product.quantity,
    );
  }
}
