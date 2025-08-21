class SuperAnnuationModel {

  String userphoto,empNo,retirement,emp_name,designation,department,location;


  SuperAnnuationModel({
    required this.userphoto,
    required this.empNo,
    required this.retirement,
    required this.emp_name,
    required this.designation,
    required this.department,
    required this.location
  });

  factory SuperAnnuationModel.fromJson(Map<String, dynamic> _dependantJson) =>
      SuperAnnuationModel(
          userphoto: _dependantJson["UserPhoto"],
          empNo: _dependantJson["emp_no"],
          retirement: _dependantJson["Retirement"],
          emp_name: _dependantJson["emp_name"],
          designation: _dependantJson["designation"],
          department: _dependantJson["department"],
          location: _dependantJson["location"]
      );
}
