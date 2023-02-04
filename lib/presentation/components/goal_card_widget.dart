import 'package:flutter/material.dart';

class GoalCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
              child: Icon(
                key: Key("goalCardIcon"),
                Icons.playlist_add_check_rounded,
                color: Colors.black87,
                size: 34,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    key: Key("goalCardTitle"),
                    'Sub goald title 1',
                  ),
                  Text(
                    key: Key("goalCardPercentage"),
                    '55% complete',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
