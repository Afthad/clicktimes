import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService{
Razorpay  _razorpay ;



initPayment(){
  _razorpay=new Razorpay();
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
_razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
}


void _handlePaymentSuccess(PaymentSuccessResponse response) { 

}
 void _handlePaymentError(PaymentFailureResponse response) {



 }
   void _handleExternalWallet(ExternalWalletResponse response){

   } 


getpayment(BuildContext context ,Usermodel usermodel,Hire hire,)async{
  int amount=int.parse(hire.amount);
  try {
     var options = {
  'key': 'rzp_test_2D5WK7ua3Jl55Z',
  'amount': amount*100, //in the smallest currency sub-unit.
  'name': 'ClickTimes Pvt Ltd',
  'order_id': 'sasn s SsSJ', // Generate order_id using Orders API
  'description': hire.category,
  'timeout': 60, // in seconds
  'prefill': {
    'contact': usermodel.phone,
    'email': usermodel.email
  }};
 _razorpay.open(options);
  } catch (e) {
    print(e);
  }
 
}
void clear(){
  _razorpay.clear(); // Removes all listeners
} // Removes all listeners

}

   // Do something when an external wallet is selected}
