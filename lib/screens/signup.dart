import 'package:myapplication/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/screens/otp.dart';
import 'package:myapplication/services/auth_service.dart';

class SignUp extends StatefulWidget {
  static final String id = 'signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   String _name,_email,_password,_cpassword, _phone;
   //TextEditingController signupPassController1,signupPassController2;

   _submit(){
      
     
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
       AuthService.signUpUser(context, _name, _email, _password,_phone);
      //Navigator.pushNamed(context, OtpVerification.id);
    }

  }

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
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:40.0),
                child: Container(
                  
                  child: Image(
                    height: 130.0,
                    width: 130.0,
                    image: AssetImage(
                      'assets/government-of-india.jpg',
                    ),
                  ),
                ),
              ),
             Padding(
                padding: EdgeInsets.only(
                    left: 130.0, right: 30.0, top: 15.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:8.0),
                      child: Icon(
                        Icons.person_add,
                        size: 40.0,
                        color:  Color(0xFF213458),
                        
                      ),
                    ),
                    Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF213458),
                        
                      ),
                    ),
                  ],
                ),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Color(0xFF213458),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            validator: (input) => input.isEmpty
                            ? 'Please enter a valid name'
                            : null,
                            onSaved: (input) => _name = input,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                color: Color(0xFF213458),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            validator: (input) {
                              input = input.trim();
                              if (input.contains('@')) {
                                return null;
                              } else {
                                return 'Please enter valid email id';
                              }
                            },
                            onSaved: (input) => _email = input,
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Your phone number',
                                labelStyle: TextStyle(
                                  
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: TextFormField(
                            
                            decoration: InputDecoration(
                              labelText: 'Set Password',
                              labelStyle: TextStyle(
                                color: Color(0xFF213458),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            validator: (input) => input.length < 6
                                ? 'Must be atleast 6 characters'
                                : null,
                            obscureText: true,
                            onSaved: (input) => _password = input,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: TextFormField(
                            
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Color(0xFF213458),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            validator: (input) => input.length < 6
                                ? 'Must be atleast 6 characters'
                                : null,
                            obscureText: true,
                            onSaved: (input) => _cpassword = input,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Container(
                              height: 50.0,
                              width: 130.0,
                              child: RaisedButton(
                                child: Icon(
                                  Icons.forward,  
                                  color: Color(0xFFD9E6F2),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                onPressed: _submit,
                                
                                color: Color(0xFF213458),
                              )
                              ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 0.0),
                            child: Container(
                              height: 40.0,
                              width: 700.0,
                              child: FlatButton(
                                onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                                child: Text(
                                  'Already have an account? Login.',
                                  style: TextStyle(
                                    color: Color(0xFF213458),
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            )
                            ),
                      ],
                    ),
                  )
                ],
              )),
            ]),
          ),
        ),
      ),
    );
  }
}




/*
child: RaisedButton(
                                child: Text('Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                onPressed:(){ 
                                  
                                  Navigator.pushNamed(context, OtpVerification.id);
                                  },
                                
                                color: Color(0xFF213458),
                              )

#####################################################\

Text('Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),

 */