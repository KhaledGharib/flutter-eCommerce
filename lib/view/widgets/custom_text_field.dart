import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const PaymentTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  State<PaymentTextField> createState() => _PaymentTextFieldState();
}

class _PaymentTextFieldState extends State<PaymentTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 10),
          TextFormField(
            maxLength: widget.maxLength,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator:
                widget.validator ??
                (value) {
                  if (value!.isEmpty) {
                    return '${widget.title} is required';
                  }
                  return null;
                },
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              counterText: "",
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red),
              ),
              prefixIcon: Icon(widget.icon),
              hintText: widget.hintText,
              // border: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
