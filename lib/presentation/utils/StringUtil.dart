import 'dart:convert';

class StringUtil {
  /// json map을 pretty json으로 변환하여 반환합니다.
  static String convertPrettyJson(Map<String, dynamic> jsonMap) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonMap);
  }

  /// bytes int 정보를 메가바이트로 변환하여 반환합니다.
  static String formatBytesToMegabytes(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    double kilobytes = bytes / 1024;

    if (megabytes >= 0.1) {
      return '${megabytes.toStringAsFixed(1)}MB';
    } else if (kilobytes >= 10) {
      return '0.1MB';
    } else if (kilobytes >= 1) {
      return '${kilobytes.toStringAsFixed(0)}KB';
    } else {
      return '${bytes}B';
    }
  }

  /// url에서 파일 확장자를 추출하여 반환합니다.
  static String? extractFileExtensionFromUrl(String? url) {
    return url?.split('.').last;
  }

  /// 주어진 시간(초) 정보를 포맷에 맞게 변환하여 반환합니다. "00:01:01"
  static String formatDuration(double seconds) {
    final tempSecond = seconds.toInt();
    int hours = tempSecond ~/ 3600;
    int minutes = (tempSecond % 3600) ~/ 60;
    int remainingSeconds = (tempSecond % 60);

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }


}
