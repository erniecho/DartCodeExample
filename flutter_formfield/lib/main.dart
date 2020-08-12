import 'package:flutter/material.dart';


void main() {
  runApp(ProperForm());
}

enum SearchType { web, image, news, shopping }

class ProperForm extends StatefulWidget {
  @override
  _ProperFormState createState() => _ProperFormState();
}
class _ProperFormState extends State<ProperForm> {
 final Map<String, dynamic> _searchForm = <String, dynamic>{
   'searchTerm': '',
   'searchType': SearchType.web,
    'safeSearchOn': true,
 };

 final GlobalKey<FormState> _key = GlobalKey();

 @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        child: ListView(
          children: [
            TextFormField(
              initialValue: _searchForm['searchTerm'],
              decoration: InputDecoration(
                labelText: 'Search terms',
              ),
              onChanged: (String val) {
                setState(() => _searchForm['searchTerm'] = val);
              },
              onSaved: (String val) { },
              validator: (String val) {
                if (val.isEmpty) {
                  return 'We need something to search for';
                }
                return null;
              },
            ),
            FormField<SearchType>(
              builder: (FormFieldState<SearchType> state) {
                return DropdownButton<SearchType>(
                  value: _searchForm['searchType'],
                  items: const <DropdownMenuItem<SearchType>>[
                    DropdownMenuItem<SearchType>(
                      child: Text('Web'),
                      value: SearchType.web,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('Image'),
                      value: SearchType.image,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('News'),
                      value: SearchType.news,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('Shopping'),
                      value: SearchType.shopping,
                    ),
                  ],
                  onChanged: (SearchType val) {
                    setState(() => _searchForm['searchType'] = val);
                  },
                );
              },
              onSaved: (SearchType initialValue) {},
            ),
            FormField<bool>(
              builder: (FormFieldState<bool> state) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      value: _searchForm['safeSearchOn'],
                      onChanged: (bool val) {
                        setState(() => _searchForm['safeSearchOn'] = val);
                      },
                    ),
                    const Text('Safesearch on'),
                  ],
                );
              },
              onSaved: (bool initialValue) {},
            ),
            RaisedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  print('Successfully saved the state.');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}