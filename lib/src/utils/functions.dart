import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class FuncionesUtils {
  int backgroundColor = 0x42000000;
  int seconds = 2;
  bool clickClose = true;
  bool allowClick = true;
  bool crossPage = true;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  Widget validaOk(AsyncSnapshot snaps) {
    if (snaps.hasError) {
      return const Padding(
        padding: EdgeInsetsDirectional.only(end: 12.0),
        child: Icon(Icons.report_problem_rounded,
            color: Colors.redAccent), // myIcon is a 48px-wide widget.
      );
    } else if (snaps.hasData) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 12.0),
        child: Icon(Icons.check,
            color: Colors.green[700]), // myIcon is a 48px-wide widget.
      );
    } else {
      return const Padding(
        padding: EdgeInsetsDirectional.only(end: 12.0),
        child:
            Icon(Icons.remove_circle_outlined), // myIcon is a 48px-wide widget.
      );
    }
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String selectDateNow(BuildContext context) {
    String fecha = '';
    String month;
    String day;

    DateTime date = DateTime.now();
    month = date.month.toString();
    day = date.day.toString();

    if (month.length == 1) month = '0$month';
    if (day.length == 1) day = '0$day';

    fecha = '$day/$month/${date.year.toString()}';

    return fecha;
  }

  showNotifyLoading (Function()? functionClose) {
  return BotToast.showLoading(
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        backButtonBehavior: backButtonBehavior,
        animationDuration: Duration(milliseconds: animationMilliseconds),
        animationReverseDuration:
            Duration(milliseconds: animationReverseMilliseconds),
        duration: Duration(
          seconds: seconds,
        ),
        backgroundColor: Color(backgroundColor),
        onClose: functionClose);
  }
}
