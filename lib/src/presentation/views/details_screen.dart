import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../presentation/providers/details_provider.dart';
import 'package:provider/provider.dart';
import '../../config/themes/strings.dart';
import '../../presentation/widgets/counter_button.dart';
import '../../presentation/widgets/size_button.dart';
import '../../presentation/widgets/image_network.dart';
import '../../config/themes/styles.dart';
import '../../util/extensions.dart';
import '../../config/themes/dimens.dart';
import '../../domain/models/product_dto.dart';
import '../../config/themes/colors.dart';
import '../providers/app_provider.dart';
import '../widgets/animated_snackbar.dart';
import '../widgets/circular_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final detailsProvider =
        Provider.of<DetailsProvider>(context, listen: false);

    final product = ModalRoute.of(context)!.settings.arguments as ProductDTO;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: PopScope(
            onPopInvoked: (_) {
              detailsProvider.clear();
              product.count = 1;
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: Dimensions.s20,
                left: Dimensions.s20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: product.id,
                        child: ImageNetwork(
                          imageUrl: product.imageUrl,
                          padding: const EdgeInsets.all(Dimensions.s40),
                          imageSize: Dimensions.s400,
                          circularProgressIndicatorColor:
                              ColorManager.blackColor,
                          circularProgressIndicatorColorHeight: Dimensions.s160,
                          circularProgressIndicatorColorWidth: Dimensions.s100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.s8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularButton(
                              icon: Icons.arrow_back_ios_new_rounded,
                              padding: const EdgeInsets.only(
                                top: Dimensions.s8,
                                left: Dimensions.s7,
                                right: Dimensions.s8,
                                bottom: Dimensions.s7,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                detailsProvider.clear();
                              },
                            ),
                            Consumer<AppProvider>(
                              builder: (_, __, ___) => CircularButton(
                                icon: product.isFavourite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                padding: const EdgeInsets.only(
                                  top: Dimensions.s8,
                                  left: Dimensions.s8,
                                  right: Dimensions.s8,
                                  bottom: Dimensions.s7,
                                ),
                                onTap: () {
                                  provider.onFavouriteClick(product);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  10.marginHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _title(product.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CounterButton(
                              icon: Icons.remove_rounded,
                              onTap: () {
                                detailsProvider.decrementCounter();
                              }),
                          10.marginWidth,
                          Selector<DetailsProvider, int>(
                            selector: (_, provider) => provider.count,
                            builder: (_, count, ___) => Text('$count'),
                          ),
                          10.marginWidth,
                          CounterButton(
                              icon: Icons.add_rounded,
                              onTap: () {
                                detailsProvider.incrementCounter();
                              }),
                        ],
                      ),
                    ],
                  ),
                  10.marginHeight,
                  Text("Description", style: TextStyles.encodeSansW600S16),
                  Text(product.description),
                  const Divider(
                    color: Colors.black26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Brand", style: TextStyles.encodeSansW600S16),
                      Text(product.brand),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Review", style: TextStyles.encodeSansW600S16),
                      _rating(product.rating, product.reviews),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  Text(
                    'Choose Size',
                    style: TextStyles.encodeSansW600S16,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 40,
                    child: ListView.builder(
                      itemCount: product.sizes.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) =>
                          Selector<DetailsProvider, String?>(
                              selector: (_, provider) => provider.selectedSize,
                              builder: (_, selectedSize, __) => SizeButton(
                                    size: product.sizes[index],
                                    selectedSize: selectedSize,
                                    onTap: () {
                                      detailsProvider
                                          .selectSize(product.sizes[index]);
                                    },
                                  )),
                    ),
                  ),
                  10.marginHeight,
                  _button(
                    product.price,
                    () {
                      ProductDTO item = ProductDTO(
                        category: product.category,
                        description: product.description,
                        gender: product.gender,
                        id: product.id,
                        name: product.name,
                        price: product.price,
                        rating: product.rating,
                        brand: product.brand,
                        sizes: product.sizes,
                        reviews: product.reviews,
                        weight: product.weight,
                        count: detailsProvider.count,
                        size: detailsProvider.selectedSize,
                        imageUrl: product.imageUrl,
                      );
                      String res =
                          provider.addToCart(item, detailsProvider.count);
                      if (res == StringManager.success) {
                        AnimatedSnackBar.show(
                          context: context,
                          message: const Text(
                            "Your item has added to your cart",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: const Icon(
                            Icons.done_rounded,
                            color: Colors.green,
                            size: 30,
                          ),
                        );
                      } else {
                        AnimatedSnackBar.show(
                          context: context,
                          message: Text(
                            res,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                        );
                      }
                    },
                  ),
                  10.marginHeight,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _title(String title) {
    return SizedBox(
      width: Dimensions.s180,
      child: Text(
        title,
        style: TextStyles.encodeSansW800S22,
      ),
    );
  }

  GestureDetector _button(
    int price,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.s60,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.s100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.white,
            ),
            10.marginWidth,
            Text(
              StringManager.addToCart,
              style: TextStyles.whiteEncodeSansW800S18,
            ),
            const VerticalDivider(
              color: Colors.white,
              thickness: Dimensions.s2,
              indent: Dimensions.s20,
              endIndent: Dimensions.s20,
            ),
            Selector<DetailsProvider, int>(
              selector: (_, provider) => provider.count,
              builder: (_, item, __) => Text(
                '\$$price x$item',
                style: TextStyles.whiteEncodeSansW800S18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _rating(double rate, int reviews) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBar(
          maxRating: Dimensions.s5,
          minRating: Dimensions.s0,
          initialRating: rate,
          allowHalfRating: true,
          itemSize: Dimensions.s22,
          ratingWidget: RatingWidget(
            full: Icon(Icons.star_rate_rounded, color: ColorManager.starColor),
            half: Icon(Icons.star_half_rounded, color: ColorManager.starColor),
            empty:
                Icon(Icons.star_border_rounded, color: ColorManager.starColor),
          ),
          onRatingUpdate: (_) {},
          ignoreGestures: true,
        ),
        6.marginWidth,
        Text(rate.toString(), style: TextStyle(fontSize: 12)),
        4.marginWidth,
        Text(
          "($reviews reviews)",
          style: TextStyle(color: ColorManager.reviewsColor, fontSize: 12),
        )
      ],
    );
  }
}
