// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest.dart' as tz; 
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//         // const AndroidInitializationSettings('@mipmap/ic_notification');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         // onDidReceiveLocalNotification:
//         //     (int id, String? title, String? body, String? payload) async {}
//             );

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'balansize',
//           'Balansize',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails());
//   }

//   Future showNotification(
//       {int id = 0, String? title, String? body, String? payLoad}) async {
//     return notificationsPlugin.show(
//         id, title, body,  notificationDetails());
//   }

//   Future scheduleNotification(
//       {int id = 0,
//       String? title,
//       String? body,
//       String? payLoad,
//       required int scheduledNotificationDateTime}) async {
//     // print(scheduledNotificationDateTime);
//     // print("scheduledNotificationDateTime");
//     await notificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.now(tz.local)
//             .add(Duration(seconds: scheduledNotificationDateTime)),
//         // tz.TZDateTime.now(tz.local)
//         //     .add(Duration(hours: scheduledNotificationDateTime)),
//         notificationDetails(),
//         // androidAllowWhileIdle: true,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         // uiLocalNotificationDateInterpretation:
//         //     UILocalNotificationDateInterpretation.absoluteTime
//             );
//   }
// }

// cancelAllNotifications() async =>
//     await NotificationService().notificationsPlugin.cancelAll();
// scheduleAllNotification() async {
//   await cancelAllNotifications();
//   await NotificationService().scheduleNotification(
//       id: 1,
//       title: '✨ Reconnect with Your Inner Balance',
//       body: "Take a deep breath and check in with Balansize.☀️\nYour personalized wellbeing tip awaits to brighten your day.",
//       scheduledNotificationDateTime: 24);
//   // await NotificationService().scheduleNotification(
//   //     id: 2,
//   //     title: 'New Puzzle Alert!',
//   //     body: "🎨 New 3D puzzles await in Blokky! Play now!",
//   //     scheduledNotificationDateTime: 48);
//   // await NotificationService().scheduleNotification(
//   //     id: 3,
//   //     title: 'Be the Architect of Your Fun!',
//   //     body: "🏗 Craft your levels in Blokky! Unleash creativity!",
//   //     scheduledNotificationDateTime: 72);
//   // await NotificationService().scheduleNotification(
//   //     id: 4,
//   //     title: 'New Puzzle Alert!',
//   //     body: "🎨 New 3D puzzles await in Blokky! Play now!",
//   //     scheduledNotificationDateTime: 168);
// }
