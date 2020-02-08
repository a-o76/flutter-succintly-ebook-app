import '../util/utils.dart';

class Doc {
  // properties of the doc
  int id;
  String title;
  String expiration;
  int fqYear;
  int fqHalfYear;
  int fqQuarter;
  int fqMonth;

  // constructor used when there's no Id
  Doc(this.title, this.expiration, this.fqYear, this.fqHalfYear,
      this.fqQuarter, this.fqMonth);

  // named constructor used when there's an Id to be informed
  Doc.withId(this.id, this.title, this.expiration, this.fqYear,
      this.fqHalfYear, this.fqQuarter, this.fqMonth);

  // named constructor
  // receive from database and asigned to the Doc instance properties
  // used when READING FROM DATABASE
  Doc.fromObject(dynamic o) {

    this.id = o['id'];
    this.title = o['title'];
    this.expiration = DateUtils.trimDate(o['expiration']);

    this.fqHalfYear = o['fqHalfYear'];
    this.fqMonth = o['fqMonth'];
    this.fqQuarter = o['fqQuarter'];
    this.fqYear = o['fqYear'];

  }

  // this method is used when the `document` information needs to be writen on the db
  // it returns a dictionary
  // used when WRITING TO THE DATABASE
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    map['title'] = this.title;
    map['expiration'] = this.expiration;

    map['fqYear'] = this.fqYear;
    map['fqHalfYear'] = this.fqHalfYear;
    map['fqQuarter'] = this.fqQuarter;
    map['fqMonth'] = this.fqMonth;

    if (id != null) {
      map['id'] = id;
    }

    return map;

  }

}

