import 'package:flutter/material.dart';
import 'package:myapplication/screens/home.dart';

class OtpVerification extends StatefulWidget {
  static final String id = 'otpVerification';
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _phone;
  _otpPopup() {
    
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text('enter otp'),
            shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(20.0))),

            content: Container(
              height: 250.0,
              child: Column(
                
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter OTP',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      ),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20.0),
                            child: Container(
                                height: 50.0,
                                width: 170.0,
                                child: RaisedButton(
                                  child: Text('OK',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  onPressed: ()=> Navigator.pushNamed(context, Home.id),
                                  color: Color(0xFF213456),
                                )),
                          ),
                ],
              ),
            ),
          );
        });
  }


_submit(){
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      _otpPopup();
    }
  }
  /*_dialogueBox(BuildContext context){
    return showDialog(context: context, builder: (context));
    return AlertDialog(
      title: Text('Your name'),
      content: ,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFD9E6F2),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 125.0, 30.0, 20.0),
              child: Container(
                  child: Image(
                      height: 130.0,
                      width: 130.0,
                      image: AssetImage('assets/government-of-india.jpg'))),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                       Padding(
                padding: EdgeInsets.only(
                    left: 120.0, right: 30.0, top: 0.0, bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Icon(
                        Icons.verified_user,
                        size: 40.0,
                        color:  Color(0xFF213458),
                        
                      ),
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF213458),
                        
                      ),
                    ),
                  ],
                ),
              ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Your phone number',
                                labelStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF213458),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                              validator: (input) => input.length != 10
                                  ? 'Please enter a valid phone number'
                                  : null,
                              keyboardType: TextInputType.number,
                              onSaved: (input) => _phone = input,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: Text(
                            'We will send you a one time password',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF213458),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          child: Container(
                              height: 50.0,
                              width: 170.0,
                              child: RaisedButton(
                                child: Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                onPressed: _submit,
                                color: Color(0xFF213456),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }
}



/*
_submit(){
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      _otpPopup();
    }
  }

  */