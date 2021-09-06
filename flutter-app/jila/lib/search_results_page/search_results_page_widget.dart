import 'package:jila/models/EntriesModel.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchResultsPageWidget extends StatefulWidget {
  SearchResultsPageWidget({
    Key key,
    this.searchTerm,
  }) : super(key: key);

  final String searchTerm;

  @override
  _SearchResultsPageWidgetState createState() =>
      _SearchResultsPageWidgetState();
}

class _SearchResultsPageWidgetState extends State<SearchResultsPageWidget> {
  TextEditingController textController;
  Future<EntriesModel> futureData;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    futureData = fetchEntriesByWord(widget.searchTerm);
    super.initState();
    textController = TextEditingController(text: widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EntriesModel>(
      future: futureData,
      builder: (context, snapshot) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.secondaryColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 145,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFFFBF9F9),
                              size: 24,
                            ),
                            iconSize: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                            child: Text(
                              'Search',
                              style: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Playfair Display',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Color(0xFFF0F5F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SearchResultsPageWidget(
                                              searchTerm: textController.text,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: FlutterFlowTheme.tertiaryColor,
                                        size: 24,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 4),
                                        child: TextFormField(
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Search word',
                                            labelStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Playfair Display',
                                              color: Color(0xFF95A1AC),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Playfair Display',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Image.asset(
                          'assets/images/emptySearchResults.png',
                          width: MediaQuery.of(context).size.width * 0.86,
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: SpinKitRipple(
                            color: FlutterFlowTheme.primaryColor,
                            size: 50,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.entriesModels?.length,
                      itemBuilder: (context, searchResultsIndex) {
                        final searchResultsItem =
                            snapshot.data.entriesModels[searchResultsIndex];
                        return Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Card(
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
                                        Image.network(
                                          searchResultsItem.imageThumbnail ??
                                              '',
                                          width: 56,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchResultsItem.entryWord,
                                                    style: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily:
                                                          'Playfair Display',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 3, 0, 6),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: AutoSizeText(
                                                            searchResultsItem
                                                                .translation,
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText2
                                                                    .override(
                                                              fontFamily:
                                                                  'Playfair Display',
                                                              color: FlutterFlowTheme
                                                                  .tertiaryColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
