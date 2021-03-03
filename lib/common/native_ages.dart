
String calcAge(day, month, year) {
  // var resultAge;

  var ndate = DateTime(int.parse(year), int.parse(month), int.parse(day));
  var now = DateTime.now();

  var noOfDays = now.difference(ndate).inDays;

  var noOfYears = noOfDays / 365;
  print("$noOfYears");
  if (noOfYears >= 1) {
    print("greater1");
    return noOfYears.toInt().toString();
  }
  print("less1");

  var remMonths = noOfDays % 365;
  var noOfMonths = remMonths / 30;
  var remDays = noOfDays % 30;

  if (noOfMonths.toInt() > 0) {
    return "${noOfMonths.toInt().toString()} months $remDays days";
  } else {
    return "$remDays days";
  }
}

convertDOBtoStandard(data) {
  print("CONVERT DOB");
  if (data == null) return null;

  var split = data.split('-');
  var yyyy = split[0];
  var MM = split[1];
  var dd = split[2];

  print(data);
  // print("$yyyy-$MM-$dd");
  print("$dd/$MM/$yyyy");
  return "$dd/$MM/$yyyy";
}

String nativeAges(String dob) {
  var stdDob = convertDOBtoStandard(dob);
  var sliceDate = stdDob.split("/");
  print(sliceDate.length);
  if (sliceDate.length == 3) {
    var day = sliceDate[0];
    var month = sliceDate[1];
    var year = sliceDate[2];
    return calcAge(day, month, year);
  }
  return "";
}
