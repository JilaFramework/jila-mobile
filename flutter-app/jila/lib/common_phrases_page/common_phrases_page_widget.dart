import '../flutter_flow/flutter_flow_audio_player.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonPhrasesPageWidget extends StatefulWidget {
  CommonPhrasesPageWidget({Key key}) : super(key: key);

  @override
  _CommonPhrasesPageWidgetState createState() =>
      _CommonPhrasesPageWidgetState();
}

class _CommonPhrasesPageWidgetState extends State<CommonPhrasesPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                    'Common Phrases',
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
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Word',
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Playfair Display',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 6),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 6, 0),
                                          child: Text(
                                            'Translated word',
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Playfair Display',
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlutterFlowAudioPlayer(
                                    audio: Audio.network(
                                      '',
                                      metas: Metas(
                                        id: 'df3hg_-1fenir0a',
                                        title: 'Word',
                                      ),
                                    ),
                                    titleTextStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    playbackDurationTextStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF9D9D9D),
                                      fontSize: 12,
                                    ),
                                    fillColor: Color(0xFFEEEEEE),
                                    playbackButtonColor:
                                        FlutterFlowTheme.primaryColor,
                                    activeTrackColor: Color(0xFF57636C),
                                    elevation: 4,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
