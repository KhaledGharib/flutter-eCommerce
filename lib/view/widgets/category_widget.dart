import 'package:ecommerce/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCategory.length,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20.0),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  dummyCategory[index].imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
    );
  }
}
