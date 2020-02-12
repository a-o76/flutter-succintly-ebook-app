
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../model/model.dart';
import '../util/utils.dart';
import '../util/dbhelper.dart';

const menuDelete = "Delete";

// options on the menu
final List<String> menuOptions = const <String> [
  menuDelete
];

class DocDetail extends StatefulWidget {
  Doc doc;

  final DbHelper dbh = DbHelper();

  // constructor
  DocDetail(this.doc);

  @override
  State<StatefulWidget> createState() => DocDetailState();
  
}

class DocDetailState extends State<DocDetail> {


  // this too variables are used to keep the state of the form after being submited
  // keep the state of a form widget
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // keep the state of the scalfold object
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 15 years in the future. -- days to expire
  final int daysAhead = 5475;

  // handy controller for a text field
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController expirationCtrl = MaskedTextController(mask: '2000-00-00');

  // represents the Doc data
  bool fqYearCtrl = true;
  bool fqHalfYearCtrl = true;
  bool fqQuarterCtrl = true;
  bool fqMonthCtrl = true;
  bool fqLessMonthCtrl = true;

   // initilize the values of the doc on the inputs
  void _initCtrls() {

    titleCtrl.text = widget.doc.title != null ? widget.doc.title : "";
    expirationCtrl.text = widget.doc.expiration != null ? widget.doc.expiration : "";

    fqYearCtrl = widget.doc.fqYear != null ?
    Val.intToBool(widget.doc.fqYear) : false;

    fqHalfYearCtrl = widget.doc.fqHalfYear != null ?
    Val.intToBool(widget.doc.fqHalfYear) : false;

    fqQuarterCtrl = widget.doc.fqQuarter != null ?
    Val.intToBool(widget.doc.fqQuarter) : false;

    fqMonthCtrl = widget.doc.fqMonth != null ?
    Val.intToBool(widget.doc.fqMonth) : false;

  }

  // the build context handles the location of the widget in flutter internal widget tree
  Future _chooseDate(BuildContext context, String initialDateString) async {

    var now = new DateTime.now();
    // when initialdatestring is null them set the actual date
    var initialDate = DateUtils.convertToDate(initialDateString) ?? now;

    initialDate = (initialDate.year >= now.year &&
      initialDate.isAfter(now) ? initialDate : now);

    // the component datepicker using the initial date as currenttime
    DatePicker.showDatePicker(context, showTitleActions: true,
      onConfirm: (date) {
        setState(() {
          // when the user confirm the date it sets to the expiration controller state
          DateTime dt = date;
          String r = DateUtils.ftDateAsStr(dt);
          expirationCtrl.text = r;
        });
      },
      currentTime: initialDate);
  }


  void _selectMenu(String value) async {
    switch(value) {
      case menuDelete:
        if ( widget.doc.id == -1 ) {
          return;
        }

        await _deleteDoc(widget.doc.id);
    }
  }

  Future _deleteDoc(int id) async {
    await widget.dbh.deleteDoc(widget.doc.id);
    Navigator.pop(context, true);
  }

  void _saveDoc() {
    widget.doc.title = titleCtrl.text;
    widget.doc.expiration = expirationCtrl.text;

    widget.doc.fqYear = Val.boolToInt(fqYearCtrl);
    widget.doc.fqHalfYear = Val.boolToInt(fqHalfYearCtrl);
    widget.doc.fqQuarter = Val.boolToInt(fqQuarterCtrl);
    widget.doc.fqMonth = Val.boolToInt(fqMonthCtrl);

    // if has an id then its a update
    if (widget.doc.id > -1) {
      debugPrint('_update->Doc Id: ' + widget.doc.id.toString());
      widget.dbh.updateDoc(widget.doc);
      Navigator.pop(context, true);
    // otherwise its an insertion
    } else {
      Future<int> idd = widget.dbh.getMaxId();
      idd.then((result) {
        debugPrint("_insert->Doc Id: " + widget.doc.id.toString());
        widget.doc.id = (result != null) ? result + 1 : 1;
        widget.dbh.insertDoc(widget.doc);
        Navigator.pop(context, true);
      });
    }
  }

}