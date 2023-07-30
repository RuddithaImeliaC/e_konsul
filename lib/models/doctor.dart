
class Doctor {
  late String name;
  late String doctorKey;

  Doctor({required this.name});

  Doctor.fromSnapshot(Map<dynamic, dynamic> data) {
    name = data['name'] ?? '';
    doctorKey = data['doctorKey'] ?? '';
  }
}
