class PlateNo {
  String plateNo;
  String plateNoDesc;

  PlateNo({this.plateNo, this.plateNoDesc});

  PlateNo.fromJson(Map<String, dynamic> json) {
    plateNo = json['plate_no'];
    plateNoDesc = json['plate_no_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate_no'] = this.plateNo;
    data['plate_no_desc'] = this.plateNoDesc;
    return data;
  }
}
