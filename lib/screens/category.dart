import 'package:budget_tracker/services/database.dart';
import 'package:budget_tracker/widgets/colors.dart';
import 'package:budget_tracker/widgets/expense_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Category extends StatefulWidget {
  final userId;
  final CategoryTitle;

  const Category({Key? key, required this.CategoryTitle, required this.userId})
      : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Stream<QuerySnapshot>? expenses;
  @override
  void initState() {
    // TODO: implement initState
    fetchCategory();
    super.initState();
  }

  Future fetchCategory() async {
    await Database(uid: widget.userId)
        .CategoricExpenses(widget.userId, widget.CategoryTitle)
        .then((value) {
      if (value != null) {
        setState(() {
          expenses = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          widget.CategoryTitle,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: expenseList()),
    );
  }

  expenseList() {
    return StreamBuilder(
        stream: expenses,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length != 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                      title: snapshot.data.docs[index]['category'],
                      money: snapshot.data.docs[index]['amount'],
                      date: DateFormat.yMMMd()
                          .add_jm()
                          .format(snapshot.data.docs[index]['Date'].toDate()),
                    );
                  });
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: (Text(
                  "No expenses",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
              );
            }
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: (CircularProgressIndicator())),
            );
          }
        });
  }
}
