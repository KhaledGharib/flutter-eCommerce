import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/model/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final dio = Dio();

  Future<void> getHomeProduct() async {
    emit(HomeLoading());
    try {
      final response = await dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        // Parsing the list of products
        List<ProductItemModel> products =
            (response.data as List)
                .map((product) => ProductItemModel.fromJson(product))
                .toList();

        emit(HomeLoaded(apiProduct: products));
      } else {
        emit(HomeError(message: 'Failed to fetch products'));
      }
    } catch (e) {
      emit(HomeError(message: 'Error: ${e.toString()}'));
    }
  }
}
