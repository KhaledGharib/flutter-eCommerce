import 'package:ecommerce/model/carousel_model.dart';
import 'package:ecommerce/model/product_item_model.dart';
import 'package:ecommerce/view/widget/product_item.dart';
import 'package:ecommerce/view/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(size: size),
                SizedBox(height: size.height * 0.03),
                FlutterCarousel(
                  options: FlutterCarouselOptions(
                    viewportFraction: 0.9,
                    height: 170,
                    showIndicator: true,
                    slideIndicator: CircularSlideIndicator(),
                  ),
                  items:
                      dummyCarousel.map((e) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: Container(
                            // decoration: BoxDecoration(color: Colors.amber),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(e.imgUrl, fit: BoxFit.cover),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivals 🔥",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.01),
                GridView.builder(
                  itemCount: dummyProductsData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.65, // Control item height/width ratio
                  ),
                  itemBuilder:
                      (context, index) => ProductItem(productIndex: index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
