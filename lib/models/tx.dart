//object in dart
class Tx {
  //final as runtime constant
  final String id;
  final String name;
  final double amount;
  final DateTime date;

  //Constructor w/ named & required arguments
  Tx(
      {required this.id,
      required this.name,
      required this.amount,
      required this.date});
}
