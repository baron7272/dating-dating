import 'package:dating/global/contanst.dart';
import 'package:dating/pages/payments.dart';
import 'package:dating/widgets/filter-popup.dart';
import 'package:dating/widgets/switch-tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  int selectedSwitchOption = 0;
  List<String> switchOptions = [
    "Single",
    "Group",
  ];

  var ageRange = RangeValues(18, 100);
  var distRange = RangeValues(18, 100);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Match Filter'),
          elevation: 0,
        ),
        key: _scaffoldkey,
        body: ListView(children: [
          SizedBox(height: 20.0),
          ListTile(
            title: Text('Stripe payment'),
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> StripePayment())),
          ),
          SwitchTabs(
            options: switchOptions,
            selectedBackgroundColor: secondary,
            selectedTextColor: Colors.white,
            onSelect: (int selectedOption) {
              setState(() {
                selectedSwitchOption = selectedOption;
              });
            },
          ),
          _childWidget(selectedSwitchOption),
          SizedBox(height: 20.0),
        ]),
      ),
    );
  }

  _childWidget(int index) {
    switch (index) {
      case 0:
        return FilterPopup();
        break;
      case 1:
        return FilterPopup(isSingle: false);
        break;
      default:
        FilterPopup();
    }
  }
}
