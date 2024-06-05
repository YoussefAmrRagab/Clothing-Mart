import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../config/router/routes_name.dart';
import '../providers/app_provider.dart';
import '../widgets/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return Consumer<AppProvider>(
      builder: (_, __, ___) => MasonryGridView.builder(
        itemCount: provider.user.favourites.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, index) => ProductCard(
          product: provider.user.favourites[index],
          isFavourite: true,
          productIndex: index,
          onFavouriteClick: () =>
              provider.onFavouriteClick(provider.user.favourites[index]),
          onTap: () => Navigator.pushNamed(
            context,
            RoutesName.detailsRoute,
            arguments: provider.user.favourites[index],
          ),
          listLength: provider.user.favourites.length,
        ),
      ),
    );
  }
}
