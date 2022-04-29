class EscapeHtmlUtils {
  static String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static String removeEscapedHtml(String htmlText) {
    RegExp exp = RegExp(r"&[^;]*;", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
