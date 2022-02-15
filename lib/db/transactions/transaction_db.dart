import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymap/models/transaction_modal/transaction_model.dart';

const TREANSACTION_DB_NAME = 'transactiom_db';

abstract class TransactionDbFunctions {
  Future<void> addTransactions(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> TransactionListNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransactions(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TREANSACTION_DB_NAME);
    await db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    TransactionListNotifier.value.clear();
    TransactionListNotifier.value.addAll(_list);
    TransactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final db = await Hive.openBox<TransactionModel>(TREANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(TREANSACTION_DB_NAME);
    await db.delete(id);
    refresh();
  }
}
