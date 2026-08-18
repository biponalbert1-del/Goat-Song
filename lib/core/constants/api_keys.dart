class ApiKeys {
  const ApiKeys._();

  static const String deezerBaseUrl = 'https://api.deezer.com';
  static const String lrcLibBaseUrl = 'https://lrclib.net/api';
  static const String lastFmApiKey = String.fromEnvironment('LASTFM_API_KEY');
  static const String admobAndroidAppId =
      String.fromEnvironment('ADMOB_ANDROID_APP_ID');
  static const String admobIosAppId =
      String.fromEnvironment('ADMOB_IOS_APP_ID');
}
