import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testone/logic/auteflow/cubit/authflow_cubit.dart';

import 'package:testone/pages/login_home_page.dart';
import 'package:testone/router/auto_route.gr.dart';
import 'package:testone/services/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  LocalNotificationService.initilize();

  messagerequest();
  // listenedmessage();

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("I am coming background : ${message.messageId}");
}

void messagerequest() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) => log(value.toString()));

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: false,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log("authorized");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("user granted");
  } else {
    log("user deliend");
  }

  // Terminated State
  FirebaseMessaging.instance.getInitialMessage().then((event) {
    if (event != null) {
      print(
          "${event.notification!.title} ${event.notification!.body} I am coming from terminated state");
    }
  });

  // Foregrand State
  FirebaseMessaging.onMessage.listen((event) {
    LocalNotificationService.showNotificationOnForeground(event);

    print(
        "${event.notification!.title} ${event.notification!.body} I am coming from foreground");
  });

  // background State
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(
        "${event.notification!.title} ${event.notification!.body} I am coming from background");
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// String foregrnotification = "";
// void listenedmessage() {

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     log('Got a message whilst in the foreground!');
//     log('Message data: ${message.data}');

//     if (message.notification != null) {
//       log('Message also contained a notification: ${message.notification}');
//       setState() {
//         foregrnotification =
//             "${message.notification!.title} ${message.notification!.body} Foreground message";
//       }
//     }
//   });
// }

final appRouter = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override

  // void getdevicetoken() async {
  //   await FirebaseMessaging.instance.getToken().then((devicetoken) {
  //     setState() {
  //       dtoken = devicetoken;
  //     }
  //   });
  // }
  // void savedtoken(String devicetoken) async {
  //   await FirebaseFirestore.instance.collection()

  // }

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthflowCubit(),
          //child: Container(),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: EasyLoading.init(),
      ),
    );
  }
}
