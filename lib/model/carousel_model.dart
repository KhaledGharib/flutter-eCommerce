import 'package:ecommerce/utility/app_images.dart';

class CarouselModel {
  final int id;
  final String imgUrl;

  CarouselModel({required this.id, required this.imgUrl});
}

List<CarouselModel> dummyCarousel = [
  CarouselModel(id: 1, imgUrl: AppImages.carousel1),
  CarouselModel(id: 2, imgUrl: AppImages.carousel1),
  CarouselModel(id: 3, imgUrl: AppImages.carousel1),
];
