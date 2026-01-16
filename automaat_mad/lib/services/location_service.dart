import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  // Check of locatie services aan staan
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Locatie services staan uit');
  }

  // Check permissions
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Locatie permissie permanent geweigerd');
  }

  if (permission == LocationPermission.denied) {
    throw Exception('Locatie permissie geweigerd');
  }

  // Haal huidige positie op
  return Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
