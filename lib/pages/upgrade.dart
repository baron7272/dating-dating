import 'package:dating/global/contanst.dart';
import 'package:dating/widgets/plan-card.dart';
import 'package:flutter/material.dart';

class Upgrade extends StatefulWidget {
  @override
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  final PageController ctrl = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Upgrade'),
      ),
      body: Center(
        child: Container(
          height: height(context)/1.48,
          child: PageView(
            controller: ctrl,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              PlanCard(
                title: 'Free',
                fee: '0',
                paid: false,
                onPressed: null,
              ),
              PlanCard(
                title: 'Basic',
                fee: '5',
                duration: '1 Month',
                onPressed: null,
              ),
              PlanCard(
                title: 'Standard',
                fee: '3',
                duration: '6 Months',
                onPressed: null,
              ),
              PlanCard(
                title: 'Premium',
                fee: '2',
                duration: '1 Year',
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
