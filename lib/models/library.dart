import 'library_item.dart';
import 'user.dart';

class Library {
  List<LibraryItem> items = [];

  void addItem(LibraryItem item){
    if(items.contains(item)){
      //print('Item is already in library');
      return;
    }
    items.add(item);
  }

  List<LibraryItem> searchByTitle(String? title) {
    if (title == null) {
      return [];
    }
    return items.where((item) => 
        item.title==title).toList();
  }

  List<LibraryItem> getItemsByAuthor(String? author) {
    if (author == null) {
      return [];
    }
    return items.where((item) => 
        item.author == author).toList();
  }

  List<LibraryItem> getRecentItems() {
    return items.sublist(items.length-3);
  }

  bool borrowItem(LibraryItem item, User user) {
    if (item.borrower != null) {
      //print('${item.title} is already borrowed.');
      return false; 
    }
    item.borrower = user;
    item.dueDate = DateTime.now().add(Duration(days: 7)); 
    return true;
  }

  void returnItem(LibraryItem item) {
    item.borrower = null;
    item.dueDate = null;
  }

  List<LibraryItem> get allItems => items;
}