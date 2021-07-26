import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'count.dart';
import 'dart:io';
import 'file.dart';

class FirstClass extends StatefulWidget {
  FirstClass({Key key}) : super(key: key);

  @override
  _FirstClassState createState() => _FirstClassState();
}

class _FirstClassState extends State<FirstClass> {
  @override
  var _languages = [];
  var _locale;
  var langValues = [];
  var currLang;
  @override
  void initState() {
    _languages = WidgetsBinding.instance.window.locales;
    _locale = Platform.localeName;
    currLang = langList[_locale.split('_')[0]] +
        "(" +
        countryList[_locale.split('_')[1]] +
        ")";
    _languages.forEach((el) {
      var values = langList[el.toString().split('_')[0]] +
          "(" +
          countryList[el.toString().split('_')[1]] +
          ")";
      langValues.add(values);
    });
    setLocale(_locale);
    setLanguages(_languages);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: Colors.amber[200]),
      child: DropdownButton(
        items: langValues.map((e) {
          return DropdownMenuItem(
            child: Container(
              child: Text(e),
            ),
            value: e,
          );
        }).toList(),
        value: currLang,
        onChanged: (v) {
          setState(() {
            currLang = v;
            _locale = locale_list[currLang.toString().split('(')[0]];
            //print("$currLang");
            setLocale(_locale);
            //_locale=getLocale();
            //print('loc=> $_locale');
            //setLocale(_locale);
          });
        },
      ),
    );
  }
}
