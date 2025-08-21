/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

class InstalledUninstalledCountModel {
  String? StatusCode;
  String? Message;
  List<Installed> installed;
  List<Uninstalled> uninstalled;

  InstalledUninstalledCountModel(
      {required this.StatusCode,
        required this.Message,
        required this.installed,
        required this.uninstalled});

  factory InstalledUninstalledCountModel.fromJson(
      Map<String, dynamic> _eNoteSheetByFileJson) =>
      InstalledUninstalledCountModel(
        StatusCode: _eNoteSheetByFileJson['StatusCode'],
        Message: _eNoteSheetByFileJson['Message'],
        installed: _eNoteSheetByFileJson['Installed'] != null &&
            _eNoteSheetByFileJson['Installed'].isNotEmpty
            ? _eNoteSheetByFileJson['Installed']
            .map<Installed>(
                (installedlist) => Installed.fromJson(installedlist))
            .toList()
            : [],
        uninstalled: _eNoteSheetByFileJson['Uninstalled'] != null &&
            _eNoteSheetByFileJson['Uninstalled'].isNotEmpty
            ? _eNoteSheetByFileJson['Uninstalled']
            .map<Installed>(
                (uninstalledlist) => Installed.fromJson(uninstalledlist))
            .toList()
            : [],
      );
}

class Installed {
  String? grade;
  double? count;

  Installed({
    required this.grade,
    required this.count,
  });

  factory Installed.fromJson(Map<String, dynamic> _fileMovementDetailsJson) =>
      Installed(
        grade: _fileMovementDetailsJson['GRADE'],
        count: _fileMovementDetailsJson['COUNT(*)'],
      );
}

class Uninstalled {
  String? grade;
  double? count;

  Uninstalled({
    required this.grade,
    required this.count,
  });

  factory Uninstalled.fromJson(Map<String, dynamic> _fileMovementDetailsJson) =>
      Uninstalled(
        grade: _fileMovementDetailsJson['GRADE'],
        count: _fileMovementDetailsJson['COUNT(*)'],
      );
}
