import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/router/routes_name.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/home_provider.dart';
import '../../util/extensions.dart';
import '../../presentation/providers/app_provider.dart';
import '../../util/constants.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';
import '../widgets/custom_filter_chip.dart';
import '../widgets/image_network.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  final OutlineInputBorder outlineInputBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: ColorManager.secondaryColor),
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(provider),
          searchAndFilterBar(),
          6.marginHeight,
          chipGroup(homeProvider, provider),
          4.marginHeight,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Consumer<AppProvider>(
                builder: (_, __, ___) => MasonryGridView.builder(
                  itemCount: provider.products.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (_, index) => ProductCard(
                    product: provider.products[index],
                    listLength: provider.products.length,
                    isFavourite: provider.products[index].isFavourite,
                    productIndex: index,
                    onFavouriteClick: () =>
                        provider.onFavouriteClick(provider.products[index]),
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesName.detailsRoute,
                      arguments: provider.products[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView chipGroup(
    HomeProvider homeProvider,
    AppProvider provider,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          16.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip1,
            builder: (_, value, __) => CustomFilterChip(
              text: 'All Items',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip1();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => false,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Recommendation',
              onClick: () {
                // List<String> filtersText = homeProvider.toggleChip2();
                // provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip2,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Smart Casual Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip2();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip3,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Uni Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip3();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip4,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Sporty Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip4();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.chip5,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Formal Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip5();
                provider.filterProducts(filtersText);
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
        ],
      ),
    );
  }

  Row searchAndFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 54,
          width: 265,
          child: TextFormField(
            controller: _searchController,
            style: const TextStyle(
              fontSize: 16,
              height: 1,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
                color: ColorManager.grey2Color,
              ),
              hintText: 'Search clothes. . .',
              hintStyle: const TextStyle(
                fontFamily: 'EncodeSans',
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: outlineInputBorderStyle,
              focusedBorder: outlineInputBorderStyle,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: 50,
            width: 48,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: ColorManager.primaryColor,
              ),
              child: SvgPicture.asset(
                'assets/images/filter.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding header(AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello, Welcome",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                provider.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              )
            ],
          ),
          userImage(provider.user.imageUrl),
        ],
      ),
    );
  }

  ClipOval userImage(String imageUrl) {
    return ClipOval(
      child: CircleAvatar(
        radius: Dimensions.s28,
        backgroundColor: ColorManager.primaryColor,
        child: imageUrl == ""
            ? Padding(
                padding: const EdgeInsets.all(Dimensions.s16),
                child: Image.asset(
                  Constants.userAsset,
                  color: Colors.white,
                ),
              )
            : ImageNetwork(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                padding: const EdgeInsets.only(
                  bottom: Dimensions.s6,
                  left: Dimensions.s16,
                  right: Dimensions.s16,
                ),
                imageSize: Dimensions.s80,
                circularProgressIndicatorColor: Colors.white,
              ),
      ),
    );
  }
}
