// lib/services/anggota_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anggota_model.dart';

class AnggotaService {
  // Set your Laravel API base URL here. Example: http://10.0.2.2:8000/api
  // For Android emulator use 10.0.2.2, for iOS simulator use localhost, or replace with your real IP/domain.
  final String baseUrl;

  AnggotaService({required this.baseUrl});

  Future<List<AnggotaModel>> fetchAnggota() async {
    // baseUrl can be either the API root (e.g. http://10.0.2.2:8000/api) or the full endpoint
    // (e.g. http://192.168.18.192:8000/api/keluarga). We accept both.
    final endpoint = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Expecting the API to return a JSON array or an object with 'data' key.
      final List items = data is List ? data : (data['data'] ?? []);

      return items.map((e) => AnggotaModel.fromJson(e)).toList();
    } else {
      // Provide body snippet for easier debugging
      final bodySnippet = response.body.length > 200
          ? '${response.body.substring(0, 200)}...'
          : response.body;
      throw Exception(
        'Failed to load anggota: ${response.statusCode} - $bodySnippet',
      );
    }
  }
}
