class Constants {
  static String endpoint(String url) {
    String baseUrl = "dev";
    final buildVariant = "api";
    if(buildVariant=="dev"){
      baseUrl = "http://test-tech.api.jtisrv.com/md/public";
    }
    return baseUrl+url;
  }
  static const String appName = "App Keuangan";
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}