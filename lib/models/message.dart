
import 'package:intl/intl.dart';

class Message {
  Message({
    required this.isDoctor,
    required this.value,
  });

  late final bool isDoctor;
  late final String value;
  String? createdAt;
  String? file;

  Message.fromSnapshot(Map<dynamic, dynamic> json) {
    isDoctor = json['isDoctor'];
    value = json['value'].toString();
    if(json['createdAt'] != null) {
      createdAt = DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.parse(json['createdAt'].toString()));
    } else {
      createdAt = "";
    }
    if(json['file'] != null) {
      file = json['file'].toString();
    } else {
      file = "";
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDoctor'] = isDoctor;
    data['value'] = value;
    data['createdAt'] = createdAt;
    data['file'] = file;
    return data;
  }
}