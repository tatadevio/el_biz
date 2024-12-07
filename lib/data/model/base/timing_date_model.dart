class DaySchedule {
  String day;
  String openingTime;
  String closingTime;
  bool isOpen;

  DaySchedule({
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'isOpen': isOpen,
    };
  }
}



class ContactInfoModel {
  String type;
  String value;


  ContactInfoModel({
    required this.type,
    required this.value,

  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,

    };
  }
}
