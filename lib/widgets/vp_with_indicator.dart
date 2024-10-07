import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/models/menu_item.dart';
import 'package:fooddeliveryapp/utils/data_extensions.dart';
import 'package:fooddeliveryapp/widgets/custom_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/colors.dart';

class ViewPagerWithDashIndicator extends StatefulWidget {
  final List<MenuItem> menuItems;

  const ViewPagerWithDashIndicator({
    super.key,
    required this.menuItems,
  });

  @override
  ViewPagerWithDashIndicatorState createState() =>
      ViewPagerWithDashIndicatorState();
}

class ViewPagerWithDashIndicatorState
    extends State<ViewPagerWithDashIndicator> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PageView for displaying items
        _buildPageView(widget.menuItems).expandBy(1),
        // Dot indicator for navigation
        _buildDotIndicator(widget.menuItems.length),
      ],
    );
  }

  // Helper method to build the page view
  Widget _buildPageView(List<MenuItem> items) {
    return PageView.builder(
      controller: _pageController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final gradient = index.isEven ? homeCardGradient1 : homeCardGradient2;
        return _buildCardView(items[index], gradient);
      },
    );
  }

  // Helper method to build individual card views
  Widget _buildCardView(MenuItem data, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          _buildItemInfo(
            data.shortDesc ?? "",
            data.price.getDisplayPrice(),
            gradient,
          ),
          _buildItemImage(data.imageUrl ?? ""),
        ],
      ),
    );
  }

  // Helper method to display the item info with gradient background
  Widget _buildItemInfo(String info, String price, List<Color> gradient) {
    return CustomBackground(
      width: double.infinity,
      height: double.infinity,
      gradient: LinearGradient(colors: gradient),
      cornerRadius: 22,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                info,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ).expandBy(3),
              const SizedBox(width: 24),
              CustomBackground(
                height: 40,
                child: Center(
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).expandBy(1),
            ],
          ),
        ),
      ),
    ).addPaddingLTRB(top: 24);
  }

  // Helper method to display the item image
  Widget _buildItemImage(String imageUrl) {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.network(
        imageUrl,
        width: MediaQuery.of(context).size.width / 2.15,
      ),
    );
  }

  // Helper method to build the dot indicator
  Widget _buildDotIndicator(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: count,
        effect: ScrollingDotsEffect(
          activeDotColor: Colors.black,
          dotColor: Colors.grey,
          dotHeight: 4,
          dotWidth:
              count > 4 ? 60 : (MediaQuery.of(context).size.width / count) - 24,
          spacing: 16,
          activeDotScale: 1.11,
        ),
      ),
    );
  }
}
