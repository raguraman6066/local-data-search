import 'package:flutter/material.dart';

import '../data/books_data.dart';
import '../model/book.dart';
import '../widget/search_widget.dart';

class LocalList extends StatefulWidget {
  const LocalList({Key? key}) : super(key: key);

  @override
  State<LocalList> createState() => _LocalListState();
}

class _LocalListState extends State<LocalList> {
  late List<Book> books;
  String query = '';

  @override
  void initState() {
    super.initState();
    books = allBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Search Bar'),
      ),
      body: Column(
        children: [
          buildSearchBar(),
          Expanded(
            child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index];
                  return buildBookTile(book);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return SearchWidget(
      text: query,
      hintText: 'Title or Author Name',
      onChanged: searchBook,
    );
  }

  void searchBook(String query) {
    final books = allBooks.where((element) {
      final titleLower = element.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.books = books;
    });
  }
}

Widget buildBookTile(Book book) {
  return Card(
    child: ListTile(
      leading: Image.network(
        book.urlImage,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
    ),
  );
}
