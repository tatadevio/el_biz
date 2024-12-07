
import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    required this.products,
    required this.users,
    required this.posts,
    required this.currencies,
    required this.min,
    required this.max,
  });

  int products;
  int users;
  int posts;
  List<Currency> currencies;
  String min;
  String max;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
    products: json["products"],
    users: json["users"],
    posts: json["posts"],
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    min: json["min_price"],
    max: json["max_price"],

  );

  Map<String, dynamic> toJson() => {
    "products": products,
    "users": users,
    "posts": posts,
    "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
    "min_price": min,
    "max_price": max,
  };
}

class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.code,
  });

  int id;
  String name;
  String symbol;
  String code;


  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    code: json["code"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "code": code,

  };
}
