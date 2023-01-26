import 'dart:io';

import '../../../core/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/presentation/controller/app_state.dart';
import '../../../core/presentation/widgets/buttons_design.dart';
import '../../../core/presentation/widgets/form_desing.dart';
import '../../../core/presentation/widgets/loading_desing.dart';
import '../../../core/theme/theme_app.dart';
import '../../../core/utils/colors/colors_utils.dart';
import '../../../core/utils/widgets_utils.dart';
import '../create_account_with_email_and_password/models/user_create_account_model.dart';
import '../create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter.dart';
import '../create_account_with_email_and_password/presenter/create_account_with_email_and_password_presenter_provider.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _emailControllerNew = TextEditingController();
  final _nameControllerNew = TextEditingController();
  final _confirmPasswordControllerNew = TextEditingController();
  final _phoneControllerNew = TextEditingController();
  final _passwordControllerNew = TextEditingController();
  File? _file;

  bool _visibilityConfirmPassword = true;
  bool _visibilityPassword = true;
  var _maskFormatter = new MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  late CreateAccountWithEmailAndPasswordPresenterProvider
      _providerCreateAccount;
  @override
  void initState() {
    super.initState();
    _providerCreateAccount =
        CreateAccountWithEmailAndPasswordPresenter(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Modular.to.pop(),
                icon: Icon(Icons.arrow_back_ios_new_outlined))),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Crie sua conta',
                  style: ThemeApp.theme.textTheme.headline1),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Insira suas credenciais',
                  style: ThemeApp.theme.textTheme.subtitle1),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50.0),
              onTap: () {
                WidgetUtils.showOkDialog(
                    context,
                    'Escolha uma Imagem',
                    'Escolha uma imagem para o seu perfil',
                    'Fechar',
                    () => Modular.to.pop(),
                    content: Column(
                      children: [
                        InkWell(
                          child: Text(
                            '1. Câmera',
                            style: ThemeApp.theme.textTheme.headline2,
                          ),
                          onTap: () async {
                            final file = await ImageServiceImpl(ImagePicker())
                                .getImage();
                            _file = file;
                            setState(() {});
                            Modular.to.pop();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Text(
                            '2. Galeria',
                            style: ThemeApp.theme.textTheme.headline2,
                          ),
                          onTap: () async {
                            final file = await ImageServiceImpl(ImagePicker())
                                .getImage(isCamera: false);
                            _file = file;
                            setState(() {});
                            Modular.to.pop();
                          },
                        ),
                      ],
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    image: _file != null
                        ? DecorationImage(
                            image: FileImage(_file!), fit: BoxFit.cover)
                        : null,
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorUtils.whiteColor)),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 40,
                  color: _file != null
                      ? ColorUtils.whiteColor.withOpacity(.5)
                      : ColorUtils.whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insira Seu Nome',
                        style: ThemeApp.theme.textTheme.subtitle1),
                  ),
                  FormsDesign(
                    prefixIcon: null,
                    suffixIcon: null,
                    title: 'Nome',
                    visibility: false,
                    controller: _nameControllerNew,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insira Seu Email',
                        style: ThemeApp.theme.textTheme.subtitle1),
                  ),
                  FormsDesign(
                    prefixIcon: null,
                    suffixIcon: null,
                    title: 'Email',
                    visibility: false,
                    controller: _emailControllerNew,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insira Sua Senha',
                        style: ThemeApp.theme.textTheme.subtitle1),
                  ),
                  FormsDesign(
                    prefixIcon: null,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _visibilityPassword = !_visibilityPassword;
                          });
                        },
                        icon: Icon(
                          _visibilityPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: ColorUtils.whiteColor,
                        )),
                    title: 'Senha',
                    visibility: _visibilityPassword,
                    controller: _passwordControllerNew,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Repita a Senha',
                        style: ThemeApp.theme.textTheme.subtitle1),
                  ),
                  FormsDesign(
                    prefixIcon: null,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _visibilityConfirmPassword =
                                !_visibilityConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _visibilityConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: ColorUtils.whiteColor,
                        )),
                    title: 'Confirme a Senha',
                    visibility: _visibilityConfirmPassword,
                    controller: _confirmPasswordControllerNew,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insira Seu Telefone',
                        style: ThemeApp.theme.textTheme.subtitle1),
                  ),
                  FormsDesign(
                    type: TextInputType.number,
                    prefixIcon: null,
                    suffixIcon: null,
                    formatter: [_maskFormatter],
                    title: '(xx) xxxxx.xxxx',
                    visibility: false,
                    controller: _phoneControllerNew,
                  ),
                  StreamBuilder(
                    stream: _providerCreateAccount.outCreateAccountController,
                    builder: (context, snapshot) {
                      if (snapshot.data is ProcessingState) {
                        return LoadingDesign();
                      }
                      if (snapshot.hasData && snapshot.data is String) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: Duration(seconds: 5),
                              curve: Curves.ease,
                              child: Text(
                                'Conta Criada com Sucesso! Clique no botão de voltar para acessar sua conta.',
                                style: ThemeApp.theme.textTheme.subtitle1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ButtonDesign(
                            text: 'Criar Conta',
                            action: () async {
                              FocusScope.of(context).unfocus();

                              await _providerCreateAccount.createAccount(
                                  UserCreateAccountModel(
                                    _nameControllerNew.text,
                                    _emailControllerNew.text,
                                    _passwordControllerNew.text,
                                    '',
                                    _confirmPasswordControllerNew.text,
                                    [],
                                    _phoneControllerNew.text,
                                    false,
                                  ),
                                  _file);
                            }),
                      );
                    },
                  ),
                ],
              ),
            )
          ]),
        )));
  }
}