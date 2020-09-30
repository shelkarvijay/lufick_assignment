import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lufick_task/Database-Services/database-operation.dart';
import 'package:lufick_task/api-calls/api-block.dart';
import 'package:lufick_task/api-responses/api-response.dart';
import 'package:lufick_task/classes/currency-modal-class.dart';
import 'package:lufick_task/interfaces/response-interface.dart';
import 'package:intl/intl.dart';

class ListingScreen extends StatefulWidget {
  int notificationTransId;
  ListingScreen({this.notificationTransId});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListingScreen();
  }
}

class _ListingScreen extends State<ListingScreen> implements ResponseCallBack {
  final _textFieldController = TextEditingController();
  ApiBlock _bloc;

  Map<String, double> _mainList;
  DatabaseOperations _databaseOperations;
  bool isLoading = false;
  String refreshTime;
  DateTime currentTime = DateTime.now();
  TimeOfDay _timeOfDay;

  @override
  void initState() {
    _bloc = new ApiBlock(this, context);
    _databaseOperations = new DatabaseOperations();
    refreshTime = DateFormat('MM/dd/yyyy  h:mm').format(currentTime);
    _getDataList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: ColorUtils.bodyBackgroundColor,
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 3.0,
          leading: Text(''),
          // centerTitle: true,
          title: _getAppBarTitle(),
          actions: <Widget>[_getRefreshButton()],
        ),
        body: _getBody(context));
  }

  _getAppBarTitle() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Euro',
            style: TextStyle(fontSize: 14),
          ),
          Container(
            child: Text(
              'Last refresh $refreshTime',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _getRefreshButton() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
      child: RaisedButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
            side: BorderSide(color: Colors.grey[300])),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          child: Container(
              // min sizes for Material buttons
              alignment: Alignment.center,
              child: Text(
                "Refresh",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
        ),
        onPressed: () {
          DateTime dateTime = DateTime.now();
          setState(() {
            // isLoading = false;
            _mainList.clear();
            _mainList = null;

            refreshTime = DateFormat('MM/dd/yyyy  h:mm').format(dateTime);
          });
          _getDataList();
        },
      ),
    );
  }

  _getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _getTextContainer(context),
          SizedBox(
            height: 10,
          ),
          _mainList != null ? _getList(context) : _buildProgressIndicator()
        ],
      ),
    );
  }

  _getTextContainer(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _getTextField(context),
          _getConvertButton(context),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  _getTextField(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      child: TextFormField(
        controller: _textFieldController,
        autofocus: false,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.done,
        decoration: new InputDecoration(
          //DimenUtils.font10,),
          contentPadding: EdgeInsets.only(left: 15),
          filled: true,
          fillColor: Colors.white,
          counter: Offstage(),
          hintText: 'AppLocalizations.of(context).translate("Enter_OTP")',
          hintStyle: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  _getConvertButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        height: 40,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: BorderSide(color: Colors.grey[300])),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            child: Container(
                // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  "Convert",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )),
          ),
          onPressed: () {},
        ));
  }

  _getList(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _mainList.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          String key = _mainList.keys.elementAt(index);
          return Container(
              child: Container(
                  margin: EdgeInsets.only(left: 12, right: 23),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    leading: Text('$key'),
                    trailing: Text('${_mainList[key]}'),
                  )),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.grey[350]))));
        },
      ),
    );
  }

  _getDataList() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      _bloc.getCurrencyList(
          'https://api.exchangeratesapi.io/latest', json.encode({}), '');
    }
  }

  @override
  getError(res, String apiCallFor) {
    // TODO: implement getError
    throw UnimplementedError();
  }

  List<CurrencyClass> createList = List();
  @override
  getResponse(res, String apiCallFor) {
    var response = currencyListResponseFromJson(json.encode(res));
    CurrencyListResponse currencyListResponse = response;
    setState(() {
      isLoading = false;
      this._mainList = currencyListResponse.rates;
      for (var i = 0; i < this._mainList.length; i++) {
        var key = this._mainList.keys.elementAt(i);
        createList.add(CurrencyClass(
            currencyName: key.toString(),
            currencyValue: this._mainList[key].toString()));
      }
      _databaseOperations.cleanDatabase().then((value) {
        _databaseOperations.saveIntoDB(this._mainList);
      });
    });
  }
}

class CurrencyClass {
  CurrencyClass({
    this.currencyName,
    this.currencyValue,
  });

  String currencyName;
  String currencyValue;
}
