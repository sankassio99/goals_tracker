import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/goal_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Sub goals',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          ListView(
            key: const Key("goalCardsListView"),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: GoalCardWidget(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: GoalCardWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
