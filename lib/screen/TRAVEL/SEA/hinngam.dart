import 'package:flutter/material.dart';

class Hinngam extends StatefulWidget {
  @override
  _HinngamState createState() => _HinngamState();
}

class _HinngamState extends State<Hinngam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เกาะหินงาม"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Image.asset("images/hinn.jpg"),
            Padding(padding: EdgeInsets.all(10)),
            Text("     ลักษณะเด่น\n"
                "               เป็นเกาะเล็ก ๆ ที่ไม่มีหาดทรายแต่เป็นหาดที่มีก้อนหิน กลม รี"
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
