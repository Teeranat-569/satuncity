import 'package:flutter/material.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: Text('การเดินทาง'),backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            indicatorWeight: 5.0,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.flight),
              ),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bus)),
              Tab(
                icon: Icon(Icons.directions_car),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tab(
                'การเดินทางโดยเครื่องบิน',
                'การเดินทางไปยังจังหวัดสตูล โดยเครื่องบินนั้นสามารถนั่งเครื่องมาลงสนามบินหาดใหญ่'
                    'เมื่อถึงสนามบินหาดใหญ่ สำหรับท่านที่จองรถตู้ไว้ (ราคารถตู้ไปกลับสนามบินหาดใหญ่ – ปากบารา ท่านละ 500 บาท ) จะมีรถตู้รอรับที่สนามบินเพื่อไปยังท่าเรือปากบารา หรือถ้าหากท่านไม่ได้จองรถตู้ไว้ ก็สามารถไปนั่งรถตู้วินที่ตลาดเกษตรได้ แต่วิธีอาจจะต้องเผื่อเวลาไว้สักหน่อยเพื่อ เดินทางไป ท่าเรือปากบารา'
                    'สายการบินที่บินตรง กทม – หาดใหญ่ ได้แก่ การบินไทย, ไทยแอร์เอเซีย, นกแอร์, ไทยไลออนแอร์ '),
            tab('การเดินทางโดยรถไฟ',
                'สามารถเดินทางไปกับขบวนรถไฟ กรุงเทพฯ – ยะลา หรือกรุงเทพฯ – หาดใหญ่ ได้ โดยซื้อตั๋วและระบุลงที่สถานีรถไฟหาดใหญ่ จากนั้น นั่งรถแท็กซี่ ที่สถานีจอดรถใต้ สะพานลอย หน้าที่ทำการไปรษณีย์สาขารัถการ หรือรถตู้โดยสาร หรือนั่งรถ โดยสารประจำทางเข้าจังหวัดสตูล ระยะทาง 97 กม. สอบถามรายละเอียดได้ที่ สถานีรถไฟหัวลำโพง โทรหมายเลข 02-2237010, 02-2237020 '),
            tab(
                'การเดินทางโดยรถประจำทาง',
                'มีรถโดยสารปรับอากาศและรถธรรมดา กรุงเทพฯ – สตูล ให้บริการ ทุกวัน โดยรถเริ่มให้บริการที่สถานีขนส่งสายใต้ใหม่ ถนนบรมราชชนนี สอบถาม รายละเอียดการให้บริการได้ที่ สถานีขนส่ง รถโดยสารธรรมดา โทรหมายเลข 02-4345557-8, รถโดยสารปรับอากาศ โทรหมายเลข 02-4351199 '
                    'ถ้าเลือกการเดินทางด้วยรถโดยสารประจำทาง ให้เลือกจุดลงที่อำเภอละงู จังหวัดสะตูล เมื่อลงรถแล้ว (จุดจอดตรงข้ามธนาคารไทยพานิชน์) นั่งรถสองแถว หรือวินมอไซด์รับจ้าง มาปากบารา'),
            tab('dารเดินทางโดยรถส่วนตัว',
                'จากกรุงเทพฯ ใช้เส้นทางหลวงหมายเลข 4 , ผ่านจังหวัด ประจวบคีรีขันธ์ ชุมพร จากนั้นใช้ทางหลวงหมายเลข 41 ผ่านเข้าเขต จังหวัดนครศรีธรรมราช พัทลุง จากพัทลุงไปอำเภอรัตภูมิ จังหวัดสงขลา ให้ใช้ทางหลวงหมายเลข 4 แล้วแยกขวาไปตามทางหลวงหมายเลข 406 ถึงจังหวัดสตูล ระยะทาง 973 กิโลเมตร สำหรับผู้ที่ต้องการเดินทางไป ยังเกาะหลีเป๊ะเมื่อถึงบริเวณสามแยกฉลุง เลี้ยวขวาไปตามเส้นทาง ฉลุง-ละงู ผ่านอำเภอท่าแพ เข้าสู่ตัวเมืองอำเภอละงู')
          ],
        ),
      ),
    );
  }

  Widget tab(String text, text2) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.deepPurple.shade100,
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(text2),
        ),
      ],
    );
  }
}
