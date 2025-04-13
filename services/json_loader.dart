

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/item_model.dart';

Future<List<Item>> loadItems() async {
  //این کده خب اول میاد فایل جیسون رو میخونه و به صورت خام رشته داخل یه متغیر ذحیر میکنه 
  final jsonString = await rootBundle.loadString('assets/data.json');
  //رشته بالا تبدیل به یک دیتا استراکچر میشه که یک لیست هست و هر عنصر لیست یک مپ همون دیکشنری پایتون هست 

  final List<dynamic> jsonList = json.decode(jsonString);
  // اینجا میایم لیست بالا رو تبدیل به یک لیست از کلاس ایتم که گفتیم هر کدومش دیتا کلاس هست میکنیم 
  return jsonList.map((json) => Item.fromJson(json)).toList();
}