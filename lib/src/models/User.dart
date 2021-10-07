class User {
  bool faceMatch;
  String idNo;
  String name;
  String sex;
  String dob;
  List<String> extracted;

  User({
    this.faceMatch,
    this.idNo,
    this.dob,
    this.name,
    this.sex,
    this.extracted,
  });

  User.fromJson(parsedJson) {
    faceMatch = parsedJson["match"];
    idNo = "36914130";
    name = "Edwin Walela";
    sex = "Male";
    dob = "26/09/1999";
  }
}
