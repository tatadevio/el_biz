
class AddAttribute {
  late String _answer;
  late String _id;
  late String _option;


  AddAttribute(String type,String id, String option) {
    _answer = type;
    _id = id;
    _option = option;

  }

  String get answer => _answer;
  String get id => _id;
  String get option => _option;


  AddAttribute.fromJson(Map<String, String> json) {
    _answer = json['attribute[$_id]]']??"";

  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['attribute[$_id]'] = _answer;

    return data;
  }
}




class AddAttributeMulti {
  late String _answer;
  late String _id;
  late String _option;

  AddAttributeMulti(String type,String id,String option) {
    _answer = type;
    _id = id;
    _option = option;
  }

  String get answer => _answer;
  String get id => _id;
  String get option => _option;


  AddAttributeMulti.fromJson(Map<String, String> json) {
    _answer = json['multi_attributes[$_id]']??"";

  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['multi_attributes[$_id]'] = _answer;

    return data;
  }
}

class AddAttributeInt {
  late String _answer;
  late String _id;
  late String _option;
  late String _type;

  AddAttributeInt(String answer,String id,String option,String type) {
    _answer = answer;
    _id = id;
    _option = option;
    _type = type;
  }

  String get answer => _answer;
  String get id => _id;
  String get option => _option;
  String get type => _type;


  AddAttributeInt.fromJson(Map<String, String> json) {
    _answer = json['attributes[$_id][$_type]']??"";

  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['attributes[$_id][$_type]'] = _answer;

    return data;
  }
}

