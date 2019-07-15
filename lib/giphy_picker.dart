library giphy_picker;

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:giphy_picker/src/widgets/giphy_context.dart';
import 'package:giphy_picker/src/widgets/giphy_search_page.dart';

export 'package:giphy_picker/src/widgets/giphy_image.dart';

typedef ErrorListener = void Function(dynamic error);

/// Provides Giphy picker functionality.
class GiphyPicker {
  /// Renders a full screen modal dialog for searching, and selecting a Giphy image.
  static Future<GiphyGif> pickGif({
    @required BuildContext context,
    @required String apiKey,
    String rating = GiphyRating.g,
    String lang = GiphyLanguage.english,
    Widget title,
    ErrorListener onError,
    @required String alertDialogTitle,
    @required String alertDialogClose,
    @required String alertDialogMessage,
  }) async {
    GiphyGif result;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GiphyContext(
            child: GiphySearchPage(),
            apiKey: apiKey,
            rating: rating,
            language: lang,
            onError: onError ??
                (error) => _showErrorDialog(
                      context,
                      error,
                      alertDialogTitle,
                      alertDialogClose,
                      alertDialogMessage,
                    ),
            onSelected: (gif) {
              result = gif;

              Navigator.pop(context);
              Navigator.pop(context);
            }),
        fullscreenDialog: true,
      ),
    );

    return result;
  }

  static void _showErrorDialog(
    BuildContext context,
    GiphyClientError error,
    String alertDialogTitle,
    String alertDialogClose,
    String alertDialogMessage,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alertDialogTitle),
          content: Text(
            alertDialogMessage + ' ${json.decode(error.exception)["message"]}',
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12, width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(alertDialogClose),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
