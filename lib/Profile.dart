import 'package:asu_carpool/LocalDatabase.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'MyWidgets.dart';
import 'auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? _userData;
  String? connection;
  String? name;
  String? email;
  String? phone;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  final LocalDatabase db = LocalDatabase();
  Future<void> writingData() async {
    final userData = await fetchUserProfile();
    await db.write('''INSERT INTO 'USERS'
        ('FIRST_NAME','LAST_NAME','EMAIL','PHONE') VALUES
        ('${_userData!['firstName']}','${_userData!['lastName']}','${_userData!['email']}','${_userData!['phone']}') ''');
  }

  Future<void> _getUserInfo() async {
    final isConnected = await checkConnection();

    if (isConnected) {
      // Fetch user profile data from Firestore
      final userData = await fetchUserProfile();
      setState(() {
        _userData = userData;
        connection = "From Online DataBase";

        name = '${_userData!['firstName']} ${_userData!['lastName']}';
        email = _userData!['email'];
        phone = _userData!['phone'];
      });
      // writingData();
      print("-------------------------> $connection, $name, $email, $phone");
    } else {
      // Fetch user profile data from local database
      final response = await db.reading('''SELECT * FROM 'USERS' LIMIT 1''');
      if (response.isNotEmpty) {
        setState(() {
          final userFromDB = response.first;
          connection = "From Local Database";
          name = '${userFromDB['FIRST_NAME']} ${userFromDB['LAST_NAME']}';
          email = userFromDB['EMAIL'];
          phone = userFromDB['PHONE'];
        });
      }
      print("-------------------------> $connection, $name, $email, $phone");
    }
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.white70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textPlace("Connection: ", connection ?? ''),
                textPlace("Name: ", name ?? ''),
                textPlace("Email: ", email ?? ''),
                textPlace("Phone Number: ", phone ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
