import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:si_app/src/models/exceptions/firebase_auth_exception.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository}) : super(UninitializedAuthenticationState()) {
    on<CheckUserStatusEvent>((event, emit) async {
      try {
        final isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn && userRepository.checkIfVerified()) {
          final email = userRepository.getCurrentUserEmail();

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
        await userRepository.signUp(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
          image: event.image,
        );

        await userRepository.sendVerificationMail();
        emit(NotVerifiedEmailState());
      } on FirebaseAuthException catch (e) {
        final AuthException authException = AuthException(code: e.code);
        emit(UnauthenticatedState());

        emit(AuthenticationErrorState(authException.message));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignInEvent>((event, emit) async {
      try {
        final UserCredential userCredential = await userRepository.signInWithCredentials(event.email, event.password);

        if (userCredential.user!.emailVerified) {
          emit(AuthenticatedState(userCredential.user!.email!));
        } else {
          emit(NotVerifiedEmailState());
        }
      } on FirebaseAuthException catch (e) {
        final AuthException authException = AuthException(code: e.code);
        emit(UnauthenticatedState());

        emit(AuthenticationErrorState(authException.message));
      } catch (e) {
        emit(UnauthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      await userRepository.signOut();

      emit(UnauthenticatedState());
    });

    on<SwitchAuthFormEvent>((event, emit) {
      emit(UnauthenticatedState());
    });

    on<SendVerificationMailEvent>((event, emit) async {
      await userRepository.sendVerificationMail();
    });

    on<GoToHomePageEvent>((event, emit) async {
      emit(AuthenticatedState(userRepository.currentUser!.email));
    });

    on<ResetPasswordEvent>((event, emit) async {
      await userRepository.resetPassword();
      emit(PasswordResetMailSentState());
      emit(AuthenticatedState(userRepository.currentUser!.email));
    });
  }
}
