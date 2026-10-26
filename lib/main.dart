import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/bank_account.dart';
import 'models/library.dart';
import 'models/book.dart';
import 'models/magazine.dart';
import 'screens/todo_screen.dart';

void main() => runApp(MaterialApp(home: TodoPage()));

class LabApp extends StatelessWidget {
  final List<User> users = [
    User(name: 'Ana', age: 20, email: 'ana@gmail.com'),
    User(name: 'Vlad', email: 'vlad@gmail.com'),
    User(name: 'Gigel'),
  ];

  final List<BankAccount> accounts = [
    BankAccount(holderName: 'Ion', bankBranch: 'Militari'),
    BankAccount(holderName: 'Mihai'),
    BankAccount(holderName: 'Elena')
  ];

  final Library library = Library();
    LabApp({super.key});

  void initialize(){
    accounts[0].initializeAccount('12345');
    accounts[1].initializeAccount('67');

    library.addItem(Book(title: 'Poezii', author: 'Eminescu', pageCount: 100));
    library.addItem(Magazine(title: 'Gazeta Sporturilor', publisher: 'TVR', issueNumber: 20));
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return Scaffold(
      appBar: AppBar(title: const Text('Sebi Ciocan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(users[i].name),
                subtitle: Text('${users[i].email ?? "Not provided"} | ${users[i].getDisplayAge()}'),
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, i) {
                final a = accounts[i];
                return ListTile(
                  title: Text(a.holderName),
                  subtitle: Text(a.isAccNumSet() ? (a.bankBranch ?? 'N/A') : 'Uninitialized account'),
                );
              },
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: library.allItems.length,
              itemBuilder: (context, i) {
                final item = library.allItems[i];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.borrower != null ? 'Borrowed by ${item.borrower!.name}' : 'Available'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}