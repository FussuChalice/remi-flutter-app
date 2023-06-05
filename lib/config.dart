/// Set default args
class AppConfig {
  AppConfig._();

  // API KEYS
  static const _GOOGLE_MAP_IOS_API_KEY_ = "AIzaSyD-u0bWJ-4Wf2luKBS_Rr8J43VQTuKaKaQ";
  static const _GOOGLE_MAP_ANDROID_API_KEY_ = "AIzaSyDySMUHQjRkVUVLNBlFc19AwXwv4m_HjUg";

  static const _SERVER_API_BASE_ = "localhost:5050/api/v1/";
  static const _SERVER_API_PROTOCOL_ = "http";



  static const Map<String, int> DEFAULT_S_NUM = {
    "restaurant": 1,
    "coffee": 2,
    "bar": 3,
    "pizzeria": 4,
    "pub": 5
  };

  static const List<String> DEFAULT_SERVICES_TYPES = [
    "restaurant",
    "coffee",
    "bar",
    "pizzeria",
    "pub",
  ];

  static get GOOGLE_MAP_IOS_API_KEY_ => _GOOGLE_MAP_IOS_API_KEY_;
  static get GOOGLE_MAP_ANDROID_API_KEY_ => _GOOGLE_MAP_ANDROID_API_KEY_;

  static get SERVER_API_BASE => _SERVER_API_BASE_;
  static get SERVER_API_PROTOCOL => _SERVER_API_PROTOCOL_;
}