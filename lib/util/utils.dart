
class Val {

  static String ValidateTitle(String val) {
    return (val != null && val != '') ? null : 'Title cannot be empty';
  }

}