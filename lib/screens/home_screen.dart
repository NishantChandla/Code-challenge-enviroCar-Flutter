import 'package:envirocar/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:envirocar/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User currentUser;
  bool isAuthenticated = false;
  Bloc signInBloc;

  @override
  void initState() {
    super.initState();
    signInBloc = BlocProvider.of<SignInBloc>(context);
    signInBloc.add(CheckIfSignedInEvent());
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Dashboard',
      style: optionStyle,
    ),
    Text(
      'Index 1: My tracks',
      style: optionStyle,
    ),
    Text(
      'Index 2: Others',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onPopUpSelected(String item) {
    if (item == 'Logout') {
      signInBloc.add(SignOutEvent());
    } else if (item == 'Log In/Register') {
      Navigator.pushNamed(context, '/sign_in');
    }
  }

  Widget buildPopUpMenu() {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is SignInAuthenticated) {
        currentUser = state.headers;
        isAuthenticated = true;
        return PopupMenuButton<String>(
          onSelected: onPopUpSelected,
          itemBuilder: (BuildContext context) {
            return {'Logout'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      } else {
        isAuthenticated = false;
        return PopupMenuButton<String>(
          onSelected: onPopUpSelected,
          itemBuilder: (BuildContext context) {
            return {'Log In/Register'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildPopUpMenu(),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'My Tracks',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Others',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[400],
        onTap: _onItemTapped,
      ),
    );
  }
}
