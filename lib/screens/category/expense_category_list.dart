import 'package:flutter/material.dart';
import 'package:moneymap/db/category/category_db.dart';
import 'package:moneymap/models/category_model/category_model.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenseCategoryNotifier,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newlist[index];

              return ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDb.instance.deleteCategory(category.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length);
      },
    );
  }
}
