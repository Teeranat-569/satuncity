import 'package:flutter/material.dart';

class Dragon extends StatefulWidget {
  @override
  _DragonState createState() => _DragonState();
}

class _DragonState extends State<Dragon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สันหลังมังกร"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Image.asset("images/hinn.jpg"),
            Padding(padding: EdgeInsets.all(10)),
            Text("      สวัสดีชาวโลก\n"
                "                เป็นเกาะเล็ก ๆ ที่ไม่มีหาดทรายแต่เป็นหาดที่มีก้อนหิน กลม รี"
                "วางเรียงรายอยู่เต็มเกาะ ยามน้ำทะเลซัดขึ้นมาก้อนหินเหล่านี้จะเปียกชุ่ม "
                "ส่องประกายมันวาวสะท้อนไปทั่วหาดหิน ยามน้ำลงแนวหาดหินจะปรากฏกว้างยิ่งขึ้นและจะตัดกับน้ำทะเลสีมรกต "
                "ซึ่งเป็นธรรมชาติที่สวยงามที่หาดูได้ยากในที่อื่น ๆ ในส่วนบริเวณรอบๆเกาะหินงาม"
                "ยังเป็นที่ดำน้ำดูปะการัง")
          ],
        ),
      ),
    );
  }
}
