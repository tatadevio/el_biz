// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  String? appleVersion;
  String? androidVersion;
  String? vipPriceForPerDay;
  String? vipPriceEnableDisable;
  String? visaCardEnabled;
  String? mbankEnabled;
  String? megapayEnabled;
  int? totalUnseenMessage;

  ConfigModel({
    this.appleVersion,
    this.androidVersion,
    this.vipPriceForPerDay,
    this.vipPriceEnableDisable,
    this.visaCardEnabled,
    this.mbankEnabled,
    this.megapayEnabled,
    this.totalUnseenMessage,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    appleVersion: json["apple_version"],
    androidVersion: json["android_version"],
    vipPriceForPerDay: json["vip_price_for_per_day"],
    vipPriceEnableDisable: json["vip_price_enable_disable"],
    visaCardEnabled: json["visa_card_enabled"],
    mbankEnabled: json["mbank_enabled"],
    megapayEnabled: json["megapay_enabled"],
    totalUnseenMessage: json["total_unseen_message"],
  );

  Map<String, dynamic> toJson() => {
    "apple_version": appleVersion,
    "android_version": androidVersion,
    "vip_price_for_per_day": vipPriceForPerDay,
    "vip_price_enable_disable": vipPriceEnableDisable,
    "visa_card_enabled": visaCardEnabled,
    "mbank_enabled": mbankEnabled,
    "megapay_enabled": megapayEnabled,
    "total_unseen_message": totalUnseenMessage,
  };
}
