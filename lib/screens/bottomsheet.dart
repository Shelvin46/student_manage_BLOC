import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms/bottom_nav_bar/bottom_nvaigation_bloc.dart';
import 'package:sms/screens/home_list.dart';
import 'package:sms/screens/home_page.dart';

class Botom extends StatelessWidget {
  Botom({Key? key});

  final List<Widget> pages = [
    const HomePage(),
    ListofDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNvaigationBloc, BottomNvaigationState>(
      builder: (context, state) {
        int currentSelectIndex = state.count ?? 0;
        return Scaffold(
          body: pages[currentSelectIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentSelectIndex,
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<BottomNvaigationBloc>(context).add(HomeView());
              } else {
                BlocProvider.of<BottomNvaigationBloc>(context)
                    .add(AccountList());
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: 'Account'),
            ],
          ),
        );
      },
    );
  }
}
