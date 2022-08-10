import 'package:app/app/core/presentation/controller/app_state.dart';
import 'package:app/app/modules/home/presentation/controllers/events/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../core/theme/theme_app.dart';
import '../controllers/bloc/get_list_contacts_with_message_chat_bloc.dart';

class ChatConversationHomePage extends StatefulWidget {
  final String tokenId;
  ChatConversationHomePage({Key? key, required this.tokenId}) : super(key: key);

  @override
  State<ChatConversationHomePage> createState() =>
      _ChatConversationHomePageState();
}

class _ChatConversationHomePageState extends State<ChatConversationHomePage> {
  final _blocListContactsWithMessage =
      Modular.get<GetListContactsWithMessageChatBloc>();
  @override
  void initState() {
    _blocListContactsWithMessage
        .add(GetListContactsWithChatEvent(tokenId: widget.tokenId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetListContactsWithMessageChatBloc, AppState>(
        bloc: _blocListContactsWithMessage,
        builder: (context, state) {
          if (state is ProcessingState) {
            return Center(child: LoadingDesign());
          }
          if (state is ErrorState) {
            return AnimatedContainer(
              duration: Duration(seconds: 5),
              alignment: Alignment.center,
              curve: Curves.ease,
              child: Text(
                state.message!,
                style: ThemeApp.theme.textTheme.subtitle1,
              ),
            );
          }
          if (state is SuccessGetListContactWithMessageChatState) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: _blocListContactsWithMessage.listContacts!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(),
                    subtitle: Text(_blocListContactsWithMessage
                        .listContacts![index].messages.last.text),
                    title: Text(
                      '${_blocListContactsWithMessage.listContacts![index].name}',
                      style: ThemeApp.theme.textTheme.headline2,
                    )),
              ),
            );
          }
          return Center(child: LoadingDesign());
        },
      ),
    );
  }
}