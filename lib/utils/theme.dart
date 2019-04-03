import 'package:flutter/material.dart';

// unfortunatelly, i didn't have enough time to really play with this (and im also a bit color blint...) 

/// this is the Theme class, it handles the theme for the whole application.
class ThemeUtil {
  
  /// returns the applications theme.
  ThemeData getTheme() {
    return ThemeData(

      // color theme
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[700],
      primaryColorLight: Colors.blue[400],
      primaryColorDark:  Colors.blue[800],
      accentColor: Colors.blue[700],
      errorColor: Colors.deepOrange[500],
      cursorColor: Colors.blue[200],
      
      // icon themes (regular and accent)
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      accentIconTheme: IconThemeData(
        color: Colors.white,
      ),
      
      // text theme (regular and accent)
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 36.0, fontFamily: 'Overpass', color: Colors.black87,   fontWeight: FontWeight.w300),
        title:    TextStyle(fontSize: 20.0, fontFamily: 'Overpass', color: Colors.black87, fontWeight: FontWeight.w500),
        subtitle: TextStyle(fontSize: 14.0, fontFamily: 'Lato',     color: Colors.black54, fontWeight: FontWeight.w500),
        body1:    TextStyle(fontSize: 20.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w500),
        body2:    TextStyle(fontSize: 16.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w700),
        button:   TextStyle(fontSize: 14.0, fontFamily: 'Lato',     color: Colors.black87, fontWeight: FontWeight.w700),
      ),
      accentTextTheme: TextTheme(
        headline: TextStyle(fontSize: 36.0, fontFamily: 'Overpass', color: Colors.white,   fontWeight: FontWeight.w300),
        title:    TextStyle(fontSize: 20.0, fontFamily: 'Overpass', color: Colors.white, fontWeight: FontWeight.w500),
        subtitle: TextStyle(fontSize: 14.0, fontFamily: 'Lato',     color: Colors.white, fontWeight: FontWeight.w500),
        body1:    TextStyle(fontSize: 20.0, fontFamily: 'Lato',     color: Colors.white, fontWeight: FontWeight.w500),
        body2:    TextStyle(fontSize: 16.0, fontFamily: 'Lato',     color: Colors.white, fontWeight: FontWeight.w700),
        button:   TextStyle(fontSize: 14.0, fontFamily: 'Lato',     color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }

}

final ThemeUtil themeUtil = ThemeUtil();