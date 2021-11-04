import 'package:flutter/material.dart';
import 'package:openidconnect/openidconnect.dart';
import 'package:flutter/foundation.dart';

const String clientID = '9bsv0s3pbdv002o80qhg';
const String redirectURL = 'http://localhost:8050/callback.html';
const String defaultDiscoveryUrl =
    'https://oauth2.api.antinvestor.com/.well-known/openid-configuration';
const defaultScopes = [
  'openid',
  'profile',
  'email',
  'address',
  'offline_access'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String discoveryUrl = defaultDiscoveryUrl;
  OpenIdConfiguration? discoveryDocument;
  AuthorizationResponse? identity;
  bool usePopup = true;
//
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: TextButton.icon(
              key: const Key('Authenticate'),
              onPressed: () async {
                try {
                  final response = await OpenIdConnect.authorizeInteractive(
                    context: context,
                    title: "Login",
                    request: await InteractiveAuthorizationRequest.create(
                      clientId: clientID,
                      redirectUrl: redirectURL,
                      scopes: defaultScopes,
                      configuration: discoveryDocument!,
                      autoRefresh: false,
                      useWebPopup: usePopup,
                    ),
                  );
                  setState(() {
                    identity = response;
                    errorMessage = null;
                  });
                  // print('identity?.idToken');
                } on Exception catch (e) {
                  setState(() {
                    errorMessage = e.toString();
                    identity = null;
                  });
                }
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
