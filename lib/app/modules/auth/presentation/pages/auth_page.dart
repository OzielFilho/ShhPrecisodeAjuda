import 'package:app/app/core/presentation/widgets/buttons_design.dart';
import 'package:app/app/core/utils/colors/colors_utils.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                ColorUtils.primaryColor.withOpacity(.5),
                BlendMode.darken,
              ),
              image: AssetImage('assets/images/woman.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: ColorUtils.primaryColor,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Shh! Preciso de Ajuda'),
                    Text('Seu Aplicativo de proteção pessoal'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonsDesign.buttonDefault(
                        text: 'Entrar no App', action: () {}),
                    ButtonsDesign.buttonDefault(
                        text: 'Cadastrar Conta', action: () {}),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}