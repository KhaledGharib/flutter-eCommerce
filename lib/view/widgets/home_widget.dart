import 'package:ecommerce/controller/home_cubit/home_cubit.dart';
import 'package:ecommerce/model/carousel_model.dart';
import 'package:ecommerce/utility/app_routes.dart';
import 'package:ecommerce/view/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is HomeLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),

              child: Column(
                children: [
                  FlutterCarousel(
                    options: FlutterCarouselOptions(
                      viewportFraction: 0.8,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      height: size.height * 0.17,
                      showIndicator: true,
                      slideIndicator: CircularSlideIndicator(),
                    ),
                    items:
                        dummyCarousel.map((e) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: 10.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(e.imgUrl, fit: BoxFit.cover),
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: size.height * 0.05),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New Arrivals 🔥",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See All",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      GridView.builder(
                        itemCount: state.apiProduct.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 20,
                          childAspectRatio:
                              0.65, // Control item height/width ratio
                        ),
                        itemBuilder:
                            (context, index) => GestureDetector(
                              onTap:
                                  () => Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pushNamed(
                                    AppRoutes.productDetails,
                                    arguments: state.apiProduct[index].id,
                                  ),
                              child: ProductItem(
                                apiProduct: state.apiProduct[index],
                              ),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            debugPrint(state.message);
          }
          // return const Text("nothing");
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
