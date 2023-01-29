import 'package:flutter/material.dart';
import 'package:goals_tracker/presentation/components/header_goal_widget.dart';

class MainGoalViewModel extends ChangeNotifier {
  
}

class MainGoalPageWidget extends StatelessWidget {
  final _unfocusNode = FocusNode();

  MainGoalPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const MyAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 199,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: HeaderGoalWidget(),
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                    color: Colors.black12,
                  ),
                  // SubGoalsListWidget(),
                  ElevatedButton(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    // icon: const Icon(
                    //   Icons.add_circle,
                    //   size: 15,
                    // ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(88, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                    child: const Text('Add subgoal'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black12,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black12,
          size: 20,
        ),
        onPressed: () {
          print('IconButton pressed ...');
        },
      ),
      title: const Text(
        'Page Title',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black12,
        ),
      ),
      actions: [],
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(200, 40);
}
