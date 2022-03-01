import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:si_app/src/models/exceptions/firebase_auth_exception.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';
import 'package:si_app/src/utils/custom_toast.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository})
      : super(UninitializedAuthenticationState()) {
    on<CheckUserStatusEvent>((event, emit) async {
      try {
        final isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          final email = userRepository.getUser();

          emit(AuthenticatedState(email!));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<RegisterEvent>((event, emit) async {
      try {
        final UserCredential userCredential = await userRepository.signUp(
            email: event.email, password: event.password);

        emit(AuthenticatedState(userCredential.user!.email!));
      } on FirebaseAuthException catch (e) {
        final AuthException authException = AuthException(code: e.code);
        emit(UnauthenticatedState());
        CustomToast.showErrorToast(authException.message);
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignInEvent>((event, emit) async {
      try {
        final UserCredential userCredential = await userRepository
            .signInWithCredentials(event.email, event.password);

        emit(AuthenticatedState(userCredential.user!.email!));
      } on FirebaseAuthException catch (e) {
        emit(UnauthenticatedState());
        final AuthException authException = AuthException(code: e.code);
        CustomToast.showErrorToast(authException.message);
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      await userRepository.signOut();

      emit(UnauthenticatedState());
    });
  }
}
