import 'package:flutter/material.dart';
import 'package:kameleoon_client_flutter/kameleoon_client_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  KameleoonClient? kameleoonClient;
  String? error;
  String? visitorCode;

  @override
  void initState() {
    super.initState();
    _initKameleoonClient();
  }

  Future<void> _initKameleoonClient() async {
    try {
      final config = KameleoonClientConfig(
        refreshIntervalMinutes: 15,
        defaultTimeoutMilliseconds: 10000,
        dataExpirationIntervalMinutes: 1440 * 365,
        trackingIntervalMilliseconds: 500,
        environment: "staging",
        isUniqueIdentifier: false,
      );
      const siteCode = "4p5i382aoj";
      const visitor = "123";
      kameleoonClient = KameleoonClientFactory.create(siteCode, visitorCode: visitor, config: config);
      // Or, to generate visitor code automatically:
      // kameleoonClient = KameleoonClientFactory.create(siteCode, config: config);
      visitorCode = await kameleoonClient!.getVisitorCode();
      setState(() {});
    } on SiteCodeIsEmpty catch (ex) {
      setState(() { error = "Site code is empty: $ex"; });
    } on VisitorCodeInvalid catch (ex) {
      setState(() { error = "Visitor code invalid: $ex"; });
    } on Exception catch (ex) {
      setState(() { error = "Error: $ex"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Center(child: Text(error!));
    }
    if (kameleoonClient == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Kameleoon Client Initialized!'),
          if (visitorCode != null) Text('Visitor Code: $visitorCode'),
        ],
      ),
    );
  }
}

