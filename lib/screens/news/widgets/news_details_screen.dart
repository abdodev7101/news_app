import 'package:flutter/material.dart';
import 'package:news_app/utils/const/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/utils.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Utils.isDark(context)
                ? AppColors.white
                : AppColors.black,
          ),
        ),
        title: Text('Artical Details',style: AppStyles.bold16(context),),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: WebViewController()..loadRequest(Uri.parse(url))),
    );
  }
}
