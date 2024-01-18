import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class CryptoService {
  final String baseUrl = 'https://api.coincap.io/v2/';

  Future<List<Crypto>> getCryptos() async {
  try {
    final response = await http.get(Uri.parse('${baseUrl}assets'));
    if (response.statusCode == 200) {
      List<dynamic> cryptoListData = jsonDecode(response.body)['data'];
      return cryptoListData.map((cryptoData) => Crypto.fromJson(cryptoData as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Error al cargar datos de las criptomonedas');
    }
  } catch (e) {
    throw Exception('Error al realizar la petición: $e');
  }
}

  Future<Crypto> getCrypto(String id) async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}assets/$id'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return Crypto.fromJson(data);
      } else {
        throw Exception('Error al cargar datos de la criptomoneda');
      }
    } catch (e) {
      throw Exception('Error al realizar la petición: $e');
    }
  }
}
