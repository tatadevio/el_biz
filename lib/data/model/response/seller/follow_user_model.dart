class FollowUserModel {
  String? title;
  String? message;
  String? status;
  String? localizedKey;
  FollowUserData? data;
  int? statusCode;

  FollowUserModel(
      {this.title,
      this.message,
      this.status,
      this.localizedKey,
      this.data,
      this.statusCode});

  FollowUserModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    status = json['status'];
    localizedKey = json['localized_key'];
    data = json['data'] != null ? FollowUserData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['status'] = status;
    data['localized_key'] = localizedKey;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = statusCode;
    return data;
  }
}

class FollowUserData {
  List<FollowUserItems>? items;
  int? totalPages;
  int? currentPage;
  int? total;
  int? perPage;
  int? count;

  FollowUserData(
      {this.items,
      this.totalPages,
      this.currentPage,
      this.total,
      this.perPage,
      this.count});

  FollowUserData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <FollowUserItems>[];
      json['items'].forEach((v) {
        items!.add(FollowUserItems.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    total = json['total'];
    perPage = json['perPage'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['total'] = total;
    data['perPage'] = perPage;
    data['count'] = count;
    return data;
  }
}

class FollowUserItems {
  int? id;
  String? role;
  String? customerId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? phoneVerifiedAt;
  String? image;
  String? bannerImg;
  String? country;
  String? countryCode;
  String? city;
  String? state;
  String? address;
  int? status;
  String? about;
  int? registered;
  String? registerFrom;
  String? promoLink;
  String? promoQr;
  int? screenshot;
  int? showTheme;
  String? userType;
  bool? isVerified;
  bool? isFollow;
  bool? isFavorite;

  FollowUserItems({
    this.id,
    this.role,
    this.customerId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.image,
    this.bannerImg,
    this.country,
    this.countryCode,
    this.city,
    this.state,
    this.address,
    this.status,
    this.about,
    this.registered,
    this.registerFrom,
    this.promoLink,
    this.promoQr,
    this.screenshot,
    this.showTheme,
    this.userType,
    this.isVerified,
    this.isFollow,
    this.isFavorite,
  });

  FollowUserItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    customerId = json['customer_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    phoneVerifiedAt = json['phone_verified_at'];
    image = json['image'];
    bannerImg = json['banner_img'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    status = json['status'];
    about = json['about'];
    registered = json['registered'];
    registerFrom = json['register_from'];
    promoLink = json['promo_link'];
    promoQr = json['promo_qr'];
    screenshot = json['screenshot'];
    showTheme = json['show_theme'];
    userType = json['user_type'];
    isVerified = json['is_verified'];
    isFollow = json['is_follow'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone'] = phone;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['image'] = image;
    data['banner_img'] = bannerImg;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['status'] = status;
    data['about'] = about;
    data['registered'] = registered;
    data['register_from'] = registerFrom;
    data['promo_link'] = promoLink;
    data['promo_qr'] = promoQr;
    data['screenshot'] = screenshot;
    data['show_theme'] = showTheme;
    data['user_type'] = userType;
    data['is_verified'] = isVerified;
    data['is_follow'] = isFollow;
    data['is_favorite'] = isFavorite;
    return data;
  }
}
