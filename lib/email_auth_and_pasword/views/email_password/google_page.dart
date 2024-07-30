import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthScreen extends StatefulWidget {
  const GoogleAuthScreen({Key? key}) : super(key: key);

  @override
  State createState() => GoogleAuthScreenState();
}

class GoogleAuthScreenState extends State<GoogleAuthScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Sign in failed: $error'); // Log detailed error
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
  }

  void _showUserDialog(GoogleSignInAccount user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: GoogleUserCircleAvatar(
                  identity: user,
                ),
                title: Text(user.displayName ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email ?? ''),
                    Text(user.serverAuthCode ?? ''),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _handleSignOut();
              },
              child: const Text('SIGN OUT', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Authentication'),
        actions: [
          IconButton(
            onPressed: () {
              // Implement any action here
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return GestureDetector(
        onTap: () => _showUserDialog(user),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: GoogleUserCircleAvatar(
                identity: user,
              ),
              title: Text(user.displayName ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email ?? ''),
                  Text(user.serverAuthCode ?? ''),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Card(
        color: Colors.pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'You are not currently signed in.',
                style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: _handleSignIn,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://img.freepik.com/free-psd/google-icon-isolated-3d-render-illustration_47987-9777.jpg?size=338&ext=jpg&ga=GA1.1.2113030492.1719532800&semt=sph",
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text('SIGN IN', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
