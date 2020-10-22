import 'package:flutter/material.dart';
import 'package:teste/components/progress.dart';
import 'package:teste/database/dao/treinos_dao.dart';
import 'package:teste/model/treino.dart';
import 'package:teste/utils/date-util.dart';

class HistoricoScreen extends StatelessWidget {
  final TreinoDAO _dao = TreinoDAO();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Treino>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              debugPrint('None');
              break;
            case ConnectionState.waiting:
              debugPrint('Waiting');
              return Progress(
                message: 'Waiting',
              );
              break;
            case ConnectionState.active:
              // Normalmente usado em streams
              debugPrint('Active');
              break;
            case ConnectionState.done:
              debugPrint('Done');
              final List<Treino> lista = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Treino treino = lista[index];
                  return _TreinoItem(
                    treino,
                    onClick: () {
                      print('Clicou na linha ' + treino.toString());
                    },
                  );
                },
                itemCount: lista.length,
              );
              break;
          }
          return Text('Unknown error');
          // return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}

class _TreinoItem extends StatelessWidget {
  final Treino treino;
  final Function onClick;

  _TreinoItem(this.treino, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: onClick,
      title: Text(
        DateUtil.printDuration(new Duration(seconds: treino.time)),
        style: TextStyle(fontSize: 24.0),
      ),
      subtitle: Text(
        DateUtil.formatPadraoDate(treino.data),
        style: TextStyle(fontSize: 16.0),
      ),
    ));
  }
}
