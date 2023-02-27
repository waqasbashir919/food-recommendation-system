import 'package:flutter/material.dart';
import 'package:frs/screens/colorcodes.dart';

class DashboardFeatures extends StatelessWidget {
  final String title;
  final bool active;
  const DashboardFeatures({
    Key? key,
    required this.title,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: GestureDetector(
        onTap: () {
          if (title == 'Status') {
            Navigator.pushNamed(context, '/Status');
          } else if (title == 'Calories') {
            Navigator.pushNamed(context, '/Calorie');
          } else if (title == 'Indicators') {
            Navigator.pushNamed(context, '/Indicator');
          }
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.button!.copyWith(
                color: active ? kPrimarycolour : Colors.white.withOpacity(0.4),
              ),
        ),
      ),
    );
  }
}
