import 'package:flutter/material.dart';
import 'package:flutter_breaking_bad/app_router.dart';
import 'package:flutter_breaking_bad/shared/values/colors.dart';

void main() {
  runApp(BreakingBadApp(appRouter: AppRouter()));
}

class BreakingBadApp extends StatelessWidget {

  final AppRouter appRouter;
  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: MyColors.grey
          )
        )
      ),
    );
  }
}
