import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';

class FirebaseController {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {'Authorization': 'Bearer $token'};
    if (fcmToken != null) {
      await http.post(Uri.parse('${basePath}/update-device-token'),
          body: {'fcmtoken': fcmToken}, headers: headers);
    }
  }
}
