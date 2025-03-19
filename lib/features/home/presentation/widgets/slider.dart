import 'package:flutter/material.dart';
import 'package:rental_management_app/features/home/presentation/widgets/zoom_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rental_management_app/core/constants/assets_manager.dart';


class BranchMapSlider extends StatefulWidget {
  const BranchMapSlider({super.key});

  @override
  State<BranchMapSlider> createState() => _BranchMapSliderState();
}

class _BranchMapSliderState extends State<BranchMapSlider> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView(
            physics: BouncingScrollPhysics(),
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              ZoomableImage(imagePath: ImageAssets.branchmap,),
              ZoomableImage(imagePath: ImageAssets.branchmap,),
              ZoomableImage(imagePath: ImageAssets.branchmap,),              
            ],
          ),
        ),
        SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: Colors.black,
            dotColor: Colors.grey.shade300,
          ),
        )
      ],
    );
  }
}