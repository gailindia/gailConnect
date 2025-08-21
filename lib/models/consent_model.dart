class PhoneConsent {
  double? cpfNo;

  PhoneConsent({
    required this.cpfNo,
  });

  factory PhoneConsent.fromJson(Map<String, dynamic> _insertWhatsNewJson) =>
      PhoneConsent(
        cpfNo: _insertWhatsNewJson["CPF_NO"],
      );
}

class EMailConsent {
  double? cpfNo;

  EMailConsent({
    required this.cpfNo,
  });

  factory EMailConsent.fromJson(Map<String, dynamic> _insertWhatsNewJson) =>
      EMailConsent(
        cpfNo: _insertWhatsNewJson["CPF_NO"],
      );
}

class DOBConsent {
  double? cpfNo;

  DOBConsent({
    required this.cpfNo,
  });

  factory DOBConsent.fromJson(Map<String, dynamic> _insertWhatsNewJson) =>
      DOBConsent(
        cpfNo: _insertWhatsNewJson["CPF_NO"],
      );
}

class Superannuation_Consent {
  double? cpfNo;

  Superannuation_Consent({
    required this.cpfNo,
  });

  factory Superannuation_Consent.fromJson(
          Map<String, dynamic> _insertWhatsNewJson) =>
      Superannuation_Consent(
        cpfNo: _insertWhatsNewJson["CPF_NO"],
      );
}
