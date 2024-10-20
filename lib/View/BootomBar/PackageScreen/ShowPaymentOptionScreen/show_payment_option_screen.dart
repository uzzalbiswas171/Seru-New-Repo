import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '/payment_configurations.dart' as payment_configurations;


class ShowPaymentOptionScreen extends StatefulWidget {
  const ShowPaymentOptionScreen({super.key});

  @override
  State<ShowPaymentOptionScreen> createState() => _ShowPaymentOptionScreenState();
}

class _ShowPaymentOptionScreenState extends State<ShowPaymentOptionScreen> {
  bool  is_cliced=false;
  String  is_cliced_for_own="1";
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
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
            children:[ 
            
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
      ),
    );
  }
}
const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '.09',
    status: PaymentItemStatus.final_price,
  )
];