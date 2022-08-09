import 'package:apiintegration/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 Future<List> users = getUsers();
  final TextEditingController _searchController = TextEditingController();

  searchUser() {
    users = searchUsers(_searchController.text);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API INTEGRATION"),centerTitle: true,
      leading: const Icon(Icons.arrow_back_ios_new),),
      body:  Column(
        children: [
         const  SizedBox(height: 10,),
          TextFormField(cursorColor: Colors.black,
            controller: _searchController,
            decoration: InputDecoration(
               contentPadding: const EdgeInsets.all(8),
                hintText: "Search By Name",
                 focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo)
              ),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8)
              ),
                suffix: IconButton(
                  onPressed: () {
                  searchUser();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ), 
                ),
          ),),
          Expanded(
            child:FutureBuilder(
              future: users,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "${snapshot.data[index].name} - (${snapshot.data[index].username})"),
                        subtitle: Text(
                            "${snapshot.data[index].email} - (${snapshot.data[index].phone})"),
                        // trailing: Text(
                        //    "${snapshot.data[index].id} - (${snapshot.data[index].id})"
                        // ),
                      );
                    },
                  );
                }
              }, 
          )),
        ],
      ),
    );
  }
}