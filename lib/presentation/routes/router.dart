import 'package:auto_route/annotations.dart';
import 'package:ddd_example/presentation/sign_in/sign_in_page.dart';
import 'package:ddd_example/presentation/splash/splash_page.dart';

@MaterialAutoRouter(replaceInRouteName: "Page,Route",routes: [
  AutoRoute(page: SplashPage,initial: true ),
  AutoRoute(page: SignInPage, ),
])

class $AppRouter{
}