import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/constants/assets_images.dart';
import 'package:weather_app/helper/permission_helper.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/models/hourly_weather_model.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/services/weahter_services.dart';
import 'package:weather_app/styles/app_text_styles.dart';
import 'package:weather_app/widgets/elevated_button_widget.dart';
import 'package:weather_app/widgets/hourly_weather_tile_widget.dart';
import 'package:weather_app/widgets/text_form_field_widget.dart';
import 'package:weather_app/widgets/weather_info_card_widget.dart';

class HomeScreen extends StatefulWidget {
  static const id = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLocationEnabled = true;
  final TextEditingController locationController = TextEditingController();
  String? errorText;
  late String _timeString;
  Timer? _currentTimeTimer;
  int indexHourlyWeather = 0;
  bool isLoading = false;
  Position? currentPosition;
  String? userCity;
  Future<CurrentWeatherModel>? _currentWeatherFuture;
  Future<HourlyWeatherModel>? _forecastWeatherFuture;

  @override
  void initState() {
    super.initState();
    //Inisialisasi TImer
    _timeString = DateFormat("HH:mm:ss").format(DateTime.now()).replaceAll(":", " : ");
    _currentTimeTimer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    _getLocation();
  }

  @override
  void dispose() {
    locationController.dispose();
    _currentTimeTimer?.cancel();
    super.dispose();
  }

  void _getCurrentTime() {
    if (!mounted) return;

    setState(() {
      // String untuk menampilkan jam sesuai dengan Timer
      _timeString = DateFormat("HH:mm:ss").format(DateTime.now()).replaceAll(":", " : ");
    });
  }

  Future<void> _getLocation({String? address}) async {
    setState(() {
      isLoading = true;
    });
    final hasPermission = await PermissionHelper.locationPermission();
    if (hasPermission) {
      Position? position;

      if (address != null) {
        // Dijalankan ketika menginput lokasi secara manual
        try {
          List<Location> locations = await locationFromAddress(address);
          if (locations.isNotEmpty) {
            final loc = locations.first;
            position = Position(
              latitude: loc.latitude,
              longitude: loc.longitude,
              timestamp: DateTime.now(),
              altitudeAccuracy: 1.0,
              headingAccuracy: 1.0,
              accuracy: 1.0,
              altitude: 0.0,
              heading: 0.0,
              speed: 0.0,
              speedAccuracy: 0.0,
            );
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Cannot obtain position from address"),
                backgroundColor: AppColors.redPrimary,
              ),
            );
            return;
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to get coordinate from Address"),
              backgroundColor: AppColors.redPrimary,
            ),
          );
          return;
        } finally {
          setState(() {
            isLocationEnabled = true;
            isLoading = false;
            indexHourlyWeather = 0;
          });
        }
      } else {
        // Dijalankan ketika mendapatkan lokasi saat ini
        position = await Geolocator.getCurrentPosition();
      }

      // Mengambil tempat-tempat yang bisa dijadikan alamat berdasarkan latitude dan longitude
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      _currentWeatherFuture = WeahterServices.fetchCurrentWeather(
        lat: position.latitude,
        long: position.longitude,
      );
      _forecastWeatherFuture = WeahterServices.fetchForecastThreeHour(
        lat: position.latitude,
        long: position.longitude,
      );
      setState(() {
        isLocationEnabled = true;
        currentPosition = position;
        userCity = placemarks.first.locality;
        indexHourlyWeather = 0;
        isLoading = false;
      });
    } else {
      setState(() {
        indexHourlyWeather = 0;
        isLocationEnabled = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                AssetsImages.assetsBackgroundImage,
                height: currentHeight,
                width: currentWidth,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: currentHeight * 0.15,
              left: 0,
              right: 0,
              child: Image.asset(
                AssetsImages.assetsHouse,
                fit: BoxFit.contain,
                width: currentWidth,
              ),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.whitePrimary))
                : isLocationEnabled
                ? Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome,",
                                      style: AppTextStyles.regularSubHeadline(
                                        fontFamily: AssetsFonts.sfProDisplay,
                                      ),
                                    ),
                                    Text(
                                      args,
                                      style: AppTextStyles.boldTitle2(
                                        fontFamily: AssetsFonts.sfProDisplay,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _timeString,
                                  style: AppTextStyles.boldTitle2(
                                    fontFamily: AssetsFonts.sfProDisplay,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          currentPosition != null
                              ? FutureBuilder<CurrentWeatherModel>(
                                  future: _currentWeatherFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        "Error: ${snapshot.error}",
                                        style: TextStyle(color: AppColors.whitePrimary),
                                      );
                                    } else if (!snapshot.hasData) {
                                      return Text(
                                        "No weather data.",
                                        style: TextStyle(color: AppColors.whitePrimary),
                                      );
                                    }
                                    // Bagian data cuaca pada saat ini
                                    final weather = snapshot.data!;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      child: Column(
                                        children: [
                                          Text(
                                            userCity ?? "No Specific Location",
                                            style: AppTextStyles.regularLargeTItle(
                                              fontFamily: AssetsFonts.sfProDisplay,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "${weather.main?.temp?.round()}°",
                                            style: TextStyle(
                                              fontFamily: AssetsFonts.sfProDisplay,
                                              fontSize: 96,
                                              height: 70 / 96,
                                              fontWeight: FontWeight.w200,
                                              letterSpacing: 0.37,
                                              color: AppColors.whitePrimary,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            weather.weather?.isNotEmpty == true
                                                ? weather.weather![0].description ??
                                                      "No description"
                                                : "No description",
                                            style: AppTextStyles.boldTitle3(
                                              fontFamily: AssetsFonts.sfProDisplay,
                                              color: AppColors.darkSecondary,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "H:${weather.main?.tempMax != null ? weather.main?.tempMax?.round() : "-"}°",
                                                style: AppTextStyles.boldTitle3(
                                                  fontFamily: AssetsFonts.sfProDisplay,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "L:${weather.main?.tempMin != null ? weather.main?.tempMin?.round() : "-"}°",
                                                style: AppTextStyles.boldTitle3(
                                                  fontFamily: AssetsFonts.sfProDisplay,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.5,
                        maxChildSize: 0.65,
                        builder: (context, scrollController) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(color: Colors.transparent),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.weatherContainer.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      width: 48,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: AppColors.blackPrimary.withValues(alpha: 0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: currentPosition != null
                                            ? FutureBuilder(
                                                future: _forecastWeatherFuture,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    return Text(
                                                      "Forecast error: ${snapshot.error}",
                                                    );
                                                  } else if (!snapshot.hasData) {
                                                    return Text("No forecast data.");
                                                  }
                                                  // Bagian data cuaca per 3 jam
                                                  final forecast = snapshot.data!;
                                                  return Column(
                                                    children: [
                                                      Text(
                                                        "3-Hourly Forecast",
                                                        style: AppTextStyles.boldHeadline(
                                                          fontFamily: AssetsFonts.sfProDisplay,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Container(
                                                        width: 135,
                                                        height: 2,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.whitePrimary,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      SizedBox(
                                                        height: 200,
                                                        child: ListView.builder(
                                                          itemCount: forecast.list!.length,
                                                          scrollDirection: Axis.horizontal,
                                                          itemBuilder: (context, index) {
                                                            final item = forecast.list![index];
                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  indexHourlyWeather = index;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                  left: 20,
                                                                  right:
                                                                      index ==
                                                                          forecast.list!.length - 1
                                                                      ? 20
                                                                      : 0,
                                                                ),
                                                                child: HourlyWeatherTileWidget(
                                                                  color: indexHourlyWeather == index
                                                                      ? AppColors.weatherContainer
                                                                      : AppColors
                                                                            .weatherColorSolid1,
                                                                  time:
                                                                      item.dtTxt ?? DateTime.now(),
                                                                  temperature: item.main?.temp ?? 0,
                                                                  image:
                                                                      item.weather![0].icon ?? "",
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 8,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceEvenly,
                                                          spacing: 12,
                                                          children: [
                                                            WeatherInfoCardWidget(
                                                              icon:
                                                                  Icons.device_thermostat_outlined,
                                                              title: "TEMPERATURE",
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].main?.temp != null ? forecast.list![indexHourlyWeather].main?.temp?.round() : "-"}°C",
                                                            ),
                                                            WeatherInfoCardWidget(
                                                              icon:
                                                                  Icons.device_thermostat_outlined,
                                                              title: "FEELS LIKE",
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].main?.feelsLike != null ? forecast.list![indexHourlyWeather].main?.feelsLike?.round() : "-"}°C",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 8,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceEvenly,
                                                          spacing: 12,
                                                          children: [
                                                            WeatherInfoCardWidget(
                                                              icon: Icons.compress_outlined,
                                                              title: "PRESSURE",
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].main?.pressure ?? "-"} hPa",
                                                            ),
                                                            WeatherInfoCardWidget(
                                                              icon: Icons.water_drop_outlined,
                                                              title: "HUMIDITY",
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].main?.humidity ?? "-"} %",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 8,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceEvenly,
                                                          spacing: 12,
                                                          children: [
                                                            WeatherInfoCardWidget(
                                                              title: "RAIN",
                                                              icon: Icons.cloud_outlined,
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].rain?.the3H ?? "-"} mm",
                                                            ),
                                                            WeatherInfoCardWidget(
                                                              title: "WIND SPEED",
                                                              icon: CupertinoIcons.wind,
                                                              content:
                                                                  "${forecast.list![indexHourlyWeather].wind?.speed ?? "-"} m/s",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : SizedBox.shrink(),
                                      ),
                                    ),
                                    SizedBox(height: 80),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            height: 60,
                            child: Container(
                              width: currentWidth,
                              decoration: BoxDecoration(
                                gradient: AppColors.weatherColorLinear2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    child: Image.asset(AssetsImages.assetsMap),
                                    onTap: () {
                                      // Reset TextField
                                      locationController.clear();
                                      errorText = "Location can't be empty";
                                      showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.symmetric(
                                                vertical: 32,
                                                horizontal: 24,
                                              ),
                                              title: Center(
                                                child: Text(
                                                  "Input Location",
                                                  style: AppTextStyles.boldTitle1(
                                                    fontFamily: AssetsFonts.sfProDisplay,
                                                    color: AppColors.weatherColorSolid1,
                                                  ),
                                                ),
                                              ),
                                              content: TextFormFieldWidget(
                                                controller: locationController,
                                                textInputAction: TextInputAction.done,
                                                hintText: "Location",
                                                errorText: errorText,
                                                onChanged: (_) {
                                                  setState(() {
                                                    if (locationController.text.isEmpty) {
                                                      errorText = "Location can't be empty";
                                                    } else {
                                                      errorText = null;
                                                    }
                                                  });
                                                },
                                              ),
                                              actions: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                SizedBox(width: 4),
                                                ElevatedButtonWidget(
                                                  horizontalPadding: 16,
                                                  disabledBackgroundColor: Colors.grey,
                                                  backgroundColor: AppColors.weatherColorSolid1,
                                                  text: "Search",
                                                  onPressed: errorText == null
                                                      ? () {
                                                          Navigator.pop(context);
                                                          _getLocation(
                                                            address: locationController.text,
                                                          );
                                                        }
                                                      : null,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(),
                                  InkWell(
                                    child: Icon(
                                      Icons.refresh,
                                      color: AppColors.whitePrimary,
                                      size: 28,
                                    ),
                                    onTap: () {
                                      _getLocation();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 14,
                            child: Center(
                              child: SizedBox(
                                width: currentWidth,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.redPrimary,
                                  radius: 40,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.id,
                                        (route) => false,
                                      );
                                    },
                                    child: Icon(
                                      Icons.logout,
                                      color: AppColors.whitePrimary,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : // Izin Lokasi
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.weatherColorSolid2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(28),
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Please Enable your Location permission"),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButtonWidget(
                              text: "Open Permission",
                              onPressed: () {
                                _getLocation();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
