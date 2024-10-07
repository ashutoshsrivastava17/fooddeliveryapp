import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/models/menu_item.dart';
import 'package:fooddeliveryapp/repository/cart_repository.dart';
import 'package:fooddeliveryapp/repository/menu_repository.dart';
import 'package:fooddeliveryapp/ui/cart_detail_widget.dart';
import 'package:fooddeliveryapp/ui/widgets/circular_dot.dart';
import 'package:fooddeliveryapp/ui/widgets/custom_background.dart';
import 'package:fooddeliveryapp/ui/widgets/custom_bottom_sheet.dart';
import 'package:fooddeliveryapp/ui/widgets/vp_with_indicator.dart';

import '../utils/colors.dart';
import '../utils/data_extensions.dart';
import 'product_detail_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showFloatingActionButton(bool status) {
    if (!CartRepository.isCartEmpty()) {
      setState(() {
        status ? _controller.forward() : _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getAppBarTitle(context),
        actions: const [Icon(Icons.search), SizedBox(width: 16)],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: _getHomePageBody(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButtonWidget(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "https://i.pinimg.com/originals/93/5e/f3/935ef3e9c164fe37ddde01ccd8cec4ba.gif",
          // "https://cdn-icons-png.flaticon.com/512/1027/1027179.png",
          width: 200,
        ),
        const Text(
          "Cooking Drawer Menus",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ).addMarginSymmetric(vertical: 16)
      ],
    ));
  }

  Widget _getAppBarTitle(BuildContext context) {
    final double topNotchWidth = MediaQuery.of(context).size.width / 1.8;
    return Center(
      child: CustomBackground(
        width: topNotchWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("100a Ealing Rd",
                style: TextStyle(color: Colors.white, fontSize: 14)),
            const CircleDot(diameter: 4).addMarginSymmetric(horizontal: 8),
            const Text("24 mins",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _getHomePageBody(BuildContext context) {
    List<MenuItem> menuItems = MenuRepository.getMenuItems();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Hits of the week",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))
          .addPaddingAll(16),
      _getViewPager(context, menuItems),
      _getFilters(MenuRepository.getHomeFilters()),
      _getProductList(menuItems),
    ]);
  }

  Widget _getViewPager(BuildContext context, List<MenuItem> menuItems) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.25,
      child: ViewPagerWithDashIndicator(menuItems: menuItems),
    );
  }

  Widget _getFilters(List<String> filters) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return CustomBackground(
            height: 35,
            cornerRadius: 16,
            backgroundColor: filterBackground,
            child: (index == 0
                    ? const Icon(Icons.sort)
                    : Text(
                        filters[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ))
                .addPaddingSymmetric(horizontal: 16),
          ).addPaddingLTRB(
              left: (index == 0 ? 16 : 4), top: 0, right: 4, bottom: 0);
        },
      ),
    );
  }

  Widget _getProductList(List<MenuItem> menuItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showFloatingActionButton(false);
            showModalBottomSheet(
                context: context,
                enableDrag: true,
                isDismissible: true,
                scrollControlDisabledMaxHeightRatio: 0.9,
                backgroundColor: Colors.transparent,
                builder: (context) => CustomBottomSheet(
                      child: ProductDetailWidget(menuItem: menuItems[index]),
                    )).then((_) => showFloatingActionButton(true));
          },
          child: _getProductItem(menuItems[index])
              .addPaddingSymmetric(vertical: 8),
        );
      },
    );
  }

  Widget _getProductItem(MenuItem menuItem) {
    return Row(children: [
      Image.network(
        menuItem.imageUrl ?? "",
        width: MediaQuery.of(context).size.width / 4,
      ).addMarginLTRB(right: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(menuItem.name ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            _getProductInfo(menuItem).addMarginLTRB(top: 8),
          ],
        ),
      ),
    ]).addPaddingSymmetric(vertical: 8, horizontal: 16);
  }

  Widget _getProductInfo(MenuItem menuItem) {
    return Row(
      children: [
        if (menuItem.price != null)
          CustomBackground(
            backgroundColor: filterBackground,
            height: 40,
            child: Text(menuItem.price.getDisplayPrice(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))
                .addPaddingSymmetric(horizontal: 16),
          ).addMarginLTRB(right: 16),
        if (menuItem.nutritions?.isNotEmpty ?? false)
          Text(
            "${menuItem.nutritions![0].value ?? ""} ${menuItem.nutritions![0].unit ?? ""}",
            style: const TextStyle(
                fontSize: 18,
                color: filterBackground,
                fontWeight: FontWeight.w600),
          ),
      ],
    );
  }

  Widget _floatingActionButtonWidget() {
    return CartRepository.isCartEmpty()
        ? const SizedBox.shrink()
        : SlideTransition(
            position: _animation,
            child: InkWell(
              onTap: () {
                showFloatingActionButton(false);
                showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  isDismissible: true,
                  scrollControlDisabledMaxHeightRatio: 0.9,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const CustomBottomSheet(
                    child: CartDetailWidget(),
                  ),
                ).then((_) => showFloatingActionButton(true));
              },
              child: CustomBackground(
                cornerRadius: 16,
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Cart",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("24 min",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        const CircleDot(diameter: 5)
                            .addMarginSymmetric(horizontal: 8),
                        Text(CartRepository.getTotalPrice().getDisplayPrice(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ).addPaddingSymmetric(horizontal: 16),
              ),
            ).addPaddingAll(16),
          );
  }
}
