enum SharedKey {
  ACCESS_TOKEN, // 앱 로그인 토큰
}

class SharedKeyHelper {
  static const Map<SharedKey, String> _stringToEnum = {
    SharedKey.ACCESS_TOKEN: "ACCESS_TOKEN",
  };

  static String fromString(SharedKey key) => _stringToEnum[key]!;
}
