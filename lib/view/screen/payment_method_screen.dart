import 'package:ecommerce/view/widgets/payment_text_field.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardExpireDateController =
      TextEditingController();
  final TextEditingController _cardCcvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Validator functions
  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) return "Card number is required";
    if (value.length < 16) return "Card number must be 16 digits";
    return null;
  }

  String? _validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) return "Cardholder name is required";
    return null;
  }

  String? _validateExpireDate(String? value) {
    if (value == null || value.isEmpty) return "Expiration date is required";
    if (value.length != 4) return "Enter valid date e.g. 1223";
    return null;
  }

  String? _validateCcv(String? value) {
    if (value == null || value.isEmpty) return "CCV is required";
    if (value.length <= 2) return "Can't be less than 3 digits";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Method")),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    PaymentTextField(
                      title: "Card Number",
                      controller: _cardNumberController,
                      hintText: "e.g. 4234 5678 9012 3456",
                      icon: Icons.credit_card,
                      validator: _validateCardNumber,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                    ),
                    PaymentTextField(
                      title: "Card Holder Name",
                      controller: _cardHolderNameController,
                      hintText: "e.g. Khaled Gharib",
                      icon: Icons.person,
                      validator: _validateCardHolderName,
                    ),
                    PaymentTextField(
                      title: "Expire Date",
                      controller: _cardExpireDateController,
                      hintText: "MM/YY",
                      icon: Icons.calendar_month,
                      validator: _validateExpireDate,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                    PaymentTextField(
                      title: "CCV Code",
                      controller: _cardCcvController,
                      hintText: "e.g. 123",
                      icon: Icons.password,
                      validator: _validateCcv,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Text(
                          "Add Payment Method",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
