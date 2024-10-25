import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends StatefulWidget {
  const RazorpayPage({super.key});

  @override
  State<RazorpayPage> createState() => _RazorpayPageState();
}

class _RazorpayPageState extends State<RazorpayPage> {
  late Razorpay _razorpay;
  bool flag = true;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // Function to open Razorpay checkout
  void _openCheckout(double amount) async {
    var options = {
      'key': "rzp_test_0MOWwUqWRc4bvk", // Replace with your Razorpay key
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': "ashik",
      'prefill': {'contact': '9876543210', 'email': 'sample@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      Fluttertoast.showToast(msg: "Error opening Razorpay: $e");
    }
  }

  // Success handler
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful: ${response.paymentId}",
        toastLength: Toast.LENGTH_LONG);
  }

  // Error handler
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed: ${response.message}",
        toastLength: Toast.LENGTH_LONG);
  }

  // External wallet handler
  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Payment via Wallet: ${response.walletName}",
        toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        

        double? amount = 500;
        // double.tryParse(_amountController.text);
        if (amount != null && amount > 0) {
          _openCheckout(amount);
        } else {
          Fluttertoast.showToast(
              msg: "Please enter a valid amount",
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: flag
          ? Text(
              'Pay Now',
              style: TextStyle(fontSize: 18),
            )
          : CircularProgressIndicator(),
          
    );
    // return Scaffold(
    //   // appBar: AppBar(
    //   //   title: const Text('Razorpay Payment'),
    //   //   centerTitle: true,
    //   //   backgroundColor: Colors.blueAccent,
    //   // ),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         // Amount Input Field
    //         // TextField(
    //         //   controller: _amountController,
    //         //   keyboardType: TextInputType.number,
    //         //   decoration: InputDecoration(
    //         //     labelText: "Enter amount",
    //         //     labelStyle: TextStyle(fontSize: 18),
    //         //     border: OutlineInputBorder(
    //         //       borderRadius: BorderRadius.circular(10),
    //         //     ),
    //         //     prefixIcon: const Icon(Icons.currency_rupee),
    //         //   ),
    //         // ),
    //         // const SizedBox(height: 20),

    //         // Pay Now Button
    //         ElevatedButton(
    //           onPressed: () {
    //             double? amount = double.tryParse(_amountController.text);
    //             if (amount != null && amount > 0) {
    //               _openCheckout(amount);
    //             } else {
    //               Fluttertoast.showToast(
    //                   msg: "Please enter a valid amount",
    //                   toastLength: Toast.LENGTH_SHORT);
    //             }
    //           },
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Colors.blueAccent,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    //           ),
    //           child: const Text(
    //             'Pay Now',
    //             style: TextStyle(fontSize: 18),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
