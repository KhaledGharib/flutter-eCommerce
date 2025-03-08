import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/utility/app_routes.dart';
import 'package:ecommerce/view/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Shopping Cart'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.delete_outline),
        //     onPressed: () => context.read<CartCubit>().clearCart(),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
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
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          value: state.items[index].isSelected,
                                          onChanged: (value) {
                                            context
                                                .read<CartCubit>()
                                                .toggleItemSelection(
                                                  state.items[index].id,
                                                );
                                          },
                                        ),
                                        // Placeholder(),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: size.height * 0.1,
                                                width: size.width * .2,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    5.0,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        state
                                                            .items[index]
                                                            .imgUrl,
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),

                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.5,
                                                      child: Text(
                                                        state
                                                            .items[index]
                                                            .title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.25,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .grey[300],
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  20,
                                                                ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  8.0,
                                                                ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () => context
                                                                          .read<
                                                                            CartCubit
                                                                          >()
                                                                          .updateQuantity(
                                                                            state.items[index].id,
                                                                            state.items[index].quantity -
                                                                                1,
                                                                          ),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            100,
                                                                          ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  state
                                                                      .items[index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .titleMedium!
                                                                      .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () => context
                                                                          .read<
                                                                            CartCubit
                                                                          >()
                                                                          .updateQuantity(
                                                                            state.items[index].id,
                                                                            state.items[index].quantity +
                                                                                1,
                                                                          ),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            100,
                                                                          ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("\$"),
                                                            Text(
                                                              state
                                                                  .items[index]
                                                                  .price
                                                                  .toString(),
                                                              style: Theme.of(
                                                                    context,
                                                                  )
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                              // return ProductItem(item: item);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 10,
                          ),
                          child: SizedBox(
                            // width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total: \$",
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                    Text(
                                      state.totalAmount.toStringAsFixed(2),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                FilledButton.icon(
                                  icon: Icon(Icons.check, size: 30),
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pushNamed(AppRoutes.checkout);
                                  },
                                  label: Text(
                                    "Checkout",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                    padding:
                                        WidgetStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 24,
                                          ),
                                        ),
                                    shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder
                                    >(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      ),
    );
  }
}
