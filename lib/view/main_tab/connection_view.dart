import 'package:flutter/material.dart';

import 'package:nayapakistan/view/main_tab/main_tab_view.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bool isConnected = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (!isLoading) {
              setState(() {
                isConnected = !isConnected;
              });
              if (isConnected) {
                // Start loading process
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 2), () {
                  // Navigate to the home screen after 2 seconds
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainTabView()),
                  );
                });
              }
            }
          },
          child: CircleAvatar(
            radius: 200, // Adjust the radius as needed
            backgroundColor: Color.fromARGB(0, 189, 89, 89),
            child: isConnected
                ? Image.asset(
                    "assets/images/loading_page.gif",
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/connect_mobile.png",
                    height: 300,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
