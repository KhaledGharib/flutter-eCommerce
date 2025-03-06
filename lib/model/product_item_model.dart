import 'package:ecommerce/utility/app_images.dart';

class ProductItemModel {
  final String title;
  final String imgUrl;
  final double price;
  final bool isFavorite;
  final String category;

  ProductItemModel({
    required this.title,
    required this.imgUrl,
    required this.price,
    required this.isFavorite,
    required this.category,
  });

  // Factory method to create a ProductItemModel from JSON
  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      title: json['title'],
      imgUrl: json['image'], // Matches API response
      price: (json['price'] as num).toDouble(), // Ensuring type safety
      category: json['category'],
      isFavorite: false,
      // rating: (json['rating']['rate'] as num).toDouble(), // Handling nested rating
    );
  }
}

List<ProductItemModel> dummyProductsData = [
  ProductItemModel(
    title: "The Mirac Jiz",
    imgUrl: AppImages.the_mirac_jiz,
    price: 195,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "Meriza Kiles",
    imgUrl: AppImages.meriza_kiles,
    price: 143.45,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "The Mirac Jiz",
    imgUrl: AppImages.the_mirac_jiz,
    price: 195,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "Meriza Kiles",
    imgUrl: AppImages.meriza_kiles,
    price: 143.45,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "The Mirac Jiz",
    imgUrl: AppImages.the_mirac_jiz,
    price: 195,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "Meriza Kiles",
    imgUrl: AppImages.meriza_kiles,
    price: 143.45,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "The Mirac Jiz",
    imgUrl: AppImages.the_mirac_jiz,
    price: 195,
    isFavorite: false,
    category: "other",
  ),
  ProductItemModel(
    title: "Meriza Kiles",
    imgUrl: AppImages.meriza_kiles,
    price: 143.45,
    isFavorite: false,
    category: "other",
  ),
];
