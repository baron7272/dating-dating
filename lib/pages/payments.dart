import 'dart:convert';
import 'dart:io';

import 'package:dating/global/contanst.dart';
import 'package:dating/scoped-models/main-model.dart';
import 'package:dating/widgets/texttile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
class Server {
  Future<String> createCheckout(amount) async {
    print('Stripe amount is $amount');
    final auth = 'Basic ' + base64Encode(utf8.encode('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'));
    final body = {
      'payment_method_types': ['card'],
      'line_items': [
        {
          'price_data': {
            'currency': 'usd',
            'product_data': {
              'name': 'Fund Your account',
              'images': ['https://apkplz.net/storage/images/com/eloksware/mhagic/com.eloksware.mhagic_1.png'],
            },
            'unit_amount': amount.toString()+000.toString(),
          },
          'quantity': 1,
        },
      ],
      'mode': 'payment',
      'success_url': 'https://www.mhagic.com/',
      'cancel_url': 'https://www.mhagic.com/cancel',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );

      print(' id ${result.data['id']}');
      return result.data['id'];

    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }
}

class StripePayment extends StatefulWidget {

  final String sessionId;
  final Map<String, dynamic> user;
  final MainModel model;
  final amount, item_id, from;

  const StripePayment(
      {Key key,
        this.from,
        this.sessionId,
        this.user,
        this.model,
        this.amount,
        this.item_id})
      : super(key: key);

  @override
  _StripePaymentState createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {

  TextEditingController _voteController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: cstart,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'Amount (minimum: 5 Dollar)',
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _voteController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 5,
              ),
               MaterialButton(
                 textColor: Colors.white,
                 color: Colors.black,
                 minWidth: double.infinity,
                child: Text('Credit with Stripe'),
                onPressed: () async {
                  await Server()
                      .createCheckout(
                      int.parse(_voteController.text.toString() + 00.toString()))
                      .then((value) {
                    return Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Payment(
                          sessionId: value,
                          model: widget.model,
                          user: widget.user,
                          amount: _voteController.text,
                          from: 'stripe'
                      ),
                    ));
                  });

                },
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}


class Payment extends StatefulWidget {
  final String sessionId;
  final Map<String, dynamic> user;
  final MainModel model;
  final amount, item_id, from;

  const Payment(
      {Key key,
        this.from,
        this.sessionId,
        this.user,
        this.model,
        this.amount,
        this.item_id})
      : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  WebViewController _webViewController;

  Future _creditUser() async {
    print('========== entered here ========= ');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('mhagictoken');

    String url = Uri.encodeFull(
        "http://mhagic.com/api/v1/verifyPaymentpayFast?userId=${widget.user['id']}&amount=${widget.amount}&trackingId=${widget.item_id}&payment_name=${widget.from}");

    print('========== $url ========= ');

    return await http.get("$url", headers: {
      'Authorization': 'Bearer $token',
    }).then((http.Response response) async {
      print('========== $response ========= ');
      json.decode(response.body);
      Map<String, dynamic> result = json.decode(response.body);
      print('========== ${response.body}');
      if (result.containsKey('success')) {
        prefs.setString(
            'mhagicBalance', result['balance']['newBalance'].toString());
      } else {}
    });
  }

  _paymentSuccessful() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: primary,
                child: Icon(
                  Icons.check,
                  size: 30,
                ),
              ),
            ),
            content: Text(
              'Payment successful',
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print('========== ');
                  _creditUser().whenComplete(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });

                },
                child: TextTile(text: 'Okay', color: primary),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Stack(
        children: [
          WebView(
            initialUrl: 'https://checkout.stripe.com/pay/${widget.sessionId}#fidkdWxOYHwnPyd1blppbHNgWjA0TFI1Sk9PZ01gcWJzSU1LdV9EMkxpSXV3RE5CM05BdE9uZjVzZjBcRjF3T19ETm1HQjNdX052YDZCU2FHYkdIPXBAYTdcaU1PXH9vSmZAUkkzUWZLX2R0NTU1VE1mS2MzNicpJ2hsYXYnP34nYnBsYSc%2FJ0tEJyknaHBsYSc%2FJzUwNjU0ZDZhKDJgMDcoMTwyMShkNTVmKDU3YTE8Y2AyYzNjZGBmZzUzMycpJ3ZsYSc%2FJzUyMGY2NzNhKDEyYDQoMTA0Nyg9PTUxKGRjPTJnZDE1YDMwYDYwN2QyPSd4KSdnYHFkdic%2FXlgpJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ3dgY2B3d2B3SndsYmxrJz8nbXFxdXY%2FKipoZHdmbGtwdn0rYmxxbXBnK2xqJ3gl',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) {
              return _webViewController = webViewController;
            },
            onPageFinished: (String url) {
              print('onPageFinished $url');
              if (url == 'https://www.mhagic.com/') {
                _paymentSuccessful();
              }
              else if (url == 'https://www.mhagic.com/cancel') {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            onPageStarted: (String url) {
              print('url url $url');
            },
            navigationDelegate: (NavigationRequest request) {
              print('test request $request');
              if (request.url == 'https://www.mhagic.com/') {
                _paymentSuccessful();
              }
              else if (request.url == 'https://www.mhagic.com/cancel') {
                Navigator.pop(context);
                Navigator.pop(context);
              }
              return NavigationDecision.navigate;
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundColor: white,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
