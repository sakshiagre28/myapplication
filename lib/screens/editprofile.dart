import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapplication/models/user.dart';
import 'package:myapplication/services/database_service.dart';
import 'package:myapplication/services/storage_service.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile({this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name;
  String _email;
  String _phone;
  String _password;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _email = widget.user.email;
    _phone = widget.user.phone;
    _password = widget.user.password;
  }
 
  _change(){
    print('hello');
  }
  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    //no profile image
    if (_profileImage == null) {
      //no existing profile image
      if (widget.user.profileImageUrl.isEmpty) {
        return AssetImage('assets/Portrait_Placeholder.png');
      } else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      //new profile image
      return FileImage(_profileImage);
    }
  }

  _saveChanges() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String _profileImageUrl = '';
      setState(() {
        _isLoading = true;
      });
      //update user in db
      if (_profileImage == null) {
        _profileImageUrl = widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);
      }

      User user = User(
          id: widget.user.id,
          name: _name,
          profileImageUrl: _profileImageUrl,
          phone: _phone,
          email: _email,
          password: _password);
      DatabaseService.updateUser(user);
      Navigator.pop(context);
      print(_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF213456),
        title: Text('Edit Profile',
            style: TextStyle(
              color: Color(0xFFD9E6F2),
            )),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        
        child: ListView(shrinkWrap: true,children: <Widget>[
          _isLoading
          ? LinearProgressIndicator(
            backgroundColor: Color(0xFF48AAAD),
            valueColor: AlwaysStoppedAnimation(Color(0xFF016064)),
            
          )
          : SizedBox.shrink(),
          
        Center(
          
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFD9E6F2),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0.0),
                      child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: _displayProfileImage()),
                    ),
                    FlatButton(
                      onPressed: () => _handleImageFromGallery(),
                      child: Text(
                        'Change profile image',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFF016064),
                        ),
                      ),
                    ),
                    Expanded(flex: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 30.0,
                            color: Color(0xFF016064),
                          ),
                          labelText: 'Name',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF016064),
                          )),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                            color: Color(0xFF016064),
                          )),
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter valid name'
                            : null,
                        onSaved: (input) => _name = input,
                      ),
                                            ),
                    ),
                    SizedBox(
                      height: 20.0
                    ),
                    Expanded(flex: 0,
                                            child: Padding(
                                              padding:  EdgeInsets.all(10.0),
                                              child: TextFormField(
                        initialValue: _email,
                        enabled: false,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            size: 30.0,
                            color: Color(0xFF016064),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF016064),
                          )),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                            color: Color(0xFF016064),
                          )),
                          labelText: 'Email',
                          focusColor: Color(0xFF016064),
                        ),
                      ),
                                            ),
                    ),
                    Expanded(
                                            child: Padding(
                                              padding:  EdgeInsets.all(10.0),
                                              child: TextFormField(
                        initialValue: _phone,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            size: 30.0,
                            color: Color(0xFF016064),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF016064),
                          )),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                            color: Color(0xFF016064),
                          )),
                          labelText: 'Phone',
                          focusColor: Color(0xFF016064),
                        ),
                        validator: (input) => input.trim().length != 10
                            ? 'Please enter valid phone number'
                            : null,
                        onSaved: (input) => _phone = input,
                      ),
                                            ),
                    ),

                    Expanded(flex: 1,
                                          child: Row(
                        children: <Widget>[
                          
                          Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: TextFormField(
                              initialValue: _password,
                              obscureText: true,
                              enabled: false,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  size: 30.0,
                                  color: Color(0xFF016064),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF016064),
                                )),
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                  color: Color(0xFF016064),
                                )),
                                labelText: 'Password',
                                focusColor: Color(0xFF016064),
                                suffixIcon: FlatButton(onPressed:()=>_change(), child: Text('change'))
                              ),
                              validator: (input) => input.trim().length<6
                                  ? 'Must be atleast 6 characters'
                                  : null,
                              onSaved: (input) => _password = input,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 50.0,
                        width: 190.0,
                        child: RaisedButton(
                          child: Text('Save Changes',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          onPressed: () => _saveChanges(),
                          color: Color(0xFF213456),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
