import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;

  ProductCreate(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreateState();
  }
}

class _ProductCreateState extends State<ProductCreate> {
  String _title;
  String _description;
  double _price;
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  Widget _buildTitleTextField(){
    return TextFormField(
      validator: (String value){
        if(value.isEmpty || value.length <5)
          return 'Title is required and the lenght should be 5+ characters';
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String value){
        setState(() {
          _title=value;
        });
      },
    );
  }
  Widget _buildDescriptionTextField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      validator: (String value){
        if(value.isEmpty || value.length <10)
          return 'Description is required and the lenght should be 5+ characters';
      },
      onSaved: (String value){
        setState(() {
          _description=value;
        });
      },
    );
  }
  Widget _buildPriceTextField(){
    return  TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      validator: (String value){
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value))
          return 'Price is required and it should be a number';
      },
      onSaved: (String value){
        setState(() {
          _price=double.parse(value);
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:Container(
      margin: EdgeInsets.all(10.0),
      child:Form(
        key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          Center(
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text("Save"),
              onPressed: () {
                if(!_formKey.currentState.validate()){
                  return;
                }
                _formKey.currentState.save();
                final Map<String,dynamic> product={
                  'title':_title,
                  'description':_description,
                  'price':_price,
                  'image':'assets/food.jpg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          )
        ],
      ),
      ),
    ),
    );
  }
}
