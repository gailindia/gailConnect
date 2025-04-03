class OHCMODEL {
double EMP_NO;
  String LAST_OHC_DATE,HOSPITAL_NAME,HOSPITAL_ADD,MEASUREMENTS,EMAIL_ID,PH_EMEGENCY,SNO;


  OHCMODEL({
    required this.EMP_NO,
    required this.LAST_OHC_DATE,
    required this.HOSPITAL_NAME,
    required this.HOSPITAL_ADD,
    required this.MEASUREMENTS,
    required this.EMAIL_ID,
    required this.PH_EMEGENCY,
    required this.SNO,

  });

  factory OHCMODEL.fromJson(Map<String, dynamic> _dependantJson) =>
      OHCMODEL(
          EMP_NO: _dependantJson["EMP_NO"],
          LAST_OHC_DATE: _dependantJson["OHC_DATE"],
          HOSPITAL_NAME: _dependantJson["HOSPITAL_NAME"],
          HOSPITAL_ADD: _dependantJson["HOSPITAL_ADD"],
          MEASUREMENTS: _dependantJson["MEASUREMENTS"],
          EMAIL_ID: _dependantJson["EMAIL_ID"],
          PH_EMEGENCY: _dependantJson["PH_RESI"],
          SNO:_dependantJson["SNO"]

      );
}
