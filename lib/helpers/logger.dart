import 'dart:developer';

class Logger {
  static void error(
      String name, String message, Object? error, StackTrace stackTrace) {
    final time = DateTime.now().toString();
    log("################### ERROR ###################", name: name);
    log("$time - $message", name: name);
    log("$time - Error: $error", name: name);
    log("$time - Stack: $stackTrace", name: name);
    log("#############################################", name: name);
  }
}
