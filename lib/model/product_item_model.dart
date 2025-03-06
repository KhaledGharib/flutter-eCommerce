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
