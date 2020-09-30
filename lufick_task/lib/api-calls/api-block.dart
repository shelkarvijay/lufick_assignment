import 'dart:convert';

import 'package:lufick_task/api-calls/api-base-helper.dart';
import 'package:lufick_task/api-responses/api-response.dart';
import 'package:lufick_task/interfaces/response-interface.dart';

class ApiBlock {
  ResponseCallBack _responseCallBack;
  ApiBaseHelper _helper = ApiBaseHelper();

  ApiBlock(ResponseCallBack _responseCallBack, context) {
    this._responseCallBack = _responseCallBack;
  }

  getCurrencyList(endpoint, body, apiCallFor) async {
    var response;
    response = await _helper.post(endpoint, body, apiCallFor);
    response = currencyListResponseFromJson(json.encode(response));
    _responseCallBack.getResponse(response, apiCallFor);
    return response;
  }
}
