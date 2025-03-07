import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is ProductDetailsLoaded) {
              return Stack(
                children: [
                  // Main scrollable content
                  CustomScrollView(
                    slivers: [
                      // App Bar
                      SliverAppBar(
                        backgroundColor: Colors.white,

                        // title: Text("Product Details"),
                        actions: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 16.0,
                            ),
                            child: Icon(Icons.favorite_outline_rounded),
                          ),
                        ],
                        pinned: true,
                        expandedHeight: size.width * 0.9,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            color: Colors.white,
                            child: Center(
                              child: CachedNetworkImage(
                                width: 200,
                                placeholder:
                                    (context, url) => Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                        Icon(Icons.error, color: Colors.red),
                                imageUrl: state.productDetails.imgUrl,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Product Details Content
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            border: Border(top: BorderSide(color: Colors.grey)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Title
                                Text(
                                  state.productDetails.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),

                                // Rating and Quantity Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Rating Section
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "${state.productDetails.rating}",
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                        ),
                                        Text(
                                          "(${state.productDetails.reviewCount} Review)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),

                                    // Quantity Selector
                                    Container(
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Icon(Icons.remove),
                                            ),
                                            Text(
                                              "1",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleMedium!.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: size.height * 0.02),

                                // Description Section
                                Text(
                                  "Description",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.productDetails.description,
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                ),

                                // Add bottom padding to make space for fixed bottom bar
                                SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Fixed bottom bar for price and add to cart
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$",
                                style: Theme.of(
                                  context,
                                ).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                "${state.productDetails.price}",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                          FilledButton.icon(
                            icon: Icon(Icons.shopping_bag_rounded, size: 30),
                            onPressed: () {},
                            label: Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                              ),
                              shape: WidgetStateProperty.all<
                                RoundedRectangleBorder
                              >(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProductDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
