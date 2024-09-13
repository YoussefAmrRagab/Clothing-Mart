import 'package:lottie/lottie.dart';

import '../../util/constants.dart';
import '../../util/extensions.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/product_card.dart';
import '../widgets/image_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';
import '../widgets/custom_filter_chip.dart';
import '../../config/router/routes_name.dart';
import '../../presentation/providers/app_provider.dart';
import '../../presentation/providers/home_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
          searchAndFilterBar(provider, context),
          6.marginHeight,
          chipGroup(homeProvider, provider),
          4.marginHeight,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Consumer<AppProvider>(
                builder: (_, __, ___) => provider.products.isEmpty
                    ? Center(
                        child: Lottie.asset(
                          Constants.emptySearchAsset,
                          width: 280,
                          height: 280,
                        ),
                      )
                    : MasonryGridView.builder(
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
                          onFavouriteClick: () => provider
                              .onFavouriteClick(provider.products[index]),
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
            selector: (_, provider) => provider.allChips,
            builder: (_, value, __) => CustomFilterChip(
              text: 'All Items',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip('all');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.recommendationChip,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Recommendation',
              onClick: () {
                List<String> filtersText =
                    homeProvider.toggleChip('recommendation');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.smartCasualChip,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Smart Casual Outfits',
              onClick: () {
                List<String> filtersText =
                    homeProvider.toggleChip('smartCasual');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.uniChip,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Uni Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip('uni');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.sportyChip,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Sporty Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip('sporty');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
          Selector<HomeProvider, bool>(
            selector: (_, provider) => provider.formalChip,
            builder: (_, value, __) => CustomFilterChip(
              text: 'Formal Outfits',
              onClick: () {
                List<String> filtersText = homeProvider.toggleChip('formal');
                provider.categories = filtersText;
              },
              isSelected: value,
            ),
          ),
          10.marginWidth,
        ],
      ),
    );
  }

  Row searchAndFilterBar(AppProvider appProvider, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 54,
          width: MediaQuery.sizeOf(context).width - 100,
          child: Consumer<HomeProvider>(
            builder: (_, provider, ___) => TextFormField(
              cursorColor: ColorManager.primaryColor,
              onChanged: (value) {
                appProvider.filterText = value;
              },
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
                provider.user!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              )
            ],
          ),
          userImage(provider.user!.imageUrl),
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
