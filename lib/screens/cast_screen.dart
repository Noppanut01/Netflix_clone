import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/custom_round_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CastScreen extends StatelessWidget {
  const CastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment(1, -1),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset("assets/images/device.png"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Devices Found",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Make sure your smart TV, streaming device, and iPhone or iPad are all on the same WiFi network. If you need help, please visit our Netflix Help Center.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _launchURL(
                    "https://help.netflix.com/en/node/133390#:~:text=Turn%20off%20your%20device%2C%20then,Try%20Netflix%20again.",
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Go to Help Center",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomRoundIconButton(
              icon: Icons.close,
              ontab: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      // mode: LaunchMode.externalApplication, // Ensures it opens in Safari
    );
  } else {
    debugPrint("Could not launch $url");
  }
}
