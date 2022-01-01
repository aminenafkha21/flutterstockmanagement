
class ModelComponent {
  int id;
  String namecom;
  int qtestock;
  String dateaq;
  int category ;

  ModelComponent({
    this.namecom,
    this.qtestock,
    this.dateaq,
    this.category

  });

  ModelComponent.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.namecom = map['namecom'];
    this.qtestock = map['qtestock'];
    this.dateaq = map['dateaq'];
    this.category = map['category'];

  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['namecom'] = namecom;
    map['qtestock'] = qtestock;
    map['dateaq'] = dateaq;
    map['category'] = category;

    return map;
  }
}