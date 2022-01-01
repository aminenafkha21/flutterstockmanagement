
class ModelLoan {
  int id;
  int qtestockloans;
  int membre ;
  int component ;

  ModelLoan({
    this.qtestockloans,
    this.membre,
    this.component

  });

  ModelLoan.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.qtestockloans = map['qtestockloans'];
    this.membre = map['membre'];
    this.component = map['component'];

  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['qtestockloans'] = qtestockloans;
    map['membre'] = membre;
    map['component'] = component;

    return map;
  }
}