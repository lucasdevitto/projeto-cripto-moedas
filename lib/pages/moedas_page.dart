import 'package:cripto_moedas/configs/app_settings.dart';
import 'package:cripto_moedas/data/favoritas_data.dart';
import 'package:cripto_moedas/data/moedas_data.dart';
import 'package:cripto_moedas/models/moedas_models.dart';
import 'package:cripto_moedas/pages/moedas_detalhes_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedasData.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<MoedasModels> selecionadas = [];
  late FavoritasData favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          leading: Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        )),
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Cripto Moedas'),
        centerTitle: true,
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        centerTitle: true,
        backgroundColor: Colors.teal[100],
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  addFavoritar() {
    if (selecionadas.isNotEmpty) {
      return FloatingActionButton.extended(
        onPressed: () {
          favoritas.saveAll(selecionadas);
          limparSelecionadas();
        },
        icon: Icon(Icons.star),
        label: Text(
          'FAVORITAR',
          style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return null;
    }
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  mostrarDetalhes(MoedasModels moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasData>(context);
    favoritas = context.watch<FavoritasData>();
    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int indice) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[indice]))
                ? CircleAvatar(
                    child: Icon(Icons.check_circle),
                  )
                : SizedBox(
                    width: 40,
                    child: Image.asset(tabela[indice].icone),
                  ),
            title: Row(
              children: [
                Text(
                  tabela[indice].title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.lista
                    .any((fav) => fav.subTitle == tabela[indice].subTitle))
                  Icon(
                    Icons.circle,
                    color: Colors.amber,
                    size: 8,
                  ),
              ],
            ),
            trailing: Text(real.format(tabela[indice].price)),
            selected: selecionadas.contains(tabela[indice]),
            selectedTileColor: Colors.teal.withOpacity(0.1),
            onLongPress: () {
              setState(() {
                selecionadas.contains(tabela[indice])
                    ? selecionadas.remove(tabela[indice])
                    : selecionadas.add(tabela[indice]);
              });
              print(tabela[indice].title);
            },
          );
        },
        padding: EdgeInsets.all(12),
        separatorBuilder: (_, __) => Divider(
          color: Colors.black54,
        ),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: addFavoritar(),
    );
  }
}
