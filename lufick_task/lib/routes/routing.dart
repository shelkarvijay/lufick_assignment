

import 'package:flutter/cupertino.dart';
import 'package:lufick_task/constants/constants.dart';
import 'package:lufick_task/screens/listing-screen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RoutingNamesConstant.HOME_ROUTE : (BuildContext context) => ListingScreen(),
  RoutingNamesConstant.MAIN_SCREEN : (BuildContext context) => ListingScreen(),
};
