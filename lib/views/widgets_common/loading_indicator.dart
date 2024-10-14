import 'package:pshop_aplikasi/consts/consts.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(bluecolor),
  );
}