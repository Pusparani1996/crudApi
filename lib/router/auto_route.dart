// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:testone/pages/authflow.dart';
import 'package:testone/pages/homepage.dart';
import 'package:testone/pages/login_home_page.dart';
import 'package:testone/pages/login_page.dart';
import 'package:testone/pages/signup_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: CubitLinkStatusPage, initial: true, children: [
      AutoRoute(page: LogInPage),
      AutoRoute(page: MyHomePage),
    ]),
    AutoRoute(page: SignUpPage),
  ],
)
class $AppRouter {}
