import 'package:ecommerce/utility/app_images.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final size;
  const TopBar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              // maxRadius: 3,
              radius: size.height * 0.03,
              backgroundImage: AssetImage(AppImages.userImage),
            ),
            SizedBox(width: size.width * 0.03),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Khaled",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Let's go shopping",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: size.width * 0.03),

            Icon(Icons.notifications_none_rounded),
          ],
        ),
      ],
    );
  }
}
