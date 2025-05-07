import 'dart:convert';

class SelectedAccountModel {
  final int userId;
  final String userName;
  final String userImage;
  final String? userRole;
  final String? userPhone;
  final String? userEmail;

  final int companyId;
  final String companyName;
  final String? companyLogo;
  final String? verificationStatus;
  final String? companyPhone;

  final bool isUser;
  final String? companyEmail;

  SelectedAccountModel({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userRole,
    required this.userPhone,
    required this.userEmail,
    required this.companyId,
    required this.companyName,
    this.companyLogo,
    this.verificationStatus,
    required this.isUser,
    required this.companyPhone,
    required this.companyEmail,
  });

  SelectedAccountModel copyWith({
    int? userId,
    String? userName,
    String? userImage,
    String? userRole,
    String? userPhone,
    String? userEmail,
    int? companyId,
    String? companyName,
    String? companyLogo,
    String? verificationStatus,
    bool? isUser,
    String? companyPhone,
    String? companyEmail,
  }) {
    return SelectedAccountModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      userRole: userRole ?? this.userRole,
      userPhone: userPhone ?? this.userPhone,
      userEmail: userEmail ?? this.userEmail,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      isUser: isUser ?? this.isUser,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userImage": userImage,
        "userRole": userRole,
        "userPhone": userPhone,
        "userEmail": userEmail,
        "companyId": companyId,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "verificationStatus": verificationStatus,
        "isUser": isUser,
        "companyPhone": companyPhone,
        "companyEmail": companyEmail,
      };

  factory SelectedAccountModel.fromJson(Map<String, dynamic> json) =>
      SelectedAccountModel(
        userId: json["userId"],
        userName: json["userName"],
        userImage: json["userImage"],
        userRole: json["userRole"],
        userPhone: json["userPhone"],
        userEmail: json["userEmail"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        verificationStatus: json["verificationStatus"],
        isUser: json["isUser"] ?? true,
        companyPhone: json["companyPhone"],
        companyEmail: json["companyEmail"],
      );

  String toJsonString() => jsonEncode(toJson());

  factory SelectedAccountModel.fromJsonString(String source) =>
      SelectedAccountModel.fromJson(jsonDecode(source));
}
