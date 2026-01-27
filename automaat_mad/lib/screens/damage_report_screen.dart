import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/damage_report_service.dart';
import 'package:automaat_mad/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DamageReportScreen extends StatelessWidget {
  const DamageReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final odometerController = TextEditingController();
    final resultController = TextEditingController();
    final descriptionController = TextEditingController();
    final photoController = TextEditingController();
    return AppScaffold(
      title: 'Damage Report',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: odometerController,
              decoration: InputDecoration(
                labelText: 'Odometer',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: resultController,
              decoration: InputDecoration(
                labelText: 'Result',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: photoController,
              decoration: InputDecoration(
                labelText: 'Photo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Damage Report',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                final api = Provider.of<ApiService>(context, listen: false);
                await DamageReportService(api: api).submitReport(
                  odometer: odometerController.text,
                  result: resultController.text,
                  description: descriptionController.text,
                  photo: photoController.text,
                );
                // TODO: Submit damage report
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
