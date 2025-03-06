import 'package:dio/dio.dart';
import 'package:ecommerce/model/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final dio = Dio();
  Future<void> getProductDetails(int id) async {
    emit(ProductDetailsLoading());
    try {
      final response = await dio.get('https://fakestoreapi.com/products/$id');

      if (response.statusCode == 200) {
        ProductItemModel product = ProductItemModel.fromJson(response.data);

        emit(ProductDetailsLoaded(productDetails: product));
      } else {
        emit(ProductDetailsError(message: 'Failed to Fetch Product Details'));
      }
    } catch (e) {
      emit(ProductDetailsError(message: 'Error: ${e.toString()}'));
    }
  }
}
