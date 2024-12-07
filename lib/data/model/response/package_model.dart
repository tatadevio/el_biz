class PackagesModel {
  List<Packages>? packages;

  PackagesModel({this.packages});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  int? id;
  int? price;
  String? packageType;
  String? shortDescription;
  List<Description>? description;
  String? icon;

  Packages({this.id, this.price, this.packageType, this.shortDescription, this.description, this.icon});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price']??3;
    packageType = json['package_type'];
    shortDescription = json['short_description'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['package_type'] = packageType;
    data['short_description'] = shortDescription;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['icon'] = icon;
    return data;
  }
}

class Description {
  String? item;
  List<String>? correct;

  Description({this.item, this.correct});

  Description.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    if (json['correct'] != null) {
      correct = <String>[];
      json['correct'].forEach((v) {
        correct?.add(v);
      });
    }
    // correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    if (correct != null) {
      data['correct'] = correct?.map((e) => e).toList();
    }

    return data;
  }
}
