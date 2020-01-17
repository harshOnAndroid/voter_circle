import 'package:flutter/widgets.dart';

import 'LandingScreenBloc.dart';


class LandingScreenProvider extends InheritedWidget{
  final LandingScreenBloc landingScreenBloc;

  LandingScreenProvider({Key key, @required this.landingScreenBloc, Widget child}) : super (key:key, child:child){
    print("homescreen provider");
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LandingScreenBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LandingScreenProvider) as LandingScreenProvider)
          .landingScreenBloc;
}
