import 'package:flutter/material.dart';
import 'package:teste/screens/treino.dart';
import 'package:teste/screens/historico.dart';
import 'package:teste/screens/configuracoes.dart';

class MainBar extends StatefulWidget {
  final Function widgetScreen;

  MainBar(this.widgetScreen);

  final List<Widget> widgetOptions = <Widget>[
    HistoricoScreen(),
    TreinoScreen(),
    ConfiguracoesScreen(),
  ];

  @override
  _MainBarState createState() {
    return _MainBarState();
  }
}

class _MainBarState extends State<MainBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          label: 'Treino',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onTapped,
    );
  }

  void _onTapped(int index) {
    setState(() {
      this._selectedIndex = index;
      this.widget.widgetScreen(widget.widgetOptions.elementAt(_selectedIndex));
    });
  }
}
