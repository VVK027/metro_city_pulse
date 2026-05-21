// import 'dart:async';
//
// import 'package:geocoding/geocoding.dart' as geocode;
// import 'package:/core/utils/log_util.dart';
// import 'package:/domain/entity/user_entity.dart';
// import 'package:/presentation/utils/localization_util.dart';
// import 'package:location/location.dart';
//
// class LocationServiceUtil {
//
//   static const tag = "LocationServiceUtil";
//   static StreamSubscription? _locationStreamListener;
//
//   static cancelLocationStream() {
//     _locationStreamListener?.cancel();
//     LogUtil.log(tag, "cancelLocationStream");
//   }
//
//   static fetchLocation(Function(LocationData) onResult, {bool getLocationStream = false}) {
//     try {
//       Location location = Location();
//       _locationServiceEnabled(location).then((value) {
//         if (value) {
//           _locationPermissionGranted(location).then((value) {
//             if (value == PermissionStatus.granted) {
//               LogUtil.log(
//                   tag, "Location Permission granted, fetching location");
//               if (getLocationStream) {
//                 // location stream
//                 _locationStreamListener = location.onLocationChanged.listen((event) {
//                   onResult(event);
//                 });
//               } else {
//                 // one time location
//                 location.getLocation().then((value) {
//                   LogUtil.log(tag, "Location received $value");
//                   onResult(value);
//                 });
//               }
//             } else {
//               LogUtil.log(tag, "Location Permission denied");
//             }
//           });
//         } else {
//           LogUtil.log(tag, "Location Service Disabled");
//         }
//       });
//     } catch (e) {
//       LogUtil.log(tag, "Exception occurred while fetching location Permission denied");
//     }
//   }
//
//   static Future<bool> isLocationPermissionAndServiceEnabled() async {
//     try {
//       Location location = Location();
//       final isServiceEnabled = await location.serviceEnabled();
//       final permissionStatus = await location.hasPermission();
//       return isServiceEnabled && (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.grantedLimited);
//     } catch (e) {
//       LogUtil.log(tag, "isLocationPermissionAndServiceEnabled: error - $e");
//       return false;
//     }
//   }
//
//   static Future<bool> _locationServiceEnabled(Location location) async {
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return false;
//       }
//     }
//     return serviceEnabled;
//   }
//
//   static Future<PermissionStatus> _locationPermissionGranted(Location location) async {
//     PermissionStatus permissionStatus = await location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         return permissionStatus;
//       }
//     }
//     return permissionStatus;
//   }
//
//   static Future<Map<String, dynamic>> getAddressFromLocation(double latitude, double longitude) async {
//     try {
//       List<geocode.Placemark> places = await geocode.placemarkFromCoordinates(
//           latitude, longitude);
//       return places.isNotEmpty ? places[0].toJson() : {};
//     } catch (e) {
//       LogUtil.log(tag, "getAddressFromLocation: error occurred $e");
//     }
//     return {};
//   }
//
//   static Future<String> getUserAddressFromLocation(GeoLocation? location) async {
//     try {
//       if (location != null && location.latitude != null && location.longitude != null) {
//         final data = await getAddressFromLocation(
//             location.latitude!, location.longitude!);
//         String address = "";
//         if (data["locality"] != null) {
//           address = data["locality"]?.toString() ?? "";
//         }
//         if (data["subLocality"] != null) {
//           final subLocality = data["subLocality"]?.toString() ?? "";
//           address = address.isNotEmpty ? "$address, $subLocality" : subLocality;
//         }
//         if (data["country"] != null) {
//           final country = data["country"]?.toString() ?? "";
//           address = address.isNotEmpty ? "$address, $country" : country;
//         }
//         LogUtil.log(tag, "getUserAddressFromLocation: address: $address");
//         return address.isEmpty ? "unknown".tr(ref) : address;
//       }
//     } catch (e) {
//       LogUtil.log(tag, "getUserAddressFromLocation: error occurred $e");
//     }
//     return "unknown".tr(ref);
//   }
// }