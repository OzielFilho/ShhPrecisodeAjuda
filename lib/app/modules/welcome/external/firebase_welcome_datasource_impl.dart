import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';
import 'package:app/app/modules/welcome/infra/datasources/welcome_datasource.dart';
import 'package:app/app/modules/welcome/infra/models/update_user_model.dart';

import '../../../core/utils/constants/encrypt_data.dart';

class FirebaseWelcomeDatasourceImpl implements WelcomeDatasource {
  final FirestoreService store;
  final FirebaseAuthService auth;
  FirebaseWelcomeDatasourceImpl(this.store, this.auth);

  @override
  Future<void> updateUserCreate(UpdateUserWelcomeModel user) async {
    final token = await auth.getToken();
    final document = await store.getDocument('users', token);

    final userAuth = AuthResultModel.fromDocument(document);
    if (userAuth.phone.isEmpty) {
      final phoneCrypt = EncryptData().encrypty(user.phone).base16;
      if (!await store.existDocument('contacts', phoneCrypt)) {
        await store.createDocument('contacts', phoneCrypt, {'tokenId': token});
      }
    }

    user.name = userAuth.name;
    user.email = userAuth.email;

    await store.updateDocument('users', token, user.toMap());
  }

  @override
  Future<AuthResultModel> getUserCreate() async {
    final token = await auth.getToken();
    final document = await store.getDocument('users', token);

    final userAuth = AuthResultModel.fromDocument(document);
    return userAuth;
  }
}