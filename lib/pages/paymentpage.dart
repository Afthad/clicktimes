import 'package:clicktimes/constant.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class Paymentpage extends StatefulWidget {
  @override
  _PaymentpageState createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
 Razorpay _razorpay = Razorpay();

 @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);_razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {  
    // Do something when payment succeeds
    }
  void _handlePaymentError(PaymentFailureResponse response) {  
    // Do something when payment fails
    }
  void _handleExternalWallet(ExternalWalletResponse response) 
  {  // Do something when an external wallet is selected}
  }
  var options = {
  'key': 'rzp_test_2D5WK7ua3Jl55Z',
  'amount': 10000, //in the smallest currency sub-unit.
  'name': 'ClickTimes Pvt Ltd',
  'order_id': 'sasn s SsSJ', // Generate order_id using Orders API
  'description': 'HHHHHH',
  'timeout': 60, // in seconds
};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              _razorpay.open(options);
            },
                    child: Container(
                      child: Text('paY',style: chatroomtitle,),
              
            ),
          ),
        ],
      ),
    );
  }
}