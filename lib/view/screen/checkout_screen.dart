import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/utility/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartLoaded) {
              return Column(
                children: [
                  // Scrollable content area
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Placeholder(),
                            SizedBox(height: size.height * 0.05),

                            // Payment method
                            Text(
                              "Payment Method",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  AppIcons.masterCardSVG,
                                ),
                                title: Text('Master Card'), // Main title
                                subtitle: Text(
                                  '**** **** **** 5323',
                                ), // Subtitle
                                trailing: Icon(
                                  Icons.chevron_right,
                                ), // Icon on the right
                                onTap: () {
                                  print('Tapped on John Doe');
                                },
                              ),
                            ),

                            SizedBox(height: size.height * 0.05),
                            // product list
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product (${state.items.length})",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(height: size.height * 0.02),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.items.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: size.height * 0.1,
                                                    width: size.width * .2,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,

                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.4,
                                                          child: Text(
                                                            state
                                                                .items[index]
                                                                .title,
                                                            style: Theme.of(
                                                                  context,
                                                                )
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
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              " ${state.items[index].quantity}x"
                                                                  .toString(),
                                                              style:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .titleSmall,
                                                            ),
                                                            Text(
                                                              " \$${state.items[index].price}"
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Add some bottom padding to prevent content from being hidden behind the summary
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Fixed bottom section with price summary and checkout button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Order Summary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Summary",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal"),
                                Text(
                                  "\$${state.totalAmount.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$${state.totalAmount.toStringAsFixed(2)}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Checkout button
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            icon: Icon(Icons.payment_rounded, size: 24),
                            onPressed: () {
                              // Add your checkout logic here
                              print("Processing checkout");
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
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                  vertical: 16,
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
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
