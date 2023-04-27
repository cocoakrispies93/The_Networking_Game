import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_styles/nav_bar_v2.dart';
import '../firebase/guest_state_firebase.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // Items in the list
  final _items = [];

  // final MyNavigationBarState _navigationBarKey =
  //     MyNavigationBarState(); //MyNavigationBarState
  // final int taskIndex = 5;

  // @override
  // void initState() {
  //   super.initState();
  //   _navigationBarKey.setSelectedIndex(taskIndex);
  //   // ignore: avoid_print
  //   print('profile_page: _navigationBarKey.setSelectedIndex($taskIndex);');
  // }

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  // Add a new item to the list
  // This is trigger when the floating button is pressed
  void _addItem() {
    _items.insert(0, 'Item ${_items.length + 1}');
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }

  // Remove an item
  // This is trigger when the trash icon associated with an item is tapped
  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.deepPurple,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text('Goodbye', style: TextStyle(fontSize: 24)),
          ),
        ),
      );
      ;
    }, duration: const Duration(seconds: 1));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            highlightColor:
                Colors.deepPurple, // set highlight color to deep purple
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(
                  255, 152, 137, 180), // set primary color to deep purple
              onPrimary: Colors.deepPurple, // set text color to white
            ),
          ),
      textTheme: GoogleFonts.robotoTextTheme(
        Theme.of(context).textTheme,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Task List!!'),
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              color: Colors.deepPurple,
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title: Text(_items[index].toString(),
                    style: const TextStyle(fontSize: 24)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeItem(index),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addItem, child: const Icon(Icons.add)),
      //backgroundColor: theme,
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
    );
  }
}
