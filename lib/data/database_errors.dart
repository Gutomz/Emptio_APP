class DatabaseError {
  static Map<String, dynamic> notFoundError(String errorCode) {
    return {
      "code": errorCode,
    };
  }
}
