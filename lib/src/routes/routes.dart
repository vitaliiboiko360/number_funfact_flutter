import 'package:flutter/material.dart';
import 'package:number_funfact_flutter/src/number_details.dart';

const numberDetailsRouteName = '/number_details';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  numberDetailsRouteName: (BuildContext context) {
    return NumberDetailsPage();
  },
};
