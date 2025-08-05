import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:shopping_app/domain/data_models/cart_item_model.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/main_screen.dart';
import 'package:shopping_app/shared/shared.dart';
import 'di/di.dart';
import 'providers/splash_provider.dart';
import 'providers/localization_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocal.ins.initStorage();

  await Hive.initFlutter();
  // Open cart box
  await Hive.openBox("CART_BOX");
  // await Hive.openBox<CartItemModel>('CART_BOX');
  await DI.initDI();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlobalLoaderOverlay(
      duration: Durations.medium4,
      reverseDuration: Durations.medium4,
      overlayColor: Colors.grey.withValues(alpha: 0.8),
      overlayWidgetBuilder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
      child: MaterialApp.router(
        title: 'Flutter Demo',
        themeMode: ref.watch(themeProvider),
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLocalization.supportedLocales,
        locale: ref.watch(localizationProvider).locale,
        localizationsDelegates: const [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
  }
}

class TopScreen extends ConsumerWidget {
  static const String routeName = "top_screen";
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(splashProvider)
        .when(
          data: (value) => value == UserState.home
              ?
                // const SignInScreen() : const SplashScreen(),
                const MainScreen()
              : const MainScreen(),
          error: (_, __) => const SplashScreen(),
          loading: () => const SplashScreen(),
        );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.splash, height: 200),
              40.spaceY,
              Text(
                "Welcome to Shop",
                style: AppTextstyle.headingTextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
                textAlign: TextAlign.center,
              ),
              16.spaceY,
              Text(
                "one-stop for online shopping.",
                style: AppTextstyle.bodyTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
