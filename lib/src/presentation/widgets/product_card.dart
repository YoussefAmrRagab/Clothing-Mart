import 'package:flutter/material.dart';
import '../../config/themes/dimens.dart';
import '../../presentation/providers/app_provider.dart';
import 'package:provider/provider.dart';
import '../../util/extensions.dart';
import '../../domain/models/product_dto.dart';
import '../../config/themes/colors.dart';
import 'image_network.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.productIndex,
    required this.onFavouriteClick,
    required this.onTap,
    required this.listLength,
    required this.isFavourite,
  });

  final ProductDTO product;
  final int productIndex;
  final VoidCallback onFavouriteClick;
  final VoidCallback onTap;
  final int listLength;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: product.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: ImageNetwork(
                      imageUrl: product.imageUrl,
                      padding: const EdgeInsets.all(Dimensions.s40),
                      circularProgressIndicatorColor: ColorManager.primaryColor,
                      circularProgressIndicatorColorHeight: Dimensions.s160,
                      circularProgressIndicatorColorWidth: Dimensions.s100,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'EncodeSans',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    product.brand,
                    style: TextStyle(
                      fontFamily: 'EncodeSans',
                      fontWeight: FontWeight.w300,
                      color: ColorManager.lightGrayColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.price}\$",
                      style: const TextStyle(
                        fontFamily: 'EncodeSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                        ),
                        4.marginWidth,
                        Text(
                          "${product.rating}",
                          style: const TextStyle(
                            fontFamily: 'EncodeSans',
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                productIndex == listLength - 1
                    ? 80.marginHeight
                    : 0.marginHeight
              ],
            ),
          ),
          GestureDetector(
            onTap: onFavouriteClick,
            child: Container(
              padding: const EdgeInsets.only(
                right: 5,
                bottom: 4,
                top: 6,
                left: 5,
              ),
              margin: const EdgeInsets.only(top: 22, right: 18),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                isFavourite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
