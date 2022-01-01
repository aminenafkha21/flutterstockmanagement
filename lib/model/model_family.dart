class ModelFamily {
  int categoryid;
  String familyName;


  ModelFamily({
    this.familyName, this.categoryid,

  });

  ModelFamily.fromMap(Map<String, dynamic> map) {
    this.categoryid = map['categoryid'];
    this.familyName = map['familyName'];

  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (categoryid != null) {
      map['categoryid'] = categoryid;
    }
    map['familyName'] = familyName;


    return map;
  }

}
