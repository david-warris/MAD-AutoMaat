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
            _buildTextField(
              controller: odometerController,
              labelText: 'Odometer',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: resultController,
              labelText: 'Result',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: descriptionController,
              labelText: 'Description',
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: photoController,
              labelText: 'Photo',
            ),
            const SizedBox(height: 24),
            const Text(
              'Damage Report Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  final api = Provider.of<ApiService>(context, listen: false);
                  await DamageReportService(api: api).submitReport(
                    odometer: odometerController.text,
                    result: resultController.text,
                    description: descriptionController.text,
                    photo: photoController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Submit Report',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFFFFC107)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFFFC107)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFFFC107)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFFFC107), width: 2),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
    );
  }
}
