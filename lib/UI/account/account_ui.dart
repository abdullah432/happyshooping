import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/common/circle_button.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/account/account_bloc.dart';
import 'package:happyshooping/models/user.dart';

class AccountUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountUIState();
  }
}

class AccountUIState extends State<AccountUI> {
  User user = User();
  TextEditingController _nameController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  AccountBloc _accountBloc;
  bool showCheckIcon = false;

  initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          showCheckIcon = true;
        });
      } else {
        setState(() {
          showCheckIcon = false;
        });
      }
      print("Has focus: ${_focusNode.hasFocus}");
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _accountBloc = BlocProvider.of<AccountBloc>(context);

    return BlocListener<AccountBloc, AccountState>(listener: (context, state) {
      if (state is UpdateUserNameFail) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          backgroundColor: Colors.red,
        ));
      }
    }, child: BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        print(state);
        if (state is AccountPageInitial) {
          return Center(child: SpinKitPulse(size: 51.0, color: Colors.green));
        }

        if (state is FetchUserDataFail) {
          return Center(
              child: Text(state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red)));
        }

        if (state is FetchUserDataSuccess || state is UpdateUserNameFail || state is UpdateUserNameSuccess) {
          print(user.email);
          _nameController.text = user.name;
          return GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Constant.lrSidePadding,
                      right: Constant.lrSidePadding,
                      top: 50.0),
                  child: Column(
                    children: <Widget>[
                      profileInfo(),
                      listOfOptions(),
                    ],
                  ),
                ),
              ));
        }
      },
    ));
  }

  profileInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Flexible(
                            child: EditableText(
                              // "Abdullah khan",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _nameController,
                              focusNode: _focusNode,
                              cursorColor: Colors.black54,
                              backgroundCursorColor: Colors.yellow,
                              // onChanged: (value) {
                              //   if (!showCheckIcon) {
                              //     setState(() {
                              //       showCheckIcon = true;
                              //     });
                              //   }
                              // },
                            ),
                          ),
                          showCheckIcon
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleButton(
                                    iconData: Icons.check,
                                    backgroundColor: Constant.primaryColor,
                                    onTap: () {
                                      _focusNode.unfocus();
                                      _accountBloc.add(UpdateUserNameEvent(
                                          name: _nameController.text));
                                    },
                                  ),
                                )
                              : GestureDetector(onTap: () {_focusNode.requestFocus();},child: Icon(Icons.edit, size: 20, color: Constant.highlightedColor)),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            // "abdullah234ktk@gmail.com",
                            user.email,
                            style: TextStyle(
                                color: Constant.highlightedColor, fontSize: 16),
                          )),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    //first column
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Pending',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            // 'Rs 0.00',
                            'Rs ${user.pending}',
                            style: TextStyle(
                                color: Constant.highlightedColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    //divider
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 25,
                        child: VerticalDivider(
                          color: Constant.highlightedColor,
                        ),
                      ),
                    ),
                    //second column
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Available',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            // 'Rs 0.00',
                            'Rs ${user.approved}',
                            style: TextStyle(
                                color: Constant.highlightedColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    //divider
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 25,
                        child: VerticalDivider(
                          color: Constant.highlightedColor,
                        ),
                      ),
                    ),
                    //third column
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Total Earn',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            // 'Rs 0.00',
                            'Rs. ${user.totalEarning}',
                            style: TextStyle(
                                color: Constant.highlightedColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
              child: Text(
                '*Minimum redeemable amount is Rs.99',
                style: TextStyle(
                    color: Constant.highlightedColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                height: 42,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: RaisedButton(
                    color: user.totalEarning > 98
                        ? Constant.primaryColor
                        : Constant.highlightedColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    onPressed: () {
                      //TODO: Redeem
                    },
                    child: Text(
                      'Redeem',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ))),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  listOfOptions() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  'My Profile',
                  style: TextStyle(color: Constant.highlightedColor),
                ),
                trailing: Icon(Icons.account_circle),
              )),
          Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  'Referal',
                  style: TextStyle(color: Constant.highlightedColor),
                ),
                trailing: Icon(Icons.credit_card),
              )),
        ],
      ),
    );
  }
}
