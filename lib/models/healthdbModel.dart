

class HealthModel {
  String? eMPNO;
  int? uPDATEDDATE;
  String? sTEPS;
  String? sTARTTIME;
  String? cAL;
  String? dISTANCE;
  String? tWOSTEPS;
  String? fOURSTEPS;
  String? sIXSTEPS;
  String? eIGHTSTEPS;
  String? tENSTEPS;
  String? tWELVESTEPS;
  String? fOURTEENSTEPS;
  String? sIXTEENSTEPS;
  String? eIGHTEENSTEPS;
  String? tWENTYSTEPS;
  String? tTWOSTEPS;
  String? tFOURSTEPS;

  HealthModel(
      {
        this.eMPNO,
        this.uPDATEDDATE,
        this.sTEPS,
        this.sTARTTIME,
        this.cAL,
        this.dISTANCE,
        this.tWOSTEPS,
        this.fOURSTEPS,
        this.sIXSTEPS,
        this.eIGHTSTEPS,
        this.tENSTEPS,
        this.tWELVESTEPS,
        this.fOURTEENSTEPS,
        this.sIXTEENSTEPS,
        this.eIGHTEENSTEPS,
        this.tWENTYSTEPS,
        this.tTWOSTEPS,
        this.tFOURSTEPS});

  HealthModel.fromJson(Map<String, dynamic> json) {
    eMPNO = json['EMP_NO'];
    uPDATEDDATE = json['UPDATED_DATE']??'0';
    sTEPS = json['STEPS']??'0';
    sTARTTIME = json['START_TIME']??'0';;
    cAL = json['CAL']??'0';
    dISTANCE = json['DISTANCE'];
    tWOSTEPS = json['TWO_STEPS']??'0';
    fOURSTEPS = json['FOUR_STEPS']??'0';
    sIXSTEPS = json['SIX_STEPS']??'0';
    eIGHTSTEPS = json['EIGHT_STEPS']??'0';
    tENSTEPS = json['TEN_STEPS']??'0';
    tWELVESTEPS = json['TWELVE_STEPS']??'0';
    fOURTEENSTEPS = json['FOURTEEN_STEPS']??'0';
    sIXTEENSTEPS = json['SIXTEEN_STEPS']??'0';
    eIGHTEENSTEPS = json['EIGHTEEN_STEPS']??'0';
    tWENTYSTEPS = json['TWENTY_STEPS']??'0';
    tTWOSTEPS = json['TTWO_STEPS']??'0';
    tFOURSTEPS = json['TFOUR_STEPS']??'0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_NO'] = this.eMPNO;
    data['UPDATED_DATE'] = this.uPDATEDDATE??'${DateTime.now()}';
    data['STEPS'] = this.sTEPS;
    data['START_TIME'] = this.sTARTTIME??'${DateTime.now()}';
    data['CAL'] = this.cAL;
    data['DISTANCE'] = this.dISTANCE;
    data['TWO_STEPS'] = this.tWOSTEPS??'0';
    data['FOUR_STEPS'] = this.fOURSTEPS??'0';
    data['SIX_STEPS'] = this.sIXSTEPS??'0';
    data['EIGHT_STEPS'] = this.eIGHTSTEPS??'0';
    data['TEN_STEPS'] = this.tENSTEPS??'0';
    data['TWELVE_STEPS'] = this.tWELVESTEPS??'0';
    data['FOURTEEN_STEPS'] = this.fOURTEENSTEPS??'0';
    data['SIXTEEN_STEPS'] = this.sIXTEENSTEPS??'0';
    data['EIGHTEEN_STEPS'] = this.eIGHTEENSTEPS??'0';
    data['TWENTY_STEPS'] = this.tWENTYSTEPS??'0';
    data['TTWO_STEPS'] = this.tTWOSTEPS??'0';
    data['TFOUR_STEPS'] = this.tFOURSTEPS??'0';
    return data;
  }

}