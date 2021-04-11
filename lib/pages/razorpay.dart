import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../constant.dart';


class Payment extends StatefulWidget {
  Usermodel usermodel;
  Hire hire;
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_2D5WK7ua3Jl55Z",
      "amount" : num.parse(widget.hire.amount)*100,
      "name" : "Sample App",
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "2323232323",
        "email" : "shdjsdh@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(){
    print("Pament success");
    Fluttertoast.showToast(
      msg: 'Payment Success'
    );

  }

  void handlerErrorFailure(){
    print("Pament error");
    Fluttertoast.showToast(
      msg: 'Payment Failed'
    );
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Fluttertoast.showToast(
      msg: 'Exatenal Wallet'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          'Payments',
          style: headerappbar,
        ),
        centerTitle: true,
       backgroundColor: Colors.white,
        foregroundColor: kPrimaryColor,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
         
          children: [

              ListTile(
                contentPadding: EdgeInsets.zero,
                       title: Text('Pay with Razorpay'),
                       trailing:  MaterialButton(
              color: kSuccessColorPayment,
              
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Text("Pay 2000", style: TextStyle(
                color: Colors.white
              ),),
              onPressed: (){
                openCheckout();
              },
            ),
              ),

            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Pay with Razorpay',style: paragraphmedium5,),
              MaterialButton(
              color: kSuccessColorPayment,
              
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Text("Pay 2000", style: TextStyle(
                color: Colors.white
              ),),
              onPressed: (){
                openCheckout();
              },
            )
              ],
            ),
            SizedBox(height: 12,),
            
          ],
        ),
      ),
    );
  }
}