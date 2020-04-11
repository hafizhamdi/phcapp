class TeamModel {
  String _service_response;
  String _vehicle_regno;
  List<_Staff> _staffs;

  TeamModel.fromJson(Map<String, dynamic> data) {
    _service_response = data['service_response'];
    _vehicle_regno = data["vehicle_regno"];

    List<_Staff> temp_staff = [];
    for (int i = 0; i < data["staffs"].length; i++) {
      _Staff staff = _Staff(data["staffs"][i]);
      temp_staff.add(staff);
    }

    _staffs = temp_staff;
  }

  String get service_response => _service_response;
  String get vehicle_regno => _vehicle_regno;
  List<_Staff> get staffs => _staffs;
}

class _Staff {
  String _name;
  String _position;

  _Staff(data) {
    _name = data["name"];
    _position = data["position"];
  }

  String get name => _name;
  String get position => _position;
}
