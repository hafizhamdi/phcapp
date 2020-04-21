class PhcStaff {
  String staffName;
  String userPassword;
  String userId;
  String staffNo;
  String designationCode;
  String position;
  bool isSelected = false;

  PhcStaff(
      {this.staffName,
      this.userPassword,
      this.userId,
      this.staffNo,
      this.designationCode,
      this.position});

  PhcStaff.fromJson(Map<String, dynamic> json) {
    staffName = json['staff_name'];
    userPassword = json['user_password'];
    userId = json['user_id'];
    staffNo = json['staff_no'];
    designationCode = json['designation_code'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_name'] = this.staffName;
    data['user_password'] = this.userPassword;
    data['user_id'] = this.userId;
    data['staff_no'] = this.staffNo;
    data['designation_code'] = this.designationCode;
    data['position'] = this.position;
    return data;
  }
}
