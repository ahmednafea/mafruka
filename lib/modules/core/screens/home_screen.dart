import 'package:Mafruka/configs/size_config.dart';
import 'package:Mafruka/locale/app_translation.dart';
import 'package:Mafruka/modules/core/models/app_state.dart';
import 'package:Mafruka/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (Store<AppState> store) {
      Shared.globalStore = store;
    }, builder: (BuildContext ctx, Store<AppState> store) {
      SizeConfig().init(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text("home")),
          centerTitle: true,
        ),
        body: Container(),
      );
    });
  }
}
