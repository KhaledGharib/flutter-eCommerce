import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel apiProduct;
  const ProductItem({super.key, required this.apiProduct});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final ProductItemModel product = dummyProductsData[productIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.error, color: Colors.red),
                  imageUrl: apiProduct.imgUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          apiProduct.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2),
        Text(
          "\$${apiProduct.price.toString()}",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
