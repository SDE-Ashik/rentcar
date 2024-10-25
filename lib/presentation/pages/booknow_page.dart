
// import 'package:car_rental_app/presentation/pages/receipt_page.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:slider_button/slider_button.dart';

// class BookNowPage extends StatefulWidget {
//   final Map<String, String> car;

//   BookNowPage({super.key, required this.car});

//   @override
//   _BookNowPageState createState() => _BookNowPageState();
// }

// class _BookNowPageState extends State<BookNowPage> {
//   late Razorpay _razorpay;
//   DateTime? _startDate;
//   DateTime? _endDate;
//   final TextEditingController _pickupLocationController =
//       TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     _pickupLocationController.dispose();
//     super.dispose();
//   }

//   // Open Razorpay checkout
//   void _openCheckout(double amount) async {
//     var options = {
//       'key': "rzp_test_0MOWwUqWRc4bvk",
//       'amount': (amount * 100).toInt(), // Convert to paise
//       'name': "ashik",
//       'prefill': {'contact': '9876543210', 'email': 'sample@gmail.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error opening Razorpay: $e");
//     }
//   }

//   // Razorpay event handlers
//  void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "Payment Successful: ${response.paymentId}",
//         toastLength: Toast.LENGTH_SHORT);

//     // Format the dates
//     String formattedStartDate = DateFormat.yMMMd().format(_startDate!);
//     String formattedEndDate = DateFormat.yMMMd().format(_endDate!);

//     // Navigate to the receipt page after payment success
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ReceiptPage(
//           carName: widget.car['name'] ?? 'Car',
//           startDate: formattedStartDate,
//           endDate: formattedEndDate,
//           amountPaid: 500, // Assuming this is the amount
//           paymentId: response.paymentId!,
//         ),
//       ),
//     );
//   }


//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(msg: "Payment via Wallet: ${response.walletName}");
//   }

//   // Booking confirmation dialog
//   void _showBookingConfirmation() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Booking Confirmed'),
//         content:
//             Text('Your booking for ${widget.car['name']} has been confirmed!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Date picker function
//   Future<DateTime?> _selectDate(BuildContext context) async {
//     return showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2025),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Color(0xFF6672C1),
//               onPrimary: Colors.black,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//   }

//   // Date input field widget
//   Widget _buildDateField({
//     required String label,
//     required DateTime? selectedDate,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               selectedDate != null
//                   ? DateFormat.yMMMd().format(selectedDate)
//                   : 'Select $label',
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//             Icon(Icons.calendar_today, color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book ${widget.car['name'] ?? 'Car'}'),
//         backgroundColor: Color(0xFF6672C1),
//       ),
//       body: Stack(
//         children: [
//           Container(color: Color(0xFF6672C1).withOpacity(0.8)),
//           Container(
//             color: Colors.black.withOpacity(0.4),
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.car['name'] ?? 'Car Name',
//                       style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Book your ${widget.car['name'] ?? 'car'} for a great experience!',
//                       style: TextStyle(fontSize: 18, color: Colors.white70),
//                     ),
//                     SizedBox(height: 24.0),
//                     _buildDateField(
//                       label: 'Start Date',
//                       selectedDate: _startDate,
//                       onTap: () async {
//                         DateTime? pickedDate = await _selectDate(context);
//                         if (pickedDate != null) {
//                           setState(() {
//                             _startDate = pickedDate;
//                           });
//                         }
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     _buildDateField(
//                       label: 'End Date',
//                       selectedDate: _endDate,
//                       onTap: () async {
//                         DateTime? pickedDate = await _selectDate(context);
//                         if (pickedDate != null) {
//                           setState(() {
//                             _endDate = pickedDate;
//                           });
//                         }
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: _pickupLocationController,
//                       decoration: InputDecoration(
//                         labelText: 'Enter Pickup Location',
//                         labelStyle: TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a pickup location';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 24.0),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             double? amount = 500;
//                             if (amount > 0) {
//                               _openCheckout(amount);
//                             } else {
//                               Fluttertoast.showToast(
//                                   msg: "Please enter a valid amount");
//                             }
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                     'Please fill all required fields before proceeding to payment'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           }
//                         },
//                         child: Text('Proceed to Payment'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF6672C1),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 12),
//                           textStyle: TextStyle(fontSize: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:car_rental_app/presentation/model/notification_model.dart';
import 'package:car_rental_app/presentation/pages/receipt_page.dart';
import 'package:car_rental_app/presentation/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookNowPage extends StatefulWidget {
  final Map<String, String> car;

  BookNowPage({super.key, required this.car});

  @override
  _BookNowPageState createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  late Razorpay _razorpay;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _pickupLocationController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    _pickupLocationController.dispose();
    super.dispose();
  }

  // Open Razorpay checkout
  void _openCheckout(double amount) async {
    var options = {
      'key': "rzp_test_0MOWwUqWRc4bvk",
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
      Fluttertoast.showToast(msg: "Error opening Razorpay: $e");
    }
  }

  // Razorpay event handlers
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "Payment Successful: ${response.paymentId}",
  //       toastLength: Toast.LENGTH_SHORT);

  //   // Format the dates
  //   String formattedStartDate = DateFormat.yMMMd().format(_startDate!);
  //   String formattedEndDate = DateFormat.yMMMd().format(_endDate!);

  //   // Navigate to the receipt page after payment success
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ReceiptPage(
  //         carName: widget.car['name'] ?? 'Car',
  //         startDate: formattedStartDate,
  //         endDate: formattedEndDate,
  //         amountPaid: 500, // Assuming this is the amount
  //         paymentId: response.paymentId!,
  //       ),
  //     ),
  //   );
  // }


void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful: ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);

    // Format the dates
    String formattedStartDate = DateFormat.yMMMd().format(_startDate!);
    String formattedEndDate = DateFormat.yMMMd().format(_endDate!);

    // Add notification to the service
    NotificationService.addNotification(NotificationModel(
      title: "Order Successfully Completed",
      message:
          "Your booking for ${widget.car['name']} has been completed. Payment ID: ${response.paymentId}",
      timestamp: DateTime.now(),
    ));

    // Navigate to the receipt page after payment success
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(
          carName: widget.car['name'] ?? 'Car',
          startDate: formattedStartDate,
          endDate: formattedEndDate,
          amountPaid: 500, // Assuming this is the amount
          paymentId: response.paymentId!,
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment via Wallet: ${response.walletName}");
  }

  // Date picker function
  Future<DateTime?> _selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6672C1),
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  // Date input field widget
  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat.yMMMd().format(selectedDate)
                  : 'Select $label',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Calculate the duration based on selected start and end dates
  int? _calculateDuration() {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays +
          1; // Including the start day
    }
    return null;
  }

  // Calculate the amount based on the duration (₹500 per day)
  double _calculateAmount() {
    int? duration = _calculateDuration();
    return duration != null ? duration * 500.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.car['name'] ?? 'Car'}'),
        backgroundColor: Color(0xFF6672C1),
      ),
      body: Stack(
        children: [
          Container(color: Color(0xFF6672C1).withOpacity(0.8)),
          Container(
            color: Colors.black.withOpacity(0.4),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.car['name'] ?? 'Car Name',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Book your ${widget.car['name'] ?? 'car'} for a great experience!',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    SizedBox(height: 24.0),
                    _buildDateField(
                      label: 'Start Date',
                      selectedDate: _startDate,
                      onTap: () async {
                        DateTime? pickedDate = await _selectDate(context);
                        if (pickedDate != null) {
                          setState(() {
                            _startDate = pickedDate;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildDateField(
                      label: 'End Date',
                      selectedDate: _endDate,
                      onTap: () async {
                        DateTime? pickedDate = await _selectDate(context);
                        if (pickedDate != null) {
                          setState(() {
                            _endDate = pickedDate;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _pickupLocationController,
                      decoration: InputDecoration(
                        labelText: 'Enter Pickup Location',
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a pickup location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    if (_startDate != null && _endDate != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration: ${_calculateDuration()} days',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Total Amount: ₹${_calculateAmount().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    SizedBox(height: 24.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_startDate == null || _endDate == null) {
                              Fluttertoast.showToast(
                                  msg: "Please select start and end dates");
                            } else if (_calculateDuration()! <= 0) {
                              Fluttertoast.showToast(
                                  msg: "End date must be after start date");
                            } else {
                              double amount = _calculateAmount();
                              _openCheckout(amount);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please fill all required fields before proceeding to payment'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text('Proceed to Payment'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
