import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

detailDialog(context, Map detail) { 
  return showDialog(context: context,
    builder: (BuildContext context) => 
      Dialog.fullscreen(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: const Icon(Icons.close)),
          Padding(padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detail["title"], style: fontSmallTitle),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래ID"), Text(detail["id"].toString())]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래종류"), Text(detail["type"])]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래일시"), Text(detail["date"].toDate().toString().split('.')[0])]),
                const SizedBox(height: 16,),
                const Divider(color: Colors.black54,),
                const SizedBox(height: 16,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("포인트 변화"), Text("${(detail["point"] >0)?'+':'-'} ${detail["point"].toString()} P")]),
                if (detail["type"] == "리워드")
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("구매자"), Text(detail["buyer"])]),
                      const SizedBox(height: 28,),
                      Text("구매내역"), 
                      const SizedBox(height: 20,),
                      for (int i = 0; i < detail["info"].length; i++)
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text("•   ${detail["info"][i]}"))
                    ],
                  )
                else if(detail["type"] == "출금")
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.all(12),
                        child: Column(children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("출금신청 포인트"), Text(detail["withdraw"].toString())]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("출금 수수료"), Text(detail["fee"].toString())]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("사업소득세"), Text(detail["tax"].toString())]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("출금예정 금액"), Text(detail["amount"].toString())]),
                      ])),
                      const SizedBox(height: 10),
                      Text("출금계좌"),
                      Padding(padding: const EdgeInsets.all(12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detail["account"][0]),
                            const SizedBox(height: 4,),
                            Text(detail["account"][1]),
                      ])),
                      const SizedBox(height: 10,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("출금상태"), Text(detail["status"])]),
                  ]),
          ]))
      ])
    )
  );
}