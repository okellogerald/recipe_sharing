import 'package:firebase_core/firebase_core.dart';
import 'package:recipes_sharing/UI/BeforeRegistration/firstpage.dart';
import 'package:recipes_sharing/source.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final authBloc = AuthBloc();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
      create: (context) => Themes(),
        child: FirstPage(),
      ),
    );
  }
}
