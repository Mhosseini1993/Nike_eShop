import 'package:flutter/material.dart';
import 'package:nike/Data/Common/Constants.dart';
import 'package:nike/Data/Models/Baner/Baner.dart';
import 'package:nike/Screens/Widget/ImageLoader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BanerSlider extends StatelessWidget {
  final List<Baner> baners;
  final PageController _pageController = PageController();

  BanerSlider({Key? key, required this.baners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: defaultScrollPhysics,
            scrollDirection: Axis.horizontal,
            itemCount: baners.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: ImageLoader(
                  imageUrl: baners.elementAt(index).image,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count:  baners.length,
                axisDirection: Axis.horizontal,
                effect:   WormEffect(
                    spacing:  4.0,
                    radius:  4.0,
                    dotWidth:  20.0,
                    dotHeight:  3.0,
                    paintStyle:  PaintingStyle.fill,
                    dotColor:  Colors.grey.shade400,
                    activeDotColor:  Theme.of(context).colorScheme.onBackground
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
