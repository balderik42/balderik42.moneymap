import 'package:flutter/material.dart';
import 'package:moneymap/screens/category/category_add_popup.dart';
import 'package:moneymap/screens/category/screen_categoery.dart';
import 'package:moneymap/screens/transactions/screen_add_transacions.dart';
import 'package:moneymap/screens/transactions/screen_transactions.dart';
import 'package:moneymap/widgets/bottom_nav_bar.dart';

class screenHome extends StatelessWidget {
  const screenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selecteIndexNotifier = ValueNotifier(0);
  final _pages = const [screentransactions(), screenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 243, 243),
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          child: Text('Money Map'),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: bottomNavigationBar(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selecteIndexNotifier,
              builder: (BuildContext contex, int updatedIndex, Widget? _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selecteIndexNotifier.value == 0) {
            print('add transactions');
            Navigator.of(context).pushNamed(ScreenAddTransactions.routname);
          } else {
            print('add category');
            showCategoryAddPopUp(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
