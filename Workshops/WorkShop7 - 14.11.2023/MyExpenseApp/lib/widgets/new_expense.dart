import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  var _expenseNameController = TextEditingController();
  var _expensePriceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _expenseNameController,
              maxLength: 50,
              decoration: InputDecoration(labelText: "Harcama Adı"),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expensePriceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Harcama Miktarı"),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: 4),
                      Text("Tarih Seçiniz"),
                    ],
                  ),
                ),
              ],
            ),
        SizedBox(height: 16),
        Text("Seçilen Tarih: ${DateFormat.yMd().format(_selectedDate)}"),
        SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {
              print("Kaydedilen değer: ${_expenseNameController.text} ${_expensePriceController.text}");
              print("Seçilen Tarih: ${DateFormat.yMd().format(_selectedDate)}");
            },
            child: Text("Ekle"),
          )

            ),
          ],
        ),
      ),
    );
  }
}
