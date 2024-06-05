import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/themes/strings.dart';
import '../../util/extensions.dart';
import '../../config/router/routes_name.dart';
import '../../domain/models/product_dto.dart';
import '../../domain/models/user_dto.dart';
import '../../domain/repositories/repository.dart';

class AppProvider extends ChangeNotifier {
  late final Repository _repository;

  AppProvider(
    this._repository,
  );

  int index = 0;

  bool isAnimatingEnd = false;

  List<ProductDTO> _originalProducts = [];
  final List<ProductDTO> _filteredProducts = [];

  List<ProductDTO> get products =>
      _filteredProducts.isNotEmpty ? _filteredProducts : _originalProducts;
  late UserDTO user;

  Future<String> fetchData() async {
    final userResponse = await _repository.getUser();
    if (userResponse is! UserDTO) {
      if (userResponse != null) {
        (userResponse as String).showToast;
      }
      return RoutesName.loginRoute;
    }
    user = userResponse;

    final products = await _repository.getProducts();
    if (products is! List<ProductDTO>) {
      (products as String).showToast;
    }
    _originalProducts = products;

    for (var e in user.favourites) {
      int index = this.products.indexWhere((element) => element.id == e.id);
      if (index > -1) {
        this.products[index].isFavourite = true;
      }
    }

    return RoutesName.mainRoute;
  }

  void onFavouriteClick(ProductDTO product) {
    product.isFavourite
        ? user.deleteFromFavourite(product)
        : user.addToFavourite(product);
    _repository.updateUserFavourites(user.favouriteAsMap);
    notifyListeners();
  }

  void filterProducts(List<String> filtersText) {
    _filteredProducts.clear();
    for (var filterText in filtersText) {
      _filteredProducts.addAll(
        _originalProducts.where(
          (element) =>
              filterText == 'All' ? true : element.category == filterText,
        ),
      );
      debugPrint(filterText);
    }
    notifyListeners();
  }

  void addToCart(ProductDTO product, int numOfItem) {
    if (product.size == null) {
      return;
    }
    user.addToCart(product, numOfItem);
    _repository.updateUserCart(user.cartAsMap);
    notifyListeners();
  }

  void changeIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  void animatingState(bool isAnimatingEnd) {
    this.isAnimatingEnd = isAnimatingEnd;
    notifyListeners();
  }

  void incrementProductCount(ProductDTO product) {
    if (product.count == 99) {
      return;
    }
    user.addToCart(product, 1);
    _repository.updateUserCart(user.cartAsMap);
    notifyListeners();
  }

  void decrementProductCount(ProductDTO product) {
    user.deleteFromCart(product, 1);
    _repository.updateUserCart(user.cartAsMap);
    notifyListeners();
  }

  final List<String> _options = [StringManager.male, StringManager.female];

  String get maleOption => _options[0];

  String get femaleOption => _options[1];

  late String _currentOption = user.gender;

  String get currentOption => _currentOption;

  set currentOption(String selectedOption) {
    _currentOption = selectedOption;
    notifyListeners();
  }

  late String _birthdate = user.birthday;

  set birthdate(String date) {
    _birthdate = date;
    notifyListeners();
  }

  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  set selectImage(XFile? pickedImage) {
    _selectedImage = pickedImage;
    notifyListeners();
  }

  String updateUser(
    String name,
    String birthday,
    String weight,
    String height,
  ) {
    String? validation = isValid(name, birthday, weight, height);
    if (validation == null) {
      user.name = name;
      user.birthday = birthday;
      user.gender = _currentOption;
      user.weight = int.parse(weight);
      user.height = int.parse(height);
      _repository.updateUserData(user);
      notifyListeners();
      return "updated";
    }
    return validation;
  }

  String? isValid(
    String name,
    String birthday,
    String weight,
    String height,
  ) {
    if (name.isEmpty) {
      return StringManager.nameFieldEmpty;
    } else if (birthday.isEmpty) {
      return StringManager.birthdayFieldEmpty;
    } else if (weight.isEmpty) {
      return StringManager.weightFieldEmpty;
    } else if (height.isEmpty) {
      return StringManager.heightFieldEmpty;
    }
    return null;
  }
}
