// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/src/widgets/framework.dart' as _i7;

import '../pages/authflow.dart' as _i1;
import '../pages/homepage.dart' as _i4;
import '../pages/login_page.dart' as _i3;
import '../pages/signup_page.dart' as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    CubitLinkStatusRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.CubitLinkStatusPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignUpPage(),
      );
    },
    LogInRoute.name: (routeData) {
      final args = routeData.argsAs<LogInRouteArgs>(
          orElse: () => const LogInRouteArgs());
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.LogInPage(key: args.key),
      );
    },
    MyHomeRoute.name: (routeData) {
      final args = routeData.argsAs<MyHomeRouteArgs>(
          orElse: () => const MyHomeRouteArgs());
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.MyHomePage(key: args.key),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          CubitLinkStatusRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              LogInRoute.name,
              path: 'log-in-page',
              parent: CubitLinkStatusRoute.name,
            ),
            _i5.RouteConfig(
              MyHomeRoute.name,
              path: 'my-home-page',
              parent: CubitLinkStatusRoute.name,
            ),
          ],
        ),
        _i5.RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-page',
        ),
      ];
}

/// generated route for
/// [_i1.CubitLinkStatusPage]
class CubitLinkStatusRoute extends _i5.PageRouteInfo<void> {
  const CubitLinkStatusRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CubitLinkStatusRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'CubitLinkStatusRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-page',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i3.LogInPage]
class LogInRoute extends _i5.PageRouteInfo<LogInRouteArgs> {
  LogInRoute({_i7.Key? key})
      : super(
          LogInRoute.name,
          path: 'log-in-page',
          args: LogInRouteArgs(key: key),
        );

  static const String name = 'LogInRoute';
}

class LogInRouteArgs {
  const LogInRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'LogInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.MyHomePage]
class MyHomeRoute extends _i5.PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({_i7.Key? key})
      : super(
          MyHomeRoute.name,
          path: 'my-home-page',
          args: MyHomeRouteArgs(key: key),
        );

  static const String name = 'MyHomeRoute';
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key}';
  }
}
