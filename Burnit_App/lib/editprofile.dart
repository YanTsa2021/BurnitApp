//Edit profile implementation

import 'package:burnit_app/othersprofile.dart';
import 'package:burnit_app/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) =>  EditProfile(),
    },
  ));
}

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: Container(
                    margin: const EdgeInsets.only(top:2.0),
                    height: 35.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          alignment:Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                              width: 35.0,
                              alignment:Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => OthersProfile()));
                                },
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: 20.0,
                        ),
                        Container(
                          width: 230.0,
                          alignment:Alignment.center,
                          child: const Text('Profile',style: TextStyle(color: Colors.black, fontSize: 20,
                            fontWeight: FontWeight.bold,),),
                        ),
                        Container(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size.fromHeight(kToolbarHeight)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              toolbarHeight: 0.2,
            ),
            resizeToAvoidBottomInset: false, // set it to false
            body: Center(
                child: MyCustomForm()
            )
        )
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return   MyCustomFormState();
  }
}

class  MyCustomFormState extends State < MyCustomForm>{
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  final _formKey = GlobalKey<FormState>();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
          ),
          Container(
            width: 350,
            height: 150,
            alignment:Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/ImgBurnit.png'),
                    fit: BoxFit.cover)),

          ),
          Container(
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(6),
          ),
          Container(
            width: 350,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child:TextFormField(
              key: Key('shop_category_filter_input_text_field'),
              controller: _userProfile.name,
              autocorrect: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid full name';
                }
                return null;
              },
            ),
            ),
          ),
          Container(
            width: 350,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child:TextFormField(
              key: Key('shop_category_filter_input_text_field'),
              controller: _userProfile.email,
              autocorrect: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                hintText: 'E-mail',
                labelText: 'E-mail',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid email address';
                }
                return null;
              },
            ),
            ),
          ),
          Container(
            width: 350,
             child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child:TextFormField(
              key: Key('shop_category_filter_input_text_field'),
              controller: _userProfile.dob,
              autocorrect: false,
              readOnly: true,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
                hintText: 'Enter your date of birth',
                labelText: 'Date of birth',
              ),
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015),
                  lastDate: DateTime(2025),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    _userProfile.dob.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                  }
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid date of birth';
                }
                return null;
              },
            ),
             ),
          ),
          Container(
            width: 350,
            child: Container(
              width: 350,
              height: 70.0,
              alignment:Alignment.center,
              child: new ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      width: 170.0,
                      height: 70.0,
                      alignment:Alignment.center,
                      child: TextFormField(
                        key: Key('shop_category_filter_input_text_field'),
                        obscureText: _userProfile.showHeight,
                        controller: _userProfile.height,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Icon(Icons.fitness_center),
                          border: OutlineInputBorder(),
                          hintText: 'Height',
                          labelText: 'Height',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid height';
                          }
                          return null;
                        },
                      )
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Container(
                      width: 170.0,
                      height: 70.0,
                      alignment:Alignment.center,
                      child: TextFormField(
                        key: Key('shop_category_filter_input_text_field'),
                        obscureText: _userProfile.showWeight,
                        controller: _userProfile.weight,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          prefixIcon: Icon(Icons.monitor_weight_outlined),
                          border: OutlineInputBorder(),
                          hintText: 'Weight',
                          labelText: 'Weight',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid weight';
                          }
                          return null;
                        },
                      )
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 350,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: TextFormField(
                key: Key('shop_category_filter_input_text_field'),
                obscureText: _userProfile.showCountry,
                controller: _userProfile.country,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/usaflag.jpg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Country',
                  labelText: 'Country',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid country';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            width: 350,
             child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              child: TextFormField(
                key: Key('shop_category_filter_input_text_field'),
                obscureText: _userProfile.showZipcode,
                controller: _userProfile.zipcode,
                autocorrect: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(IconData(_userProfile.iconCode, fontFamily: 'MaterialIcons')),// Will display "Up arrow" icon from the list
                  border: OutlineInputBorder(),
                  hintText: 'Zip code',
                  labelText: 'Zip code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid zip code';
                  }
                  return null;
                },
              ),
             ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            height: 44.0,
            width: 340.0,
            alignment:Alignment.center,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),),
            child: new RaisedButton(
              elevation: 0,
              textColor: Colors.white,
              color: Colors.purple,
              child: const Text('Save',style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),),
              onPressed: () {
                // It returns true if the form is valid, otherwise returns false
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Data is in processing.')));
                  //_userProfile.submittable() ? _submit : null;
                  _submit();
                }
              },
            ),
          ),
          //throw UnimplementedError();
        ],
      ),
    );
  }
}