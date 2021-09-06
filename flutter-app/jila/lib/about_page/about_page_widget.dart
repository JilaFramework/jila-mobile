import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jila/backend/api_requests/api_calls.dart';
import 'package:jila/models/AboutPageModel.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AboutPageWidget extends StatefulWidget {
  AboutPageWidget({Key key}) : super(key: key);

  @override
  _AboutPageWidgetState createState() => _AboutPageWidgetState();
}

class _AboutPageWidgetState extends State<AboutPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<AboutPage> aboutPageData;
  @override
  void initState() {
    super.initState();
    aboutPageData = fetchAboutPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: Image.asset(
                        'assets/images/Screen_Shot_2021-09-03_at_4.07.01_pm.png',
                        width: double.infinity,
                        height: 255,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'About',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Source Sans Pro',
                      color: Color(0xFFFFEBEE),
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Color(0xFFFCFBFB),
                    indicatorColor: FlutterFlowTheme.secondaryColor,
                    tabs: [
                      Tab(
                        text: 'About Us',
                      ),
                      Tab(
                        text: 'Contact Us',
                      ),
                      Tab(
                        text: 'Partners',
                      )
                    ],
                  ),
                  FutureBuilder<AboutPage>(
                      future: aboutPageData,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitRipple(
                              color: FlutterFlowTheme.primaryColor,
                              size: 50,
                            ),
                          ));
                        }
                        return Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    snapshot?.data?.aboutUs ??
                                        'No data to display...',
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    snapshot?.data?.contactUs ??
                                        'No data to display...',
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    snapshot?.data?.partners ??
                                        'No data to display...',
                                    style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
