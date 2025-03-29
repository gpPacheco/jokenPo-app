import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);
  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  int _vitoriasUsuario = 0;
  int _vitoriasComputador = 0;
  Color _corResultado = Colors.grey;

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];
    print("Escolha do App: " + escolhaApp);
    print("Escolha do Usuário: " + escolhaUsuario);

    // Exibir na UI o resultado da escolha do APP
    switch (escolhaApp) {
      case "pedra":
        setState(() {
          _imagemApp = AssetImage("images/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          _imagemApp = AssetImage("images/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          _imagemApp = AssetImage("images/tesoura.png");
        });
        break;
    }

    // Lógica para ganhador e perdedor
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou :)";
        _vitoriasUsuario++;
        _corResultado = Colors.yellow;
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu :(";
        _vitoriasComputador++;
        _corResultado = Colors.red;
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente :/";
        _corResultado = Colors.blue;
      });
    }
  }

  // Método para reiniciar o placar
  void _reiniciarPlacar() {
    setState(() {
      _vitoriasUsuario = 0;
      _vitoriasComputador = 0;
      _resultadoFinal = "Boa sorte!!!";
      _imagemApp = AssetImage("images/padrao.png");
      _corResultado = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
        actions: [
          // Botão de reinício no AppBar
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reiniciarPlacar,
            tooltip: 'Reiniciar Placar',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Placar
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Você $_vitoriasUsuario x $_vitoriasComputador Computador',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          //1 - Escolha do App
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          //2 - Imagem de escolha do app
          Image(image: _imagemApp),

          //3 - Escolha uma opção abaixo:
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () => _opcaoSelecionada("pedra"),
                  child: Column(children: [
                    Image(
                      image: AssetImage('images/pedra.png'),
                      height: 100,
                    ),
                    Text(
                      "Pedra",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ])),
              GestureDetector(
                  onTap: () => _opcaoSelecionada("papel"),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/papel.png'),
                        height: 100,
                      ),
                      Text(
                        "Papel",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              GestureDetector(
                  onTap: () => _opcaoSelecionada("tesoura"),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/tesoura.png'),
                        height: 100,
                      ),
                      Text(
                        "Tesoura",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _resultadoFinal,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _corResultado),
            ),
          ),

          ElevatedButton(
            onPressed: _reiniciarPlacar,
            child: Text('Reiniciar Placar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
