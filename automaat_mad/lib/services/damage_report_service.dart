import 'package:automaat_mad/services/api_service.dart';

class DamageReportService {
  final ApiService api;
  DamageReportService({required this.api});
  Future<void> submitReport({
    required String odometer,
    required String result,
    required String description,
    required String photo,
  }) async {
    final reportData = {
      'odometer': odometer,
      'result': result,
      'description': description,
      'photo': photo,
    };
    await api.post('/api/inspections', reportData);
    return;
  }
}