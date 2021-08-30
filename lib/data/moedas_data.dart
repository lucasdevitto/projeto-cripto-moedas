import 'package:cripto_moedas/models/moedas_models.dart';

class MoedasData {
  static List<MoedasModels> tabela = [
    MoedasModels(
      icone: 'assets/images/bitcoin.webp',
      title: 'BitCoin',
      subTitle: 'BTC',
      price: 253224.66,
    ),
    MoedasModels(
      icone: 'assets/images/ethereum.webp',
      title: 'Ethereum',
      subTitle: 'ETH',
      price: 16824.80,
    ),
    MoedasModels(
      icone: 'assets/images/cardano.webp',
      title: 'Cardano',
      subTitle: 'ADA',
      price: 14.66,
    ),
    MoedasModels(
      icone: 'assets/images/binance-coin.webp',
      title: 'Binance-Coin',
      subTitle: 'BNB',
      price: 252.77,
    ),
    MoedasModels(
      icone: 'assets/images/tether.webp',
      title: 'Tether',
      subTitle: 'USDT',
      price: 5.20,
    ),
    MoedasModels(
      icone: 'assets/images/xrp.webp',
      title: 'XRP',
      subTitle: 'XRP',
      price: 5.92,
    ),
    MoedasModels(
      icone: 'assets/images/dogecoin.webp',
      title: 'DogeCoin',
      subTitle: 'DOGE',
      price: 1.40,
    ),
    MoedasModels(
      icone: 'assets/images/solana.webp',
      title: 'Solana',
      subTitle: 'SOL',
      price: 487.81,
    ),
    MoedasModels(
      icone: 'assets/images/usd-coin.webp',
      title: 'USD Coin',
      subTitle: 'USDC',
      price: 5.14,
    ),
    MoedasModels(
      icone: 'assets/images/polkadot-new.webp',
      title: 'Polkadot',
      subTitle: 'DOT',
      price: 133.69,
    ),
  ];
}
