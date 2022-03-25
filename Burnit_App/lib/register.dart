//Registration form implementation

import 'package:intl/intl.dart';
import 'package:burnit_app/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'checkconnectivity.dart';
import 'logo.dart';
import 'userprofile.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Register(),
      '/login': (context) => Login(),
    },
  ));
}

class Register extends StatefulWidget {

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<Register> {
  // we get the instance of the userprofile class just as we would create a new instance.
  final UserProfile _userProfile = UserProfile();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    _formKey.currentState!.validate();
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: PreferredSize(
            child: Container(
              margin: const EdgeInsets.only(top:40.0),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
              height: 45.0,
              width: 350.0,
              alignment:Alignment.centerLeft,
                      child: Container(
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
                                    builder: (context) => LogoPage()));
                              },
                              child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: Colors.black,),
                            )
                        ),
                      ),
                ),
        preferredSize: const Size.fromHeight(500.0),
      ), // set it to false
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                alignment:Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/ImgBurnit.png'),
                    )),
              ),
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(1),
              ),
              Container(
                width: 350,
                alignment:Alignment.center,
                child: RichText(
                  text: const TextSpan(text: '           Register',
                    style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold,),
                    children: [
                      TextSpan(text: '\n       Please Register to create\n                  New Account', style: TextStyle(color: Colors.black54, fontSize: 16,fontWeight: FontWeight.bold,),

                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.all(7),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
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
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.email,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      labelText: 'Email',
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
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.phone,
                    autocorrect: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.dob,
                    autocorrect: false,
                    readOnly: true,
                    decoration:  const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your date of birth',
                      labelText: 'Dob',
                    ),
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
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
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.password,
                    obscureText: _userProfile.showPassword,
                    autocorrect: true,
                    decoration:  InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      prefixIcon: const Icon(Icons.password),
                      //suffixIcon: Icon(Icons.remove_red_eye),
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_userProfile.showPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _userProfile.showPassword = !_userProfile.showPassword),
                      ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                  child:TextFormField(
                    key: const Key('shop_category_filter_input_text_field'),
                    controller: _userProfile.ConfirmPassword,
                    obscureText: _userProfile.showConfirmPassword,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      prefixIcon: const Icon(Icons.password),
                      //suffixIcon: Icon(Icons.remove_red_eye),
                      border: const OutlineInputBorder(),
                      hintText: 'Re-enter password',
                      labelText: 'Re-enter password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: () => setState(() => _userProfile.showConfirmPassword = !_userProfile.showConfirmPassword),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: FormField<bool>(
                    builder: (state) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  value:   _userProfile.agreedToTOS,
                                  onChanged: (value) {
                                    setState(() {
                                      //save checkbox value to variable that store terms and notify form that state changed
                                      _userProfile.agreedToTOS = value!;
                                      state.didChange(value);
                                    });
                                  }),
                              GestureDetector(
                                onTap: () => _userProfile.setAgreedToTOS(!_userProfile.agreedToTOS),
                                child: const Text(
                                    'Agree to Terms and Conditions',style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold,)
                                ),
                              ),
                            ],
                          ),
                          //display error in matching theme
                          Text(
                            state.errorText ?? '',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          )
                        ],
                      );
                    },
                    //output from validation will be displayed in state.errorText (above)
                    validator: (value) {
                      if (!  _userProfile.agreedToTOS) {
                        return 'You need to accept Terms and Conditions';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 44.0,
                width: 350.0,
                alignment:Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: SizedBox(
                  height: 44.0,
                  width: 350.0,// specific value
                  child: RaisedButton(
                    elevation: 0,
                    textColor: Colors.white,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide( color: Colors.purple,width: 1,)
                    ),
                    child: const Text('Confirm',style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      textBaseline: TextBaseline.alphabetic,
                    ),),
                    onPressed: () {
                        // It returns true if the form is valid, otherwise returns false
                        if (_formKey.currentState!.validate()) {
                          _userProfile.submittable() ? _submit : null;
                          _userProfile.sendDataRegister(context);
                        }
                    },
                  ),
                ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 1),
                alignment:Alignment.center,
                child: RichText(
                  text: TextSpan(text: 'Already have an account?',
                    style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold,),
                    children: [
                      TextSpan(text: ' login', style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold,),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Login())
                            );
                          }
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child:Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 20.0,
                    width: 350.0,
                    alignment:Alignment.center,
                    child: const CheckConnectivity(),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}



