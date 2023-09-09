import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/util/util.dart';
import 'package:flutter/material.dart';

class ModalSheet extends StatefulWidget {
  ModalSheet(
      {super.key,
      this.onAddExpense,
      this.onUpdateExpense,
      this.expense,
      this.index});

  void Function(Expense expense)? onAddExpense;
  void Function(Expense expense, int index)? onUpdateExpense;

  Expense? expense;
  int? index;

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController = TextEditingController(text: widget.expense!.title);
      _amountController = TextEditingController(
          text: formatNumber("${widget.expense!.amount}".replaceAll(".", "")));
      _selectedDate = widget.expense!.date;
      _selectedCategory = widget.expense!.category;
    }
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = selected;
    });
  }

  void _submitExpense() {
    final amountConvert =
        int.tryParse(_amountController.text.replaceAll(".", ""));
    final amountIsInvalid = amountConvert == null || amountConvert <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Failed Save",
            textAlign: TextAlign.center,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cancel_outlined,
                size: 50,
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Text(
                  "Please make sure a valid title, amount, date and category was entered"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OKAY"))
          ],
        ),
      );
      return;
    }

    if (widget.expense != null) {
      widget.onUpdateExpense!(
        Expense(
            title: _titleController.text,
            amount: amountConvert,
            date: _selectedDate!,
            category: _selectedCategory),
        widget.index!,
      );
    } else {
      widget.onAddExpense!(
        Expense(
          title: _titleController.text,
          amount: amountConvert,
          date: _selectedDate!,
          category: _selectedCategory,
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            maxLength: 50,
            maxLines: 1,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    value = formatNumber(value.replaceAll(".", ""));
                    _amountController.value = TextEditingValue(
                      text: value,
                      selection: TextSelection.collapsed(
                        offset: value.length,
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    prefixText: 'Rp ',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Selected Date"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
