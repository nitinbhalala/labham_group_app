import 'package:flutter/material.dart';



class AppSnack {
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
      GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

    var scaffold = ScaffoldMessenger.of(navigationKey.currentContext!);

    final snack = SnackBar(
      elevation: 0,
      duration: duration,
      backgroundColor: Colors.grey.shade200,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      message,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
    scaffold.showSnackBar(snack);
  }
}
