import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/db/category/category_db.dart';
import 'package:moneymap/db/transactions/transaction_db.dart';
import 'package:moneymap/models/category_model/category_model.dart';
import 'package:moneymap/models/transaction_modal/transaction_model.dart';

class screentransactions extends StatelessWidget {
  const screentransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUi();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Color.fromARGB(255, 134, 166, 236),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(179, 156, 136, 136), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balannce = 10000',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'total Income = 52255',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 15, 139, 19)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'total expense = 5000',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDb.instance.TransactionListNotifier,
                  builder: (BuildContext context,
                      List<TransactionModel> newList, Widget? _) {
                    return ListView.separated(
                        itemBuilder: (ctx, index) {
                          final _value = newList[index];
                          return Slidable(
                            key: Key(_value.id!),
                            startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) {
                                    TransactionDb.instance
                                        .deleteTransaction(_value.id!);
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  child: Text(
                                    parseDate(_value.date),
                                  ),
                                  backgroundColor:
                                      _value.type == CategoryType.income
                                          ? Colors.green
                                          : Colors.red,
                                ),
                                title: Text(_value.category.name),
                                subtitle: Text('RS ${_value.amount}'),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: newList.length);
                  })),
        ],
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.last}\n${_splitDate.first}';
  }
}
