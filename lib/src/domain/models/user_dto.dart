import 'package:clothing_mart/src/util/extensions.dart';

import 'product_dto.dart';

class UserDTO {
  String id, name, email, birthday, imageUrl, gender;
  int weight, height;
  List<ProductDTO> favourites, cart;
  late int age;

  UserDTO({
    this.id = "",
    required this.name,
    required this.email,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.gender,
    required this.imageUrl,
    required this.favourites,
    required this.cart,
  }) {
    if (imageUrl != "") {
      imageUrl = "users/$id";
    }

    age = DateTime.now().year - int.parse(birthday.split('-').last);
  }

  void addToFavourite(ProductDTO product) {
    favourites.add(product);
  }

  void deleteFromFavourite(ProductDTO product) {
    favourites.removeWhere((element) => element.id == product.id);
  }

  void addToCart(ProductDTO product, int numOfItem) {
    int index = cart.indexWhere(
        (element) => element.id == product.id && element.size == product.size);
    if (index != -1) {
      cart.elementAt(index).count += numOfItem;
      return;
    }
    cart.add(product);
  }

  void deleteFromCart(ProductDTO product, int numOfItem) {
    ProductDTO existProduct = cart.firstWhere((element) => element == product);
    if (existProduct.count > 1) {
      existProduct.count -= numOfItem;
      return;
    }

    cart.removeWhere(
        (element) => element.id == product.id && element.size == product.size);
  }

  List<Map<String, dynamic>> get favouriteAsMap {
    List<Map<String, dynamic>> favouritesMap = [];
    for (var product in favourites) {
      favouritesMap.add(product.toJson(false));
    }
    return favouritesMap;
  }

  List<Map<String, dynamic>> get cartAsMap {
    List<Map<String, dynamic>> cartMap = [];
    for (var product in cart) {
      cartMap.add(product.toJson(true));
    }
    return cartMap;
  }

  // Convert the object to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'gender': gender,
      'imageUrl': imageUrl.isValidURL ? "users/$id" : "",
      'favourites': favouriteAsMap,
      'cart': cartAsMap
    };
  }

  // Create a User object from a map
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        birthday: json['birthday'],
        weight: json['weight'],
        height: json['height'],
        gender: json['gender'],
        imageUrl: json['imageUrl'],
        favourites: List.from(json['favourites'])
            .map((element) => ProductDTO.fromJson(element, false))
            .toList(),
        cart: List.from(json['cart'])
            .map((element) => ProductDTO.fromJson(element, true))
            .toList());
  }
}
