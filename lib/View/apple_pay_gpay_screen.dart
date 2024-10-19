import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '/payment_configurations.dart' as payment_configurations;

class ApplePayGooglePayScreen extends StatefulWidget {
  const ApplePayGooglePayScreen({super.key});

  @override
  State<ApplePayGooglePayScreen> createState() => _ApplePayGooglePayScreenState();
}

class _ApplePayGooglePayScreenState extends State<ApplePayGooglePayScreen> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
          children:[
            SizedBox(height: 200,),

            FutureBuilder<PaymentConfiguration>(
              future: _googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : const SizedBox.shrink()),

            ApplePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                  payment_configurations.defaultApplePay),
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onApplePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),]
      ),
    ),);
  }
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '.09',
    status: PaymentItemStatus.final_price,
  )
];
