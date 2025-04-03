class TargetAchieved {
  TargetAchieved({
      this.empNo,
      this.steps, 
      this.date,});

  TargetAchieved.fromJson(dynamic json) {
    empNo = json['EMP_NO'];
    steps = json['steps'];
    date = json['Date'];
  }
  String? steps;
  String? date;
  String? empNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EMP_NO'] = empNo;
    map['steps'] = steps;
    map['Date'] = date;
    return map;
  }

}