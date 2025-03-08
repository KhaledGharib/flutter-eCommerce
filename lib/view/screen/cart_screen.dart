import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () => context.read<CartCubit>().clearCart(),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(child: Text('Your cart is empty'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(
                            item.imgUrl,
                            width: 50,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.error),
                          ),
                          title: Text(item.title),
                          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                          item.id,
                                          item.quantity - 1,
                                        ),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                          item.id,
                                          item.quantity + 1,
                                        ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed:
                                    () => context.read<CartCubit>().removeItem(
                                      item.id,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${state.totalAmount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      FilledButton(
                        onPressed: () {
                          // TODO: Implement checkout
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
