import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/model/payment_method_model.dart';
import 'package:ecommerce/utility/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  String maskAndFormatCardNumber(String cardNumber) {
    if (cardNumber.length < 12) {
      return "Invalid card number"; // Handle invalid cases
    }

    // Mask the first 12 digits
    String masked = '*' * 12 + cardNumber.substring(12);

    // Add spaces every 4 digits
    return masked
        .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
        .trim();
  }

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
                            // Placeholder(),
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
                                title: Text("Homex"),
                                subtitle: Text(
                                  "123 Main St, New York, NY 10001",
                                ),
                                trailing: Icon(Icons.chevron_right_rounded),
                                onTap: () {},
                              ),
                            ),
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
                                  Icons.chevron_right_rounded,
                                ), // Icon on the right
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    backgroundColor: Colors.grey[100],
                                    showDragHandle: true,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        child: SafeArea(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 18.0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Payment Method',
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.titleLarge,
                                                ),
                                                SizedBox(height: 16),
                                                Flexible(
                                                  child: ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        paymentMethodList
                                                            .length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(height: 8),
                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          border: Border.all(
                                                            color:
                                                                Colors
                                                                    .grey
                                                                    .shade300,
                                                          ),
                                                        ),
                                                        // todo: wrap with card
                                                        child: ListTile(
                                                          leading: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .grey[200],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                            child: SvgPicture.asset(
                                                              paymentMethodList[index]
                                                                  .icon,
                                                              width: 40,
                                                              height: 40,
                                                            ),
                                                          ),
                                                          title: Text(
                                                            paymentMethodList[index]
                                                                .name,

                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            maskAndFormatCardNumber(
                                                              paymentMethodList[index]
                                                                  .number,
                                                            ),
                                                          ),
                                                          trailing: Radio<int>(
                                                            value: index,
                                                            groupValue: 1,
                                                            onChanged:
                                                                (value) {},
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            Colors
                                                                .grey
                                                                .shade300,
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      leading: Container(
                                                        padding: EdgeInsets.all(
                                                          8,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[200],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              Theme.of(
                                                                context,
                                                              ).primaryColor,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        'Add new payment method',
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(
                                                                context,
                                                              ).primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 24),
                                                FilledButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty.all(
                                                          Size(
                                                            double.infinity,
                                                            56,
                                                          ),
                                                        ),
                                                    shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder
                                                    >(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Confirm Payment',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
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
