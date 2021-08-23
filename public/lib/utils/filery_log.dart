

class FileryLog {


  static void v(String text) {
    print("🙃 : \x1B[34m$text\x1B[0m");
  }
  static void ok(String text) {
    print("🆗 : \x1B[32m$text\x1B[0m");
  }
  static void w(String text) {
    print("⚠️ : \x1B[33m$text\x1B[0m");
  }
  static void e(String text) {
    print("🛑 : \x1B[31m$text\x1B[0m");
  }

}