import 'package:flutter/material.dart';

class screentransactions extends StatelessWidget {
  const screentransactions({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Color.fromARGB(255, 134, 166, 236),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color.fromARGB(179, 156, 136, 136), width: 1),
    borderRadius: BorderRadius.circular(10),),
          margin: EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: double.infinity,
            
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
               children: [Text('Total Balannce = 10000',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,fontSize: 25,color: Color.fromARGB(255, 0, 0, 0)),
                  
              
                ),
                SizedBox(height: 5,),
                const Text('total Income = 52255',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color.fromARGB(255, 15, 139, 19)),
                ),
                SizedBox(height: 5,),

                const Text('total expense = 5000',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),
                ),
                SizedBox(height: 10,),

                
        
                ],
                
                ),
            ),
          ),
        ),
          Expanded(
            child: ListView.separated(itemBuilder: (ctx,index){
              return Card(
                elevation: 0,
                child: const ListTile(
                  leading: CircleAvatar(
                  radius: 40,
                  child: Text('12\ndec')),
                  title: Text('salery'),
                  subtitle: Text('5000'),
                  ),
              );}, 
            separatorBuilder: (ctx,index){
              return SizedBox(height: 5,);
              },
             itemCount: 100),
          ),
        ],
      ),
    );
  }
}