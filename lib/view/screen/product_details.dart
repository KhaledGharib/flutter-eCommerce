import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cubit/product_details_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            child: Icon(Icons.favorite_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (state is ProductDetailsLoaded) {
                return Column(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CachedNetworkImage(
                          placeholder:
                              (context, url) => Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  Icon(Icons.error, color: Colors.red),
                          imageUrl: state.productDetails.imgUrl,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.productDetails.title),
                        Row(
                          children: [
                            Icon(Icons.star_rounded, color: Colors.amber),
                            SizedBox(width: 6),
                            Text(
                              "${state.productDetails.rating}",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              "(${state.productDetails.reviewCount} Review)",
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
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
      ),
    );
  }
}
