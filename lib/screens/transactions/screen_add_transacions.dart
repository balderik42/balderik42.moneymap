import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneymap/db/category/category_db.dart';
import 'package:moneymap/db/transactions/transaction_db.dart';
import 'package:moneymap/models/category_model/category_model.dart';
import 'package:moneymap/models/transaction_modal/transaction_model.dart';

ValueNotifier<CategoryType> selectedCategoryListner =
    ValueNotifier(CategoryType.income);
String? CategoryId;
final _purposeEditingController = TextEditingController();
final _amountEditingController = TextEditingController();

class ScreenAddTransactions extends StatefulWidget {
  static const routname = 'add-transactions';
  const ScreenAddTransactions({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  DateTime? _selectedDate;

  CategoryModel? _SelectedCategoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add Transactions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _purposeEditingController,
                decoration: const InputDecoration(
                  hintText: 'Transaction name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _amountEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: ' Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(
                  Icons.calendar_today,
                ),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate.toString()),
              ),
            ),
            Row(
              children: const [
                RadioButtons(title: 'Income', type: CategoryType.income),
                RadioButtons(title: 'Expense', type: CategoryType.expense),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                  valueListenable: selectedCategoryListner,
                  builder:
                      (BuildContext context, CategoryType newtype, Widget? _) {
                    return DropdownButton<String>(
                      hint: const Text('select category'),
                      value: CategoryId,
                      items:
                          (selectedCategoryListner.value == CategoryType.income
                                  ? CategoryDb().incomeCategoryNotifier
                                  : CategoryDb().expenseCategoryNotifier)
                              .value
                              .map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name),
                          onTap: () {
                            _SelectedCategoryModel = e;
                          },
                        );
                      }).toList(),
                      onChanged: (selectValue) {
                        setState(() {
                          CategoryId = selectValue;
                        });
                      },
                      onTap: () {},
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    addTransactions();
                  },
                  child: Text('SUBMIT')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransactions() async {
    final _purposeText = _purposeEditingController.text;
    final _amountText = _amountEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    if (_SelectedCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.parse(_amountText);
    //selectedDate
    final _selectedCategoryType = selectedCategoryListner.value;
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType,
      category: _SelectedCategoryModel!,
    );
    await TransactionDb.instance.addTransactions(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}

class RadioButtons extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButtons({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedCategoryListner,
        builder: (BuildContext context, CategoryType newCategory, Widget? _) {
          return Row(
            children: [
              Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryListner.value = value;
                  selectedCategoryListner.notifyListeners();
                  CategoryId = null;
                },
              ),
              Text(title)
            ],
          );
        });
  }
}
