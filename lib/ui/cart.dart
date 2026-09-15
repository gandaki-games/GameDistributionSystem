import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';

class CartPage extends StatefulWidget {
  final List<String> selectedImageUrls;
  final List<String> selectedDownloadLinks;
  final List<double?> selectedPrices;
  final String selectedImageNames;

  const CartPage({
    Key? key,
    required this.selectedImageUrls,
    required this.selectedDownloadLinks,
    required this.selectedPrices,
    required this.selectedImageNames,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Move controllers and state variables into the State class
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  
  PaymentInitiationResponseModel? initiationModel;

  @override
  void dispose() {
    // Always dispose your controllers to avoid memory leaks
    phoneController.dispose();
    pinCodeController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // Function to initiate payment
  Future<void> initiatePayment() async {
    final service = KhaltiService(client: KhaltiHttpClient());

    // Calculate total or item amount safely in Paisa (Khalti standard)
    final double rawPrice = widget.selectedPrices.isNotEmpty ? (widget.selectedPrices.first ?? 0.0) : 0.0;
    final int amountInPaisa = (rawPrice * 100).toInt();

    try {
      final response = await service.initiatePayment(
        request: PaymentInitiationRequestModel(
          amount: amountInPaisa,
          mobile: phoneController.text,
          productIdentity: 'mac-mini',
          productName: widget.selectedImageNames,
          transactionPin: pinCodeController.text,
          productUrl: 'Test',
          additionalData: {
            'Test': 'Success',
          },
        ),
      );

      // Safely update the widget state
      setState(() {
        initiationModel = response;
      });

      print('Initiation Token: ${initiationModel?.token}');
    } catch (e) {
      print('Error initiating payment: $e');
    }
  }

  Future<void> verifyPayment() async {
    final service = KhaltiService(client: KhaltiHttpClient());

    try {
      String otp = otpController.text;

      if (initiationModel != null) {
        final confirmationModel = await service.confirmPayment(
          request: PaymentConfirmationRequestModel(
            confirmationCode: otp,
            token: initiationModel!.token,
            transactionPin: pinCodeController.text,
          ),
        );

        print('Verification Token: ${confirmationModel.token}');
      } else {
        print('Error: initiationModel is null');
      }
    } catch (e) {
      print('Error confirming payment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.selectedImageUrls.length,
        itemBuilder: (context, index) {
          return buildCartItem(
            imageUrl: widget.selectedImageUrls[index],
            downloadLink: widget.selectedDownloadLinks[index],
            price: widget.selectedPrices[index],
            name: widget.selectedImageNames,
          );
        },
      ),
    );
  }

  Widget buildCartItem({
    required String imageUrl,
    required String downloadLink,
    double? price,
    required dynamic name,
  }) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imageUrl),
            const SizedBox(height: 8.0),
            const Text(
              'Game Details:',
              style: TextStyle(fontSize: 16.0, color: Colors.orange),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Game : ${name.toString()}',
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              price == null ? 'Price: Free' : 'Price: Rs.$price',
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black54,
              width: 220,
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.orange),
                decoration: const InputDecoration(
                  labelText: 'Enter your phone.',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                  suffixIcon: Icon(Icons.phone, color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black54,
              width: 220,
              child: TextFormField(
                controller: pinCodeController,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.orange),
                decoration: const InputDecoration(
                  labelText: 'Enter Pin.',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                  suffixIcon: Icon(Icons.lock, color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await initiatePayment();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 3,
              ),
              child: const Text('Pay via Khalti', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 50),
            const Text('Check your phone for OTP.', style: TextStyle(color: Colors.orange)),
            const SizedBox(height: 10),
            Container(
              color: Colors.black54,
              width: 200,
              child: TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.orange),
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await verifyPayment();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
