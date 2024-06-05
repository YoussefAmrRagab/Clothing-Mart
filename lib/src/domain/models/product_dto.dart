class ProductDTO {
  String imageUrl, name, description, brand, category, gender, weight;
  int id, reviews, count, price;
  double rating;
  String? size;
  List<String> sizes;
  bool isFavourite = false;

  String get minWeight => weight.split("-")[0];

  String get maxWeight => weight.split("-")[1];

  ProductDTO({
    required this.category,
    required this.description,
    required this.gender,
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.brand,
    required this.sizes,
    required this.reviews,
    required this.weight,
    this.count = 0,
    this.size,
    this.imageUrl = "",
  }) {
    if (imageUrl == "") {
      imageUrl = "products/$id.png";
    }
  }

  factory ProductDTO.fromJson(
    Map<String, dynamic> json,
    bool isReturningCartList,
  ) {
    return isReturningCartList
        ? ProductDTO(
            category: json["Category"],
            description: json["Description"],
            gender: json["Gender"],
            id: json["ID"],
            name: json["Name"],
            price: json["Price"],
            rating: json["Rating"] is int
                ? (json["Rating"] as int).toDouble()
                : json["Rating"],
            brand: json["Brand"],
            sizes: List.from(json["Sizes"]),
            reviews: json["Reviews"],
            weight: json["Weight"],
            count: json["count"],
            size: json["size"],
          )
        : ProductDTO(
            category: json["Category"],
            description: json["Description"],
            gender: json["Gender"],
            id: json["ID"],
            name: json["Name"],
            price: json["Price"],
            rating: json["Rating"] is int
                ? (json["Rating"] as int).toDouble()
                : json["Rating"],
            brand: json["Brand"],
            sizes: List.from(json["Sizes"]),
            reviews: json["Reviews"],
            weight: json["Weight"],
          );
  }

  Map<String, dynamic> toJson(bool isReturningCartList) {
    return isReturningCartList
        ? {
            "Category": category,
            "Description": description,
            "Gender": gender,
            "ID": id,
            "Name": name,
            "Price": price,
            "Rating": rating,
            "Brand": brand,
            "Sizes": List.from(sizes),
            "Reviews": reviews,
            "Weight": weight,
            "count": count,
            "size": size
          }
        : {
            "Category": category,
            "Description": description,
            "Gender": gender,
            "ID": id,
            "Name": name,
            "Price": price,
            "Rating": rating,
            "Brand": brand,
            "Sizes": List.from(sizes),
            "Reviews": reviews,
            "Weight": weight,
          };
  }
}
