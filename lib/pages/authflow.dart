import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testone/logic/auteflow/cubit/authflow_cubit.dart';
import 'package:testone/pages/employee.dart';
import 'package:testone/pages/homepage.dart';
import 'package:testone/router/auto_route.gr.dart';

class CubitLinkStatusPage extends StatefulWidget {
  const CubitLinkStatusPage({super.key});

  @override
  State<CubitLinkStatusPage> createState() => _CubitLinkStatusPageState();
}

class _CubitLinkStatusPageState extends State<CubitLinkStatusPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AuthflowCubit>().getloginstatus();

    super.initState();
  }

  Widget build(BuildContext context) {
    final statuswatch = context.watch<AuthflowCubit>().state;
    final status = statuswatch.status;
    return AutoRouter.declarative(
      routes: (handler) {
        switch (status) {
          case LoginStatus.loginstate:
            return [MyHomeRoute()];

          case LoginStatus.logoutstate:
            return [LogInRoute()];
          case LoginStatus.initialstate:
            return [];
        }
      },
    );
  }
}
