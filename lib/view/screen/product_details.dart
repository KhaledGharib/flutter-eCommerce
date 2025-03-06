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
                Center(child: CircularProgressIndicator.adaptive());
              } else if (state is ProductDetailsLoaded) {
                return Column(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.amber,
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
                    Text(state.productDetails.title),
                  ],
                );
              } else if (state is ProductDetailsError) {
                debugPrint(state.message);
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
