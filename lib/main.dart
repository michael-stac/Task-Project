import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:userapp/utils/appColors.dart';

import 'features/user/screens/user.dart';
import 'features/user/view_model/user_view_model.dart';



void main() async {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor, // status bar color
    statusBarBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: AppColor.primaryColor,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Inter',
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                backgroundColor: Colors.white, elevation: 0),
            highlightColor: AppColor.grayColor,
            primaryColor: AppColor.primaryMaterialColor,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColor.primaryMaterialColor)
                .copyWith(secondary: AppColor.primaryMaterialColor)),
        home:  UserListScreen(),
      ),
    );
  }
}
