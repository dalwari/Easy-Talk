var _languages = [];
var _locale;
void setLocale(dynamic l) {
  _locale = l;
//  print("FILE _locale=> $_locale");
}

dynamic getLocale() {
  return _locale;
}

void setLanguages(dynamic la) {
  _languages = la;
  //print('FILE _language=> ${_languages.toString()}');
}

List<dynamic> getLanguages() {
  return _languages;
}
