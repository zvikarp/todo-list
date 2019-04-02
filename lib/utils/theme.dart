import 'package:flutter/material.dart';


/// this is the Theme class, it handles the theme for the whole application.
class ThemeUtil {
  
  /// returns the applications theme.
  ThemeData getTheme() {
    return ThemeData(

      // color theme
      primarySwatch: Colors.indigo,
      primaryColor: Colors.indigo[400],
      primaryColorLight: Colors.indigo[300],
      primaryColorDark:  Colors.indigo[500],
      accentColor: Colors.grey[50],
      errorColor: Colors.deepOrange[500],
      cursorColor: Colors.indigo[600],
      
      // text theme
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 36.0, fontFamily: 'Overpass', color: Colors.black,   fontWeight: FontWeight.w500),
        title:    TextStyle(fontSize: 18.0, fontFamily: 'Overpass', color: Colors.black87, fontWeight: FontWeight.w500),
        subtitle: TextStyle(fontSize: 16.0, fontFamily: 'Lato',     color: Colors.black54, fontWeight: FontWeight.w500),
        body1:    TextStyle(fontSize: 20.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w500),
        body2:    TextStyle(fontSize: 16.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w700),
        button:   TextStyle(fontSize: 14.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w700),
      ),
    );
  }

}

final ThemeUtil themeUtil = ThemeUtil();