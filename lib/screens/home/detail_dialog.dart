import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

List tradeDetailTitleTexts = ["타이틀", "거래ID", "거래종류", "거래일시", "포인트 변화", "구매자", "구매내역"];
List withDrawDetailTitleTexts = ["타이틀", "거래ID", "거래종류", "거래일시", "포인트 변화", "출금신청 포인트", "출금 수수료", "사업소득세", "출금예정 금액", "출금계좌", "출금상태"];


detailDialog(context, Map detail) { 
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: const Icon(Icons.close)
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detail["title"], style: fontSmallTitle),
                const SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래ID"), Text(detail["id"].toString())]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래종류"), Text(detail["type"])]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("거래일시"), Text(detail["date"].toDate().toString().split(' ')[0])]),
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
                  //   else Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(12),
                  //         child: Column(
                  //           children: [
                  //             for (int i = 5; i < 9; i++)
                  //             createDetailText(withDrawDetailTitleTexts[i], detailValueList[i]),
                  //           ]
                  //         )
                  //       ),
                  //       const SizedBox(height: 10,),
                  //       createDetailText(withDrawDetailTitleTexts[9], ""),
                  //       Padding(
                  //         padding: const EdgeInsets.all(12),
                  //         child: 
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(detailValueList[9][0]),
                  //             const SizedBox(height: 4,),
                  //             Text(detailValueList[9][1]),
                  //           ],
                  //         )
                  //       ),
                  //       const SizedBox(height: 10,),
                  //       createDetailText(withDrawDetailTitleTexts[10], detailValueList[10]),
                  //     ],
                  //   ),
            ]),
          )
          // else Text("작성필요"),
        ]
      )
    )
  );
}

createDetailText(title, value){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ Text(title), Text(value),]);
}