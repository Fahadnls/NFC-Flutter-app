// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

String get BASE_URL => dotenv.env["DB_URL"] ?? "";

String get URL_TYPE => dotenv.env["URL_TYPE"] ?? "";

String get FILE_BASE_URL_LOCAL => dotenv.env["BASE_FILE_URL_LOCAL"] ?? "";
String get FILE_BASE_URL => dotenv.env["BASE_FILE_URL"] ?? "";

String get GOOGLE_API_KEY => dotenv.env["GOOGLE_API_KEY"] ?? "";

String get ONE_SIGNAL_APP_ID => dotenv.env["ONE_SIGNAL_APP_ID"] ?? "";
String get SOCKET_URL => dotenv.env["SOCKET_URL"] ?? "";
