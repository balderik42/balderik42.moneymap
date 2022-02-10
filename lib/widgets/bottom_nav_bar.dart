import 'package:flutter/material.dart';
import 'package:moneymap/screens/screen_home.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: screenHome.selecteIndexNotifier,
    builder: (BuildContext context, int updatedIndex, Widget? _){
      return BottomNavigationBar(
        selectedItemColor: Colors.purple,unselectedItemColor: Colors.grey,
        currentIndex: updatedIndex,
        onTap: (newIndex){
        screenHome.selecteIndexNotifier.value = newIndex;
        },
        items:const [
         BottomNavigationBarItem(
        icon: Icon(Icons.money),
        label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Category',
          ),
    
        ],
      );},
   
    );
  }
}