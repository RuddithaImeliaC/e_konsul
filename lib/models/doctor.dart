
class Doctor {
  late String name;

  Doctor({required this.name});

  Doctor.fromSnapshot(Map<dynamic, dynamic> data) {
    name = data['name'] ?? '';
  }
}
