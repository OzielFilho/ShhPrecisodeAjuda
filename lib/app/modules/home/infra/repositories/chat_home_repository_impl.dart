import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/network_service.dart';
import '../../domain/entities/current_position.dart';
import '../../domain/entities/details_contact_chat.dart';
import '../../domain/entities/message_chat.dart';
import '../../domain/repositories/chat_home_repository.dart';
import '../datasources/chat_home_datasource.dart';
import '../models/message_chat_model.dart';

class ChatHomeRepositoryImpl implements ChatHomeRepository {
  final ChatHomeDatasource datasource;
  final NetworkService _networkService;
  ChatHomeRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, List<DetailsContactChat>>>
      getListDetailsContactFromPhoneChat({List<String>? phones}) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result =
          await datasource.getListDetailsContactFromPhoneChat(phones: phones);
      return right(result);
    } on ChatHomeException {
      return left(GetDetailsContactFromPhoneFailure());
    } catch (e) {
      return left(GetDetailsContactFromPhoneFailure());
    }
  }

  @override
  Stream<List> getListContactsMessage(String tokenId) {
    return datasource.getListContactsMessage(tokenId);
  }

  @override
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String? tokenIdUserActual, String? tokenIdContact}) {
    return datasource.getListMessageChatUser(
        tokenIdContact: tokenIdContact!, tokenIdUserActual: tokenIdUserActual!);
  }

  @override
  Future<Either<Failure, void>> sendMessageToUser(
      {MessageChat? message,
      String? tokenIdUser,
      String? tokenIdContact,
      String? name,
      String? photo}) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.sendMessageToUser(
          message: message,
          tokenIdContact: tokenIdContact!,
          tokenIdUser: tokenIdUser!,
          photo: photo!,
          name: name!);
      return right(result);
    } on ChatHomeException {
      return left(SendMessageUserFailure());
    } catch (e) {
      return left(SendMessageUserFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendMessageEmergenceWithChat(
      {List<String>? phones,
      String? tokenId,
      CurrentPosition? position}) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.sendMessageEmergenceWithChat(
          tokenId: tokenId!, phones: phones!, position: position!);
      return right(result);
    } on ChatHomeException {
      return left(SendMessageUserFailure());
    } catch (e) {
      return left(SendMessageUserFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addNewContacts(
      List<String> contacts, String tokenId) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      return right(await datasource.addNewContacts(contacts, tokenId));
    } on ChatHomeException {
      return left(AddNewContactsFailure());
    } catch (e) {
      return left(AddNewContactsFailure());
    }
  }
}
