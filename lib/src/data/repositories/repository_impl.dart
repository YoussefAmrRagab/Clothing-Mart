import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../config/themes/strings.dart';

import '../../util/extensions.dart';
import '../../domain/models/product_dto.dart';
import '../../domain/models/user_dto.dart';
import '../../domain/repositories/repository.dart';
import '../../util/failures.dart';
import '../data_sources/remote/remote_services.dart';

class RepositoryImpl implements Repository {
  late final RemoteServices _dataSource;

  RepositoryImpl(this._dataSource);

  @override
  Future<dynamic> getProducts() async {
    FailureEither<List> response = await executeAndHandleError<List>(() async {
      return await _dataSource.firebaseService.getProducts();
    });

    return response.fold((failure) => failure.message, (res) async {
      List<ProductDTO> productList = [];
      if (res.isNotEmpty) {
        for (var item in res) {
          ProductDTO product = ProductDTO.fromJson(Map.from(item), false);
          product.imageUrl = await _getProductImageUrl(product.imageUrl);
          productList.add(product);
        }
      }
      return productList;
    });
  }

  Future<String> _getProductImageUrl(String imagePath) async {
    FailureEither<String> imageResponse =
        await executeAndHandleError<String>(() async {
      return await _dataSource.storageService.getImageUrl(imagePath);
    });
    return imageResponse.fold(
      (failure) {
        debugPrint("ProductImageUrl error: ${failure.message}");
        return '';
      },
      (imageUrl) => imageUrl,
    );
  }

  @override
  Future<dynamic> getUser() async {
    if (!_dataSource.authService.isUserAuthenticated) {
      return null;
    }

    FailureEither<UserDTO> response =
        await executeAndHandleError<UserDTO>(() async {
      return await _dataSource.firebaseService
          .getUserData(_dataSource.authService.userId);
    });

    return response.fold((failure) => failure.message, (user) async {
      user.cart.forEach((element) async {
        FailureEither<String> response =
            await executeAndHandleError<String>(() async {
          return await _dataSource.storageService.getImageUrl(element.imageUrl);
        });
        final res = response.fold((failure) => failure.message, (imageUrl) {
          element.imageUrl = imageUrl;
          return StringManager.success;
        });
        debugPrint(res.toString());
      });

      user.favourites.forEach((element) async {
        FailureEither<String> response =
            await executeAndHandleError<String>(() async {
          return await _dataSource.storageService.getImageUrl(element.imageUrl);
        });
        final res = response.fold((failure) => failure.message, (imageUrl) {
          element.imageUrl = imageUrl;
          return StringManager.success;
        });
        debugPrint(res.toString());
      });

      if (user.imageUrl != "") {
        FailureEither<String> response =
            await executeAndHandleError<String>(() async {
          return await _dataSource.storageService.getImageUrl(user.imageUrl);
        });

        return response.fold((failure) => failure.message, (imageUrl) {
          user.imageUrl = imageUrl;
          return user;
        });
      }
      return user;
    });
  }

  @override
  Future<void> updateUserData(UserDTO user) async =>
      await executeAndHandleError<void>(() async {
        return await _dataSource.firebaseService.updateUser(user);
      });

  @override
  Future<void> updateUserFavourites(
    List<Map<String, dynamic>> userFavouritesList,
  ) async =>
      await executeAndHandleError<void>(() async {
        return await _dataSource.firebaseService.updateUserFavourites(
          _dataSource.authService.userId,
          userFavouritesList,
        );
      });

  @override
  Future<void> updateUserCart(List<Map<String, dynamic>> userCartList) async =>
      await executeAndHandleError<void>(() async {
        return await _dataSource.firebaseService.updateUserCart(
          _dataSource.authService.userId,
          userCartList,
        );
      });

  Future<Either<Failure, T>> executeAndHandleError<T>(
    Future<T> Function() function,
  ) async {
    try {
      final result = await function();
      return right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      debugPrint("error message: ${failure.message}");
      return left(failure);
    }
  }
}
