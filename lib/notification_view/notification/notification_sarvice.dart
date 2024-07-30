import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notificationservice {
  var databse = FirebaseDatabase.instance;
  getNotificationToken() async{
    FirebaseMessaging getToken = FirebaseMessaging.instance;
    var get =await getToken.getToken();
    print(get);
  }

}