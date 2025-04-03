class DeliveryMode {
  String? deliveryMode;
  DeliveryMode({
    required this.deliveryMode,
  });

  factory DeliveryMode.fromJson(Map<String, dynamic> _deliveryModeJson) =>
      DeliveryMode(
        deliveryMode: _deliveryModeJson["MODE_OF_DELIVERY"],
      );
}
