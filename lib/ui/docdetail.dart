
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


}