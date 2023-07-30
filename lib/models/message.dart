
class Message {
  Message({
    required this.isDoctor,
    required this.value,
  });

  late final bool isDoctor;
  late final String value;

  Message.fromSnapshot(Map<dynamic, dynamic> json) {
    isDoctor = json['isDoctor'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDoctor'] = isDoctor;
    data['value'] = value;
    return data;
  }
}