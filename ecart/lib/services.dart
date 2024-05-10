import 'package:ecart/ecart_model.dart';
import 'package:http/http.dart'as http;
// import 'package'
// ;

productsItmes() async{
  Uri url = Uri.parse("https://dummyjson.com/products");
  var res = await http.get(url);
  try{
    if (res.statusCode == 200){
      var data = productFromJson(res.body);
      return data.products;
    }else{
      print("Error Occurred");
    }
  }catch(e) {
    print(e.toString());
  }
}