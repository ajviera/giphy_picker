import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giphy_picker/src/widgets/giphy_search_view.dart';

class GiphySearchPage extends StatelessWidget {
  final Widget title;
  final String searchInputMessage;

  const GiphySearchPage({
    this.title,
    @required this.searchInputMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => _closeKeyboard(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                child: GiphySearchView(searchInputMessage: searchInputMessage),
              ),
            ],
          ),
          bottom: false,
        ),
      ),
    );
  }

  void _closeKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
