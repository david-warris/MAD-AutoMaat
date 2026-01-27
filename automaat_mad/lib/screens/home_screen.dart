import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/car_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:automaat_mad/widgets/appbar.dart';
import 'package:automaat_mad/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late CarService carService;
  late RentalService rentalService;
  late Future<_HomeData> homeData;

  @override
  void initState() {
    super.initState();
    carService = CarService();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final api = Provider.of<ApiService>(context, listen: false);
    rentalService = RentalService(api: api);

    homeData = _fetchHomeData();
  }

  Future<_HomeData> _fetchHomeData() async {
    final cars = await carService.fetchCars();
    final rentals = await rentalService.fetchRentals();
    return _HomeData(cars: cars, rentals: rentals);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Beschikbare auto’s',
      body: FutureBuilder<_HomeData>(
        future: homeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            debugPrint(snapshot.stackTrace.toString());

            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          
          final cars = snapshot.data!.cars;
          final rentals = snapshot.data!.rentals;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              final hasActiveRental = rentals.any(
                (rental) =>
                    rental.car.id == car.id &&
                    rental.state != 'RETURNED',
              );

              return CarCard(
                car: car,
                available: !hasActiveRental,
              );
            },
          );
        },
      ),
    );
  }
}
class _HomeData {
  final List<Car> cars;
  final List rentals;

  _HomeData({required this.cars, required this.rentals});
}


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final CarService carService = CarService();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Beschikbare auto’s')),
//       body: FutureBuilder<List<Car>>(
//         future: carService.fetchCars(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('Fout bij laden'));
//           }

//           final cars = snapshot.data!;
//           return ListView.builder(
//             itemCount: cars.length,
//             itemBuilder: (context, index) => CarCard(car: cars[index]),
//           );
//         },
//       ),
//     );
//   }
// }