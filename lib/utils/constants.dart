import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/app_str.dart';

String lottieURL = "asset/lottie/lottie1.json";

class AppImages {
  // splash logo
  static const String darkAppLogo = 'asset/splashLogo.png';
  static const String lightAppLogo = 'asset/splashLogo.png';

// onboarding images
  static const String onBoardingImage1 = 'asset/scooter.png';
  static const String onBoardingImage2 = 'asset/car.png';
  static const String onBoardingImage3 = 'asset/lorry.png';
}

emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppString.oopsMsg,
    subMsg: "You Must fill all fields!",
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppString.oopsMsg,
    subMsg: "You must edit the tasks then try to update it!",
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppString.oopsMsg,
    message:
        "There is no task to be delelted!\n Try adding some and then try to delete it!",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    message:
        "Do you really want to delete all tasks? You will not be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
