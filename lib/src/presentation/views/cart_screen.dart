import 'package:flutter/material.dart';
import '../../presentation/widgets/image_network.dart';
import '../../util/extensions.dart';
import 'package:provider/provider.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';
import '../../config/themes/styles.dart';
import '../providers/app_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: Consumer<AppProvider>(
            builder: (_, __, ___) => provider.user.cart.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: provider.user.cart.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ImageNetwork(
                                  imageUrl: provider.user.cart[index].imageUrl,
                                  padding: const EdgeInsets.all(Dimensions.s10),
                                  circularProgressIndicatorColor:
                                      ColorManager.primaryColor,
                                  circularProgressIndicatorColorHeight:
                                      Dimensions.s10,
                                  circularProgressIndicatorColorWidth:
                                      Dimensions.s10,
                                  imageSize: 80,
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2.8,
                                        child: Text(
                                          provider.user.cart[index].name,
                                          style: TextStyles.encodeSansW800S18,
                                        ),
                                      ),
                                      Text(
                                        "Size: ${provider.user.cart[index].size!}",
                                        style: TextStyles.encodeSansW200S14,
                                      ),
                                      Text(
                                        provider.user.cart[index].brand,
                                        style: TextStyles.greyEncodeSansW100S12,
                                      ),
                                      10.marginHeight,
                                      Text(
                                          "${provider.user.cart[index].price}\$"),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: ColorManager.lightBlackColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            provider.decrementProductCount(
                                                provider.user.cart[index]);
                                          },
                                          child: const Icon(
                                            Icons.remove_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Consumer<AppProvider>(
                                          builder: (_, __, ___) => Text(
                                            "${provider.user.cart[index].count}",
                                            style: TextStyles
                                                .whiteEncodeSansW800S18,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            provider.incrementProductCount(
                                                provider.user.cart[index]);
                                          },
                                          child: const Icon(
                                            Icons.add_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                            index == provider.user.cart.length - 1
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color: ColorManager.lightGrayColor,
                                        thickness: 2,
                                      ),
                                      4.marginHeight,
                                      Text("Shipping Information",
                                          style: TextStyles.encodeSansW600S16),
                                      10.marginHeight,
                                      Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: ColorManager.secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/visa.png',
                                                height: 40,
                                                width: 40,
                                              ),
                                              10.marginWidth,
                                              Text(
                                                "**** **** **** 2143",
                                                style: TextStyles
                                                    .encodeSansW200S14,
                                              ),
                                              (MediaQuery.sizeOf(context)
                                                          .width /
                                                      3.4)
                                                  .marginWidth,
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: ColorManager
                                                    .lightBlackColor,
                                                size: 30,
                                              )
                                            ]),
                                      ),
                                      10.marginHeight,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Consumer<AppProvider>(
                                            builder: (_, __, ___) => Text(
                                                "Total (${provider.user.cart.fold(0, (previousValue, element) => previousValue + element.count)} items)",
                                                style: TextStyles
                                                    .encodeSansW200S14),
                                          ),
                                          Consumer<AppProvider>(
                                            builder: (_, __, ___) => Text(
                                                "${provider.user.cart.fold(0.0, (previousValue, element) => previousValue + (element.price * element.count))}\$",
                                                style: TextStyles
                                                    .encodeSansW800S12),
                                          )
                                        ],
                                      ),
                                      6.marginHeight,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Shipping Fee",
                                              style:
                                                  TextStyles.encodeSansW200S14),
                                          Text("0\$",
                                              style:
                                                  TextStyles.encodeSansW800S12)
                                        ],
                                      ),
                                      6.marginHeight,
                                      Divider(
                                        color: ColorManager.secondaryColor,
                                        thickness: 1,
                                      ),
                                      6.marginHeight,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Sub Total",
                                              style:
                                                  TextStyles.encodeSansW200S14),
                                          Consumer<AppProvider>(
                                            builder: (_, __, ___) => Text(
                                                "${provider.user.cart.fold(0.0, (previousValue, element) => previousValue + (element.price * element.count))}\$",
                                                style: TextStyles
                                                    .encodeSansW800S12),
                                          )
                                        ],
                                      ),
                                      100.marginHeight
                                    ],
                                  )
                                : Divider(
                                    color: ColorManager.secondaryColor,
                                    thickness: 1,
                                  )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
