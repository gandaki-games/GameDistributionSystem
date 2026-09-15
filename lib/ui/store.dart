import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'cart.dart';

class Store extends StatefulWidget {
  Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final List<String> imageUrls = [
    'assets/Spaceship Shooter.png',
    'assets/Wormhole Warfare.png',
    'assets/game (3).png',
    'assets/game (4).png',
    'assets/game (5).png',
    'assets/game (6).png',
    'assets/game (7).png',
    'assets/game (8).png',
    'assets/game (9).png',
  ];

  final List<String> downloadLinks = [
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eo3T__dLzyhEm1NfSVx1FTMBZBGnEZPvT816FlzZA_tD3A?e=aVKLUY',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
    'https://universityofbedfordshire-my.sharepoint.com/:f:/g/personal/bigyan_shrestha_study_beds_ac_uk/Eubs198C2mdAul4m0dplNzUBrwcf99W-PXUVouS0yyf1nA?e=Qd4VSD',
  ];

  final List<double?> prices = [
    599, // Price for image 1
    null, // Price for image 2
    null, // Image 3 is free
    799, // Price for image 4
    null, // Image 5 is free
    459, // Price for image 6
    999, // Price for image 7
    399, // Price for image 8
    649, // Price for image 9
  ];

  bool _loading = false;

// Modify the boolean lists accordingly

  @override
  Widget build(BuildContext context) {
    // Initialize showDownloadButton and showBuyButton here
    List<bool> showDownloadButton =
        List.generate(imageUrls.length, (index) => prices[index] == null);
    List<bool> showBuyButton =
        List.generate(imageUrls.length, (index) => prices[index] != null);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(imageUrls.length, (index) {
            return Builder(
              builder: (context) => buildImageItem(
                context: context,
                imageUrl: imageUrls[index],
                downloadLink: downloadLinks[index],
                showDownloadButton: showDownloadButton[index],
                showBuyButton: showBuyButton[index],
                price: prices[index],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildImageItem({
    required BuildContext context,
    required String imageUrl,
    required String downloadLink,
    required bool showDownloadButton,
    required bool showBuyButton,
    double? price,
  }) {
    String imageName = imageUrl.split('/').last.split('.').first;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // You can add a specific action for tapping the image if needed
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    imageUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    imageName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    price == null ? 'Free' : 'Rs. $price.',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showDownloadButton)
            TextButton(
              onPressed: () {
                _launchUrl(downloadLink);
              },
              child: const Text(
                'Download',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.orange,
                ),
              ),
            ),
          if (showBuyButton)
            TextButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      // Navigate to the cart page when the "Buy" button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            selectedImageUrls: [imageUrl],
                            selectedDownloadLinks: [downloadLink],
                            selectedPrices: [price],
                            selectedImageNames: imageName,
                          ),
                        ),
                      );
                      setState(() {
                        _loading = false;
                      });
                    },
              child: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    )
                  : const Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.orange,
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
