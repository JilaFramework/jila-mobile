import 'api_manager.dart';

Future<dynamic> getArtPieceCall({
  String objectID = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Art Piece',
    apiUrl:
        'https://collectionapi.metmuseum.org/public/collection/v1/objects/$objectID',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getDepartmentsCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Departments',
    apiUrl:
        'https://collectionapi.metmuseum.org/public/collection/v1/departments',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> searchArtCall({
  String q = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Search Art',
    apiUrl: 'https://collectionapi.metmuseum.org/public/collection/v1/search',
    callType: ApiCallType.GET,
    headers: {},
    params: {
      'q': q,
    },
    returnResponse: true,
  );
}

Future<dynamic> departmentHighlightsCall({
  int departmentId,
  bool isHighlight = true,
  String q = '*',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Department Highlights',
    apiUrl: 'https://collectionapi.metmuseum.org/public/collection/v1/search',
    callType: ApiCallType.GET,
    headers: {},
    params: {
      'departmentId': departmentId,
      'isHighlight': isHighlight,
      'q': q,
    },
    returnResponse: true,
  );
}
