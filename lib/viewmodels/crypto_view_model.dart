import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crypto.dart';  
import '../services/cryptoservice.dart';  

final cryptoServiceProvider = Provider((ref) => CryptoService());

final cryptoListProvider = FutureProvider<List<Crypto>>((ref) async {
  final cryptoService = ref.read(cryptoServiceProvider);
  return await cryptoService.getCryptos();
});

final cryptoDetailProvider = FutureProvider.family<Crypto, String>((ref, id) async {
  final cryptoService = ref.read(cryptoServiceProvider);
  return await cryptoService.getCrypto(id);
});

final cryptoSearchIdProvider = StateProvider<String?>((ref) => null);



