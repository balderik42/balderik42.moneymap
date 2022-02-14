import 'package:flutter/material.dart';
import 'package:moneymap/db/category/category_db.dart';
import 'package:moneymap/screens/category/expense_category_list.dart';
import 'package:moneymap/screens/category/income_category_list.dart';

class screenCategory extends StatefulWidget {
  const screenCategory({Key? key}) : super(key: key);

  @override
  State<screenCategory> createState() => _screenCategoryState();
}

class _screenCategoryState extends State<screenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelColor: Color.fromRGBO(0, 0, 0, 1),
          controller: _tabController,
          indicatorColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSE',
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              incomeCategoryList(),
              ExpenseCategory(),
            ],
          ),
        ),
      ],
    );
  }
}
