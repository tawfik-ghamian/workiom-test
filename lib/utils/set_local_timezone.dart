import 'package:flutter_timezone/flutter_timezone.dart';

Future<String> setupTimeZone() async {
  return await FlutterTimezone.getLocalTimezone();
}
