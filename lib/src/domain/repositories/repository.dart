import '../models/user_dto.dart';

abstract class Repository {
  Future<dynamic> getProducts();

  Future<dynamic> getUser();

  Future<dynamic> updateUserData(UserDTO user, String? userImage);

  Future<void> updateUserFavourites(
    List<Map<String, dynamic>> userFavouritesList,
  );

  Future<void> updateUserCart(
    List<Map<String, dynamic>> userCartList,
  );

  Future<void> logout();
}
