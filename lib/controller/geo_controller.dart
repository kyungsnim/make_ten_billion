import 'package:make_ten_billion/constants/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class GeoController extends GetxController {
  static GeoController to = Get.find();

  Position? position;
  WeatherFactory wf = WeatherFactory(MY_WEATHER_API_KEY, language: Language.KOREAN);
  Weather? w;
  String cityName = '';

  getCurrentPosition() async {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high).then((val) {
      position = val;
      update();
    });
  }

  getCurrentWeatherByLocation(lat, lon) async {
    w = await wf.currentWeatherByLocation(lat, lon);
    update();
  }
}