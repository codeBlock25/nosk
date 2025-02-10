part of 'effects.dart';

enum ToastSnackBarType { danger, warning, info, notify, success, norm }

Color getTextColor(BuildContext context, ToastSnackBarType type) {
  switch (type) {
    case ToastSnackBarType.danger:
      return Colors.white;
    case ToastSnackBarType.success:
      return Colors.white;
    case ToastSnackBarType.info:
      return Colors.white;
    case ToastSnackBarType.warning:
      return Colors.brown[800]!;
    case ToastSnackBarType.notify:
      return Colors.white;
    case ToastSnackBarType.norm:
      return !context.isDarkMode ? Colors.grey[900]! : Colors.white;
  }
}

Color getBgColor(BuildContext context, ToastSnackBarType type) {
  switch (type) {
    case ToastSnackBarType.danger:
      return Colors.red[400]!;
    case ToastSnackBarType.success:
      return !context.isDarkMode ? Colors.green[400]! : Colors.green[600]!;
    case ToastSnackBarType.info:
      return !context.isDarkMode ? Colors.blue : Colors.blue[700]!;
    case ToastSnackBarType.warning:
      return context.isDarkMode ? Colors.yellow[700]! : Colors.yellow[800]!;
    case ToastSnackBarType.notify:
      return context.isDarkMode ? Colors.grey[600]! : Colors.grey[800]!;
    case ToastSnackBarType.norm:
      return context.isDarkMode ? Colors.grey[900]! : Colors.white;
  }
}

void _toastSnackBar(
  BuildContext context, {
  required String toastMessage,
  required ToastSnackBarType type,
  Duration? duration,
  void Function()? onClosed,
  bool freshStack = false,
  SnackBarAction? action,
  Key? key,
}) {
  if (freshStack) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
  final SnackBar snackBar = SnackBar(
    key: key,
    elevation: 5,
    action: action,
    content: Text(
      toastMessage,
    ),
    onVisible: () {
      if (onClosed?.call != null) {
        (duration ?? 3.seconds).delay(onClosed!.call);
      }
    },
    backgroundColor: getBgColor(context, type),
    duration: duration ?? const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

extension NotificationExtension on BuildContext {
  void toast({
    required String toastMessage,
    required ToastSnackBarType type,
    void Function()? onClosed,
    Duration? duration,
    SnackBarAction? action,
    Key? key,
  }) =>
      _toastSnackBar(
        this,
        toastMessage: toastMessage,
        type: type,
        onClosed: onClosed,
        action: action,
      );

  SnackBar toastGen({
    required String toastMessage,
    required ToastSnackBarType type,
    Duration? duration,
    SnackBarAction? action,
    Key? key,
  }) =>
      SnackBar(
        key: key,
        elevation: 4.cl(4, 10),
        content: Text(
          toastMessage,
          style: Theme.of(this)
              .textTheme
              .bodyMedium
              ?.copyWith(color: getTextColor(this, type)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.cl(10, 22)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.cl(10, 30)).copyWith(
          bottom: 10.cl(10, 20),
        ),
        backgroundColor: getBgColor(this, type),
        duration: duration ?? const Duration(seconds: 3),
        dismissDirection: DismissDirection.vertical,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
      );
}
