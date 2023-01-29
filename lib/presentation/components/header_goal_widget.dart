import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HeaderGoalWidget extends StatefulWidget {
  const HeaderGoalWidget({Key? key}) : super(key: key);

  @override
  _HeaderGoalWidgetState createState() => _HeaderGoalWidgetState();
}

class _HeaderGoalWidgetState extends State<HeaderGoalWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Icon(
                        Icons.wind_power,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                    Text(
                      'Title main goal',
                    ),
                  ],
                ),
                const Text(
                  'Sollicitant homines non sunt nisi quam formae rerum principiis opiniones. Mors enim est terribilis ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: LinearPercentIndicator(
                percent: 0.5,
                width: MediaQuery.of(context).size.width * 0.87,
                lineHeight: 24,
                animation: true,
                progressColor: Colors.blue,
                backgroundColor: Color(0xFFF1F4F8),
                center: const Text(
                  '50%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
                barRadius: Radius.circular(5),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
