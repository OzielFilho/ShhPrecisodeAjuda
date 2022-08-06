import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:app/app/modules/welcome/domain/usecases/get_user_create.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class WelcomeRepositoryImpl extends Mock implements WelcomeRepository {}

void main() {
  GetUserCreate? usecase;
  WelcomeRepository? repository;
  AuthResult? authResult;
  setUp(() {
    repository = WelcomeRepositoryImpl();
    usecase = GetUserCreate(repository!);
    authResult = AuthResult(
        'oziel@hotmail.com', 'afafafafaf', false, '2545gsgsgs85', 'Oziel');
  });

  test('Should return AuthResult if usecase returns success', () async {
    when(() => repository!.getUserCreate())
        .thenAnswer((_) async => right(authResult!));

    final result = await usecase!(NoParams());

    expect(result, right(authResult));
    verify(() => repository!.getUserCreate());
    verifyNoMoreInteractions(repository);
  });
}