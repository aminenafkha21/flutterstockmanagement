class ModelMembre {
  int id;
  String name;
  String surname;
  String phoneone;
  String phonetwo ;

  ModelMembre({
    this.name,
    this.surname,
    this.phoneone,
    this.phonetwo,
  });

  ModelMembre.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.surname = map['surname'];
    this.phoneone = map['phoneone'];
    this.phonetwo= map['phonetwo'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = this.name;
    map['surname'] = this.surname;
    map['phoneone'] = this.phoneone;
    map['phonetwo'] = this.phonetwo;


    return map;
  }
}
