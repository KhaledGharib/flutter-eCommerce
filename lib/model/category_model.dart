import 'package:ecommerce/utility/app_images.dart';

class CategoryModel {
  final String id;
  final String title;
  final String imgUrl;

  CategoryModel({required this.id, required this.title, required this.imgUrl});
}

List<CategoryModel> dummyCategory = [
  CategoryModel(id: '1', title: 'clothes', imgUrl: AppImages.carousel1),
  CategoryModel(id: '2', title: 'bags', imgUrl: AppImages.carousel1),
  CategoryModel(id: '3', title: 'shoes', imgUrl: AppImages.carousel1),
  CategoryModel(id: '4', title: 'electronic', imgUrl: AppImages.carousel1),
];
