import 'package:flutter/material.dart';
import 'package:number_funfact_flutter/src/history.dart';
import 'package:number_funfact_flutter/src/number_details.dart';

const numberDetailsRouteName = '/number_details';
const historyRouteName = '/history';
const numberDetailsHistorySaved = '/number_details_history';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  numberDetailsRouteName: (BuildContext context) {
    return ExtractArgumentsForNumberDetailsPage();
  },
  historyRouteName: (BuildContext context) {
    return HistoryPage();
  },
  numberDetailsHistorySaved: (BuildContext contex) {
    return ExtractArgumentsForNumberDetailsPage();
  },
};
