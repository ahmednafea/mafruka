import 'dart:async';

import 'package:Mafruka/configs/app_assets.dart';
import 'package:Mafruka/configs/app_colors.dart';
import 'package:Mafruka/configs/size_config.dart';
import 'package:Mafruka/locale/app_translation.dart';
import 'package:Mafruka/modules/core/actions/open_home_screen_action.dart';
import 'package:Mafruka/modules/core/models/app_state.dart';
import 'package:Mafruka/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final mainLogo = Image(image: AppAssets.mainLogo);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInitialBuild: (Store<AppState> store) async {
        Shared.globalStore = store;
        Timer(Duration(seconds: 3), () {
          store.dispatch(OpenHomeScreenAction());
        });
      },
      builder: (BuildContext ctx, Store<AppState> store) {
        SizeConfig().init(context);
        return Scaffold(
            key: scaffoldKey,
            body: Material(
                color: Colors.white,
                child: Container(
                    child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 5,
                            vertical: SizeConfig.safeBlockVertical * 5),
                        child: Image(image: AppAssets.mainLogo),
                      ),
                      Text(
                        AppTranslations.of(context).text("welcome"),
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: SizeConfig.safeBlockVertical * 5,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ))));
      },
    );
  }
}
