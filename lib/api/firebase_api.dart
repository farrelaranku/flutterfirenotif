import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pushnotif/main.dart';

class FirebaseApi{


  //create instance firebase messaging
  final _firebaseMessaging  = FirebaseMessaging.instance;


  //function initialize notif
  Future<void> initNotifications() async{
    //req permission from user
  await _firebaseMessaging.requestPermission();
    //fetch the FCM token for device
  final fcmToken = await _firebaseMessaging.getToken();

  //print token
  print ('Token = $fcmToken');

  initPushNotification();
  }

  //handle received messages
  void handleMessage(RemoteMessage? message){
    //message null do nothing
    if (message==null) return;

    //navigate to new screen when receive message and user tap
    print('push');
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments:message,
    );
  }

  //init background settings
  Future initPushNotification() async{
    //handle notif if the app was terminated and opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a notif open app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

}