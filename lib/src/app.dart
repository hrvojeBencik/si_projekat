import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/constants/routes.dart';
import 'package:si_app/src/pages/home_page.dart';
import 'package:si_app/src/pages/landing_page/landing_page.dart';
import 'package:si_app/src/pages/settings_page.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';
import 'package:si_app/src/services/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => ApiService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userRepository: context.read<UserRepository>(),
            )..add(CheckUserStatusEvent()),
          ),
          BlocProvider<PlotsBloc>(
            create: (context) => PlotsBloc(
              context.read<ApiService>(),
            ),
          ),
        ],
        child: AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return OKToast(
              child: MaterialApp(
                restorationScopeId: 'app',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('sr', ''),
                ],
                locale: const Locale.fromSubtags(languageCode: 'sr'),
                onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
                theme: ThemeData(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
                // darkTheme: ThemeData.dark(),
                themeMode: settingsController.themeMode,
                home: BlocBuilder(
                  bloc: context.read<AuthenticationBloc>(),
                  builder: (context, state) {
                    if (state is UnauthenticatedState) {
                      return const LandingPage();
                    }

                    if (state is AuthenticatedState) {
                      return const HomePage();
                    }

                    if (state is UninitializedAuthenticationState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return const LandingPage();
                  },
                ),
                initialRoute: '/',
                onGenerateRoute: (RouteSettings routeSettings) {
                  return MaterialPageRoute<void>(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      switch (routeSettings.name) {
                        case Routes.homeScreen:
                          return const HomePage();
                        case Routes.settingsScreen:
                          return const SettingsPage();
                        default:
                          return const HomePage();
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
