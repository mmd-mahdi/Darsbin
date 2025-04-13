//عادت ندارم معمولا کانت فارسی بزام ولی خب میخوایم سریع مفهوم برسه 
//این کلاس ایتم رو میتونیم به عنوان یک دیتا کلاس بهش نگاه کنیم که هر  ابجکتی که ازش ساخته میشه داده های با حودشو حمل میکنه 
//حالا ما هر عنصر فایل جیسونی که داریم رو میتونیم تبدیل به این ایته بکنیم 
// و داخل فلاتر از یک لیست از این فایله استفاده کنیم 

class Item {
  final int id;
  final String name;
  final String description;

  Item({required this.id, required this.name, required this.description});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}