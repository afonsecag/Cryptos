import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto/viewmodels/crypto_view_model.dart'; 

class CryptoListView extends ConsumerWidget {
  const CryptoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptoList = ref.watch(cryptoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Criptomonedas'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, 
        leading: BackButton(color: Colors.black, onPressed: () => Navigator.pop(context)),
        elevation: 0, 
      ),
      body: cryptoList.when(
        data: (cryptos) => ListView.builder(
          itemCount: cryptos.length,
          itemBuilder: (context, index) {
            final crypto = cryptos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200], 
                  child: Text(crypto.symbol[0]), 
                ),
                title: Text(crypto.name),
                subtitle: Text('${crypto.symbol} · ${crypto.priceUsd} USD'),
                trailing: Icon(Icons.chevron_right), 
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Error al cargar datos')),
      ),
    );
  }
}