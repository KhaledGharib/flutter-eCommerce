import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/model/product_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  double get totalAmount {
    return _items.where((item) => item.isSelected).fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(ProductItemModel product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + product.quantity,
      );
    } else {
      _items.add(CartItem.fromProductItem(product));
    }

    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.id == productId);
    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((item) => item.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: quantity);
      }
      emit(CartLoaded(items: items, totalAmount: totalAmount));
    }
  }

  void clearCart() {
    _items.clear();
    emit(CartLoaded(items: items, totalAmount: totalAmount));
  }

  void toggleItemSelection(int itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        isSelected: !_items[index].isSelected,
      );
      emit(CartLoaded(items: items, totalAmount: totalAmount));
    }
  }
}
