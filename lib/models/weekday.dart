// class WeekDay {
//   String dayname;
//   DateTime date_name;
//   String STEPS,
//       CAL,
//       DISTANCE,
//       TWO_STEPS,
//       FOUR_STEPS,
//       SIX_STEPS,
//       EIGHT_STEPS,
//       TEN_STEPS,
//       TWELVE_STEPS,
//       FOURTEEN_STEPS,
//       SIXTEEN_STEPS,
//       EIGHTEEN_STEPS,
//       TWENTY_STEPS,
//       TTWO_STEPS,
//       TFOUR_STEPS;
//
//   WeekDay(
//       {required this.dayname,
//       required this.date_name,
//       required this.STEPS,
//       required this.CAL,
//       required this.DISTANCE,
//       required this.TWO_STEPS,
//       required this.FOUR_STEPS,
//       required this.SIX_STEPS,
//       required this.EIGHT_STEPS,
//       required this.TEN_STEPS,
//       required this.TWELVE_STEPS,
//       required this.FOURTEEN_STEPS,
//       required this.SIXTEEN_STEPS,
//       required this.EIGHTEEN_STEPS,
//       required this.TWENTY_STEPS,
//       required this.TTWO_STEPS,
//       required this.TFOUR_STEPS});
//
//   factory WeekDay.fromJson(Map<String, dynamic> json) => WeekDay(
//     dayname: json['dayname'],
//     date_name: json['date_name'],
//     STEPS: json['STEPS'],
//     CAL: json['CAL'],
//     DISTANCE: json['DISTANCE'],
//     TWO_STEPS: json['TWO_STEPS'],
//     FOUR_STEPS: json['FOUR_STEPS'],
//     SIX_STEPS: json['SIX_STEPS'],
//     EIGHT_STEPS: json['EIGHT_STEPS'],
//     TEN_STEPS: json['TEN_STEPS'],
//     TWELVE_STEPS: json['TWELVE_STEPS'],
//     FOURTEEN_STEPS: json['FOURTEEN_STEPS'],
//     SIXTEEN_STEPS: json['SIXTEEN_STEPS'],
//     EIGHTEEN_STEPS: json['EIGHTEEN_STEPS'],
//     TWENTY_STEPS: json['TWENTY_STEPS'],
//     TTWO_STEPS: json['TTWO_STEPS'],
//     TFOUR_STEPS: json['TFOUR_STEPS'],
//   );
//
// }


class CardData {

  int STEPS,
      CAL,
      DISTANCE,
      TWO_STEPS,
      FOUR_STEPS,
      SIX_STEPS,
      EIGHT_STEPS,
      TEN_STEPS,
      TWELVE_STEPS,
      FOURTEEN_STEPS,
      SIXTEEN_STEPS,
      EIGHTEEN_STEPS,
      TWENTY_STEPS,
      TTWO_STEPS,
      TFOUR_STEPS;

  CardData(
      {
        required this.STEPS,
        required this.CAL,
        required this.DISTANCE,
        required this.TWO_STEPS,
        required this.FOUR_STEPS,
        required this.SIX_STEPS,
        required this.EIGHT_STEPS,
        required this.TEN_STEPS,
        required this.TWELVE_STEPS,
        required this.FOURTEEN_STEPS,
        required this.SIXTEEN_STEPS,
        required this.EIGHTEEN_STEPS,
        required this.TWENTY_STEPS,
        required this.TTWO_STEPS,
        required this.TFOUR_STEPS});

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(

    STEPS: json['STEPS']??0,
    CAL: json['CAL']??0,
    DISTANCE: json['DISTANCE']??0,
    TWO_STEPS: json['TWO_STEPS'] ?? 0,
    FOUR_STEPS: json['FOUR_STEPS'] ?? 0,
    SIX_STEPS: json['SIX_STEPS'] ?? 0,
    EIGHT_STEPS: json['EIGHT_STEPS'] ?? 0,
    TEN_STEPS: json['TEN_STEPS'] ?? 0,
    TWELVE_STEPS: json['TWELVE_STEPS'] ?? 0,
    FOURTEEN_STEPS: json['FOURTEEN_STEPS'] ?? 0,
    SIXTEEN_STEPS: json['SIXTEEN_STEPS'] ?? 0,
    EIGHTEEN_STEPS: json['EIGHTEEN_STEPS'] ?? 0,
    TWENTY_STEPS: json['TWENTY_STEPS'] ?? 0,
    TTWO_STEPS: json['TTWO_STEPS'] ?? 0,
    TFOUR_STEPS: json['TFOUR_STEPS'] ?? 0,
  );

}

class staticDay {
  String dayname;
  DateTime date;

  staticDay({required this.dayname, required this.date});
}
