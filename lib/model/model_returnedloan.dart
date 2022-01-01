
class ModelReturnedLoan {
  int id;
  String dateretour;
  String etat;
  int loan ;

  ModelReturnedLoan({
    this.dateretour,
    this.etat,
    this.loan,

  });

  ModelReturnedLoan.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.dateretour = map['dateretour'];
    this.etat = map['etat'];
    this.loan = map['loan'];

  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['dateretour'] = dateretour;
    map['etat'] = etat;
    map['loan'] = loan;

    return map;
  }
}