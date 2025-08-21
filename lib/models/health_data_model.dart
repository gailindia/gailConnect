class HealthDataModel {
  String? updateDate;
  String? empNo;
  String? steps;
  String? date;
  int? stepsInt;

  HealthDataModel({this.updateDate, this.empNo, this.steps, this.date, this.stepsInt});

  factory HealthDataModel.fromJson(Map<String, dynamic> json) =>
      HealthDataModel(
        updateDate: json['UPDATED_DATE'],
        empNo: json['EMP_NO'],
        steps: json['STEPS'],
        date: json["CREATED_DATE"],
        stepsInt:json["STEPS_INT"]
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UPDATED_DATE'] = this.updateDate;
    data['EMP_NO'] = this.empNo;
    data['STEPS'] = this.steps;
    data['CREATED_DATE'] = this.date;
    data['STEPS_INT'] = stepsInt;
    return data;
  }

  @override
  String toString() {
    return 'HealthDataModel{updateDate: $updateDate, empNo: $empNo, steps: $steps, date: $date, stepsInt: $stepsInt}';
  }
}

class SetTarget {
  String? EMP_NO,
      START_DATE,
      END_DATE,
      TARGETSTEPS,
      TARGETACHIEVED,
      ISTARGETACHIEVED;

  SetTarget(
      {this.EMP_NO,
      this.START_DATE,
      this.END_DATE,
      this.TARGETSTEPS,
      this.TARGETACHIEVED,
      this.ISTARGETACHIEVED});

  factory SetTarget.fromJson(Map<String, dynamic> json) => SetTarget(
        EMP_NO: json['EMP_NO'],
        START_DATE: json['START_DATE'],
        END_DATE: json['END_DATE'],
        TARGETSTEPS: json['TARGETSTEPS'],
        TARGETACHIEVED: json['TARGETACHIEVED'],
        ISTARGETACHIEVED: json['ISTARGETACHIEVED'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_NO'] = this.EMP_NO;
    data['START_DATE'] = this.START_DATE;
    data['END_DATE'] = this.END_DATE;
    data['TARGETSTEPS'] = this.TARGETSTEPS;
    data['TARGETACHIEVED'] = this.TARGETACHIEVED;
    data['ISTARGETACHIEVED'] = this.ISTARGETACHIEVED;
    return data;
  }


}
