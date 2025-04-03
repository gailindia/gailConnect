class EmpAttendance {

  String empNo,date,inTime,outTime;//location


  EmpAttendance({
    required this.empNo,
    required this.date,
    required this.inTime,
    required this.outTime,
    // required this.location
  });

  factory EmpAttendance.fromJson(Map<String, dynamic> _dependantJson) =>
      EmpAttendance(
        empNo: _dependantJson["EMP_NO"],
        date: _dependantJson["IO_DATE"],
        inTime: _dependantJson["IN_TIME"],
        outTime: _dependantJson["OUT_TIME"],
        // location: _dependantJson["LOCATION"]
      );




}


class EmpAttendanceAverage {

  double hours,min,sec;
  double count;


  EmpAttendanceAverage({
    required this.hours,
    required this.min,
    required this.sec,
    required this.count
  });

  factory EmpAttendanceAverage.fromJson(Map<String, dynamic> _dependantJson) =>
      EmpAttendanceAverage(
          hours: _dependantJson["HOUR"] ??"0",
          min: _dependantJson["MINUTE"]??"0",
          sec: _dependantJson["SECONDS"]??"0",
          count: _dependantJson["TOTAL_COUNT"],

      );




}