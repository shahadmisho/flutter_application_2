import 'package:flutter/material.dart';

void main() {
  runApp(ContactFormApp());
}

class ContactFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactForm(),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String gender = 'Male'; // Default selection
  String contactMethod = 'Email'; // Default option
  List<String> contactMethods = ['Email', 'Phone', 'SMS'];
  bool isSubscribed = false;

  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  String submittedInfo = ''; // Store submitted information

  void clearFields() {
    nameController.clear();
    emailController.clear();
    setState(() {
      gender = 'Male';
      contactMethod = 'Email';
      isSubscribed = false;
      errorMessage = '';
      submittedInfo = ''; // Clear submitted information
    });
  }

  void handleSubmit() {
    setState(() {
      errorMessage = '';
    });

    if (nameController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill out all fields';
      });
      return;
    }

    if (emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      setState(() {
        errorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // Store submitted information
    setState(() {
      submittedInfo =
          'Name: ${nameController.text}\nEmail: ${emailController.text}\nGender: $gender\nPreferred Contact Method: $contactMethod\nSubscribed: ${isSubscribed ? "Yes" : "No"}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Simple Contact Form'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Name Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),

                // Email Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),

                // Gender Radio Buttons
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Male'),
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Female'),
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Other'),
                        value: 'Other',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Preferred Contact Method Dropdown
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preferred Contact Method',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  value: contactMethod,
                  items: contactMethods.map((method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      contactMethod = value!;
                    });
                  },
                ),
                SizedBox(height: 15),

                // Newsletter Subscription Checkbox
                CheckboxListTile(
                  title: Text('Subscribe to newsletter'),
                  value: isSubscribed,
                  onChanged: (bool? value) {
                    setState(() {
                      isSubscribed = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                // Submit and Clear Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: handleSubmit,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.purple),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: clearFields,
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Display Error or Submitted Information
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (submittedInfo.isNotEmpty)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Submitted Information:\n$submittedInfo',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
