import 'package:flutter/material.dart';
import '../../presentation/providers/app_provider.dart';
import 'setting_screen.dart';
import 'package:provider/provider.dart';
import '../../config/themes/styles.dart';
import '../../presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../config/themes/colors.dart';
import 'cart_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class MainScreens extends StatelessWidget {
  MainScreens({super.key});

  final List<StatelessWidget> screens = [
    HomeScreen(),
    const CartScreen(),
    const FavoriteScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, appProvider, __) => Scaffold(
        appBar: appProvider.index == 1
            ? AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  style: ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(width: 1, color: ColorManager.secondaryColor),
                    ),
                  ),
                  onPressed: () {
                    appProvider.changeIndex(1);
                    appProvider.animatingState(false);
                  },
                ),
                title: Text(
                  'Checkout',
                  style: TextStyles.encodeSansW800S24,
                ),
                centerTitle: true,
              )
            : appProvider.index == 2
                ? AppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Favorites',
                      style: TextStyles.encodeSansW800S24,
                    ),
                    centerTitle: true,
                  )
                : null,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            screens[appProvider.index],
            Container(
              color: Colors.white,
              height: 44,
            ),
            CustomBottomNavigationBar(
              radiusSize: 100,
              height: 62,
              backgroundColor: ColorManager.primaryColor,
              index: appProvider.index,
              icons: const [
                Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                ),
                Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                ),
                Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                ),
                Icon(
                  Icons.settings_rounded,
                  color: Colors.white,
                ),
              ],
              hoverColor: Colors.white.withOpacity(0.2),
              onTap: (int index) {
                appProvider.changeIndex(index);
                appProvider.animatingState(false);
              },
              onAnimatingEnd: () {
                if (1 == appProvider.index &&
                    appProvider.user.cart.isNotEmpty) {
                  appProvider.animatingState(true);
                }
              },
              isAnimatingEnd: appProvider.isAnimatingEnd,
            ),
          ],
        ),
      ),
    );
  }
}
