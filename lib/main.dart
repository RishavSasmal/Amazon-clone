import 'package:backend_prac/constants/global_variable.dart';
import 'package:backend_prac/feature/admin/screen/admin_screen.dart';
import 'package:backend_prac/feature/auth/screens/auth_screen.dart';
import 'package:backend_prac/feature/auth/services/auth_service.dart';
import 'package:backend_prac/feature/home/screens/home_screen.dart';
import 'package:backend_prac/providers/user_provider.dart';
import 'package:backend_prac/router.dart';
import 'package:backend_prac/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          colorScheme:
              ColorScheme.light(primary: GlobalVariables.secondaryColor)),
      onGenerateRoute: (settings) => generateRouteTry(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
