import '../util/utils.dart';

class Doc {
  // properties of the doc
  int id;
  String title;
  String expiration;

  // foreign keys
  int fqYear;
  int fqHalfYear;
  int fqQuarter;
  int fqMonth;

  // constructor
  Doc(this.title, this.expiration, this.fqYear, this.fqHalfYear,
      this.fqQuarter, this.fqMonth);

  //??
  Doc.withId(this.id, this.title, this.expiration, this.fqYear,
      this.fqHalfYear, this.fqQuarter, this.fqMonth);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    map['title'] = this.title;
    map['expiration'] = this.expiration;

    map['fqYear'] = this.fqYear;

  }

}

