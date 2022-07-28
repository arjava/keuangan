class Constants {
  static String endpoint(String url) {
    String baseUrl = "dev";
    final buildVariant = baseUrl;
    if (buildVariant == "dev") {
      baseUrl = "http://test-tech.api.jtisrv.com/md/public";
    }
    return baseUrl + url;
  }

  static const String appName = "App Keuangan";
  static const String logoTag = 'com.arjavax.logo';
  static const String titleTag = 'com.arjavax.title';
}
