import 'package:flutter/material.dart';
import 'package:myapplication/screens/home.dart';

class CategoryInput extends StatefulWidget {
  static final String id = 'categoryinput';
  @override
  _CategoryInputState createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool agriculture = false,education= false,health= false,
  housing= false,
  insurance= false,
  loan=false,
  pension=false;

  _submit() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      
      Navigator.pushNamed(context, Home.id);
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
                padding: EdgeInsets.only(top: 30.0),
                child: Container(
                  // height: 20.0,
                  //width: 20.0,
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
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.person_add,
                        size: 40.0,
                        color: Color(0xFF213458),
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
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: agriculture,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    agriculture = value;
                                  });
                                },
                              ),
                              Text(
                                'Agriculture',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: education,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    education = value;
                                  });
                                },
                              ),
                              Text(
                                'Education',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: health,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    health = value;
                                  });
                                },
                              ),
                              Text(
                                'Health',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: housing,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    housing = value;
                                  });
                                },
                              ),
                              Text(
                                'Housing',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: insurance,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    insurance = value;
                                  });
                                },
                              ),
                              Text(
                                'Insurance',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: loan,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    loan = value;
                                  });
                                },
                              ),
                              Text(
                                'Loan',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: pension,
                                activeColor: Color(0xFF028A0F),
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    pension = value;
                                  });
                                },
                              ),
                              Text(
                                'Pension',
                                style: TextStyle(
                                  color: Color(0xFF213458),
                                  fontSize: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 0.0),
                          child: Container(
                              height: 50.0,
                              width: 170.0,
                              child: RaisedButton(
                                child: Text('Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
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
              )),
            ]),
          ),
        ),
      ),
    );
  }
}
