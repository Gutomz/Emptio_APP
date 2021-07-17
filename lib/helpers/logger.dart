import 'dart:developer';

class Logger {
  static void error(
      String tag, String methodName, Object? error, StackTrace stackTrace) {
    final time = DateTime.now().toString();
    log("################### ERROR ###################", name: tag);
    log("$time - Exception occurred at '$methodName'", name: tag);
    log("$time - Error: $error", name: tag);
    log("$time - Stack: $stackTrace", name: tag);
    log("#############################################", name: tag);
  }
}
