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
  bool isLoading = false;

  List<ProductDTO> _originalProducts = [];
  final List<ProductDTO> _filteredProducts = [];

  List<ProductDTO> get products => _filteredProducts.isNotEmpty
      ? _filteredProducts
      : _filterText != ''
          ? []
          : _originalProducts;

  UserDTO? user;
  List<String> _categories = ['All'];
  String _filterText = '';

  set categories(List<String> value) {
    _categories = value;
    filterProducts();
  }

  set filterText(String value) {
    _filterText = value;
    filterProducts();
  }

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

    for (var product in user!.favourites) {
      product.isFavourite = true;
      int index =
          this.products.indexWhere((element) => element.id == product.id);
      if (index > -1) {
        this.products[index].isFavourite = true;
      }
    }

    return RoutesName.mainRoute;
  }

  void onFavouriteClick(ProductDTO product) {
    product.isFavourite
        ? user!.deleteFromFavourite(product)
        : user!.addToFavourite(product);
    product.isFavourite = !product.isFavourite;
    products.firstWhere((element) => element.id == product.id).isFavourite =
        product.isFavourite;
    _repository.updateUserFavourites(user!.favouriteAsMap);
    notifyListeners();
  }

  void filterProducts() {
    _filteredProducts.clear();
    if (_categories.isNotEmpty) {
      for (var filterText in _categories) {
        _filteredProducts.addAll(
          _originalProducts.where((element) => filterText == 'All'
              ? true
              : filterText == "Recommendation Outfits"
                  ? element.gender == user!.gender &&
                      user!.weight >= element.minWeight &&
                      user!.weight <= element.maxWeight
                  : element.category == filterText),
        );
      }
    }
    if (_filterText != '' && _filterText.trim().isNotEmpty) {
      _filteredProducts.retainWhere(
        (element) => element.name
            .toLowerCase()
            .startsWith(_filterText.trim().toLowerCase()),
      );
    }
    notifyListeners();
  }

  String addToCart(ProductDTO product, int numOfItem) {
    if (product.size == null) {
      return "Please select your size first";
    } else {
      user!.addToCart(product, numOfItem);
      _repository.updateUserCart(user!.cartAsMap);
      notifyListeners();
      return StringManager.success;
    }
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
    user!.addToCart(product, 1);
    _repository.updateUserCart(user!.cartAsMap);
    notifyListeners();
  }

  void decrementProductCount(ProductDTO product) {
    user!.deleteFromCart(product, 1);
    _repository.updateUserCart(user!.cartAsMap);
    if (user!.cart.isEmpty) {
      isAnimatingEnd = false;
    }
    notifyListeners();
  }

  final List<String> _options = [StringManager.male, StringManager.female];

  String get maleOption => _options[0];

  String get femaleOption => _options[1];

  late String _currentOption = user!.gender;

  String get currentOption => _currentOption;

  set currentOption(String selectedOption) {
    _currentOption = selectedOption;
    notifyListeners();
  }

  set birthdate(String date) {
    user!.birthday = date;
    notifyListeners();
  }

  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  set selectImage(XFile? pickedImage) {
    _selectedImage = pickedImage;
    notifyListeners();
  }

  Future<void> updateUser(
    String name,
    String birthday,
    String weight,
    String height,
    Function() onSuccess,
    Function(String msg) onFailure,
  ) async {
    isLoading = true;
    notifyListeners();

    String? validation = isValid(name, birthday, weight, height);
    if (validation == null) {
      bool requireUpdate =
          user!.weight != int.parse(weight) || user!.gender != _currentOption;
      user!.name = name;
      user!.birthday = birthday;
      user!.gender = _currentOption;
      user!.weight = int.parse(weight);
      user!.height = int.parse(height);
      var res = await _repository.updateUserData(user!, _selectedImage?.path);
      if (res == StringManager.success) {
        if (requireUpdate) {
          filterProducts();
        }
        onSuccess();
      } else {
        onFailure(res.toString());
      }
    } else {
      onFailure(validation);
    }

    isLoading = false;
    notifyListeners();
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

  Future<void> logout() async {
    await _repository.logout();
    user = null;
    _selectedImage = null;
    _filteredProducts.clear();
    _originalProducts.clear();
    _categories = ['All'];
    _filterText = '';
    index = 0;
  }
}
