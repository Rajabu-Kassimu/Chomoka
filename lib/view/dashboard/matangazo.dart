import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MatangazoSlider extends StatelessWidget {
  // Replace these with the actual paths to your advertisement images
  final List<String> matangazoImages = [
    'assets/images/tanzania.jpg',
    // 'assets/images/kenya.jpg',
    // 'assets/images/uganda.png',
  ];

  MatangazoSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: matangazoImages.map((imgPath) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            // Use a warm, vibrant gradient that local users might find appealing
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFB74D), // A warm orange
                Color(0xFFFFF176), // A softer yellow
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Image.asset(
            imgPath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: false,
        viewportFraction: 1.0,
        initialPage: 0,
        padEnds: false,
      ),
    );
  }
}
