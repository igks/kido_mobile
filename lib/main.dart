import 'package:doa_kidung_flutter/bloc/blocs.dart';
import 'package:doa_kidung_flutter/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(KidungDoa());
}

class KidungDoa extends StatelessWidget {
  const KidungDoa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PageBloc(),
        child: MaterialApp(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          home: AppNavigator(),
        ));
  }
}
