import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto/viewmodels/crypto_view_model.dart';

class CryptoSearchView extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  CryptoSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Criptomoneda'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'ID de la Criptomoneda',
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: () {
                    ref.read(cryptoSearchIdProvider.notifier).state = _controller.text;
                  },
                ),
              ),
              cursorColor: Colors.deepPurple,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final searchId = ref.watch(cryptoSearchIdProvider);
                  if (searchId == null || searchId.isEmpty) {
                    return const Center(child: Text('Ingrese el ID de una criptomoneda'));
                  }

                  final cryptoDetail = ref.watch(cryptoDetailProvider(searchId));
                  return cryptoDetail.when(
                    data: (crypto) => Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(crypto.name),
                        subtitle: Text('Precio: ${crypto.priceUsd}'),
                      ),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => const Center(child: Text('Error al cargar datos')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}