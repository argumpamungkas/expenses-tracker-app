void main() {
  var nowDate = DateTime.now();

  print(nowDate);

  String toString = nowDate.toIso8601String();

  print(toString);

  DateTime dateParse = DateTime.parse(toString);

  print(dateParse);
}
