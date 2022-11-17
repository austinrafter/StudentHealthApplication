import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _sleepArticleUrl = Uri.parse(
    'https://healthysleep.med.harvard.edu/healthy/matters/benefits-of-sleep/learning-memory');

final Uri _sleepDownloadUrl =
    Uri.parse('https://github.com/austinrafter/StudentHealthApplication/blob/sleep/apk/app-arm64-v8a-release.apk');

class SleepPage extends StatelessWidget {
  const SleepPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textSpan = TextSpan(
      text: "Launch Sleep Optimizer",
    );
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Why is sleep so important?\n\n\n",
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextSpan(
                          text:
                              "- Improving our ability to learn new information and form memories\n\n",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        TextSpan(
                          text: "- Restoring neural connections\n\n",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        TextSpan(
                          text:
                              "- Assisting in optimal emotional control, decision making, and social interaction\n",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        WidgetSpan(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _launchUrl,
                                child: Text(
                                  "Learn more",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              const Icon(
                                Icons.open_in_browser,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 80,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: _launchSleep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 35, 148, 177),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Launch Sleep Optimizer "),
                            Icon(Icons.launch),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(255, 14, 123, 224),
    Color.fromARGB(255, 8, 117, 206),
    Color.fromARGB(255, 21, 67, 138),
    Color.fromARGB(255, 8, 42, 94),
    Color.fromARGB(255, 3, 24, 56),
  ],
  tileMode: TileMode.clamp,
);

Future<void> _launchUrl() async {
  if (!await launchUrl(_sleepArticleUrl)) {
    throw 'Could not launch $_sleepArticleUrl';
  }
}

Future<void> _launchSleep() async {
  const String packageName = 'com.example.sleep_optimizer';
  // const String packageName = 'com.google.android.youtube';

  final bool isInstalled = await LaunchApp.isAppInstalled(
    androidPackageName: packageName,
  );

  print('$packageName is ${isInstalled ? '' : 'not '}installed!');

  if (!isInstalled) {
    if (!await launchUrl(_sleepDownloadUrl)) {
      throw 'Could not launch $_sleepDownloadUrl';
    }
  } else {
    await LaunchApp.openApp(
      // androidPackageName: 'com.example.sleep_optimizer',
      androidPackageName: packageName,
      openStore: false,
    );
  }
}
