class HomeModel {
  bool? status;
  HomeDataModel? data;



  HomeModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
<<<<<<< HEAD
    message = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
=======
    data = HomeDataModel.fromJson(json['data']);

  }

>>>>>>> 5b57fedc3859fb07452041e73b517208d017bf0a
}

class HomeDataModel {
  List<Banners> banners=[];
  List<ProductModel> products=[];


<<<<<<< HEAD
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannersModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannersModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['ad'] = ad;
    return data;
=======


  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));    });
>>>>>>> 5b57fedc3859fb07452041e73b517208d017bf0a
  }
}

class Banners {
  int? id;
  String? image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];

  }

<<<<<<< HEAD
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['category'] = category;
    data['product'] = product;
    return data;
=======

}

class ProductResponse {
  bool? status;
  ProductModel? data;
  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProductModel.fromJson(json['data']);
>>>>>>> 5b57fedc3859fb07452041e73b517208d017bf0a
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String? description;
  List<String>? images;


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
    images = json['images'].cast<String>();
  }
<<<<<<< HEAD

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['images'] = images;
    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}
=======
}
>>>>>>> 5b57fedc3859fb07452041e73b517208d017bf0a
