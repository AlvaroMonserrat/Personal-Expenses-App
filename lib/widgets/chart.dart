import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';
import '/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var transaction in recentTransactions) {
        if (transaction.date!.day == weekDay.day &&
            transaction.date!.month == weekDay.month &&
            transaction.date!.year == weekDay.year) {
          totalSum += transaction.amount!;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Expanded(
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0 ? 0 : data['amount'] / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
