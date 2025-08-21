class DashboardListModel {
  String? cpfno;
  DashboardListModel({
    required this.cpfno,
  });

  factory DashboardListModel.fromJson(Map<String, dynamic> _deliveryModeJson) =>
      DashboardListModel(
        cpfno: _deliveryModeJson["CPFNO"],
      );
}
