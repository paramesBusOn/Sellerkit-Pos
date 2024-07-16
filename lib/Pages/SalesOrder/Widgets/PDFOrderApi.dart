import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Pages/PrintPDF/pdfApi.dart';

class PdfOrderApiii {
  static int? height;
  static String? remark;
  static double exclTxTotal = 0;
  static double inclTxTotal = 0;
  static double vatTx = 0;

  static Future<File> gennnerate(Invoice invoice) async {
    final pdff = pw.Document();
    pdff.addPage(pw.MultiPage(
        maxPages: 100,
        pageFormat:
            // PdfPageFormat.a4,
            PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm,
                marginAll: 9.0 * PdfPageFormat.mm),

        // build: (pw.Context context) {
        //   return
        //   pw.Center(
        //     child:   invoiceMiddle(invoice),
        //   ); // Center
        // }));
        build: (context) => [
              invoiceMiddle(invoice, context),
            ]));

    return PdffAApi.savveDocument(
        name: "${invoice.invoiceMiddle!.customerName}.pdf", pdf: pdff);
  }

  static Widget invoiceMiddle(Invoice invoice, context) {
    final headers = [
      "S.No",
      "Description",
      "Qty",
      "Unit Price",
      "Disc ",
      "VAT",
      "Net Amount"
    ];
    final data = invoice.items!.map((e) {
      final total = (e.quantity);
      return [
        (e.slNo),
        (e.descripton),
        (e.quantity),
        (e.unitPrice),
        (e.discountamt),
        (e.vat),
        (e.netTotal),
      ];
    }).toList();
    return Wrap(children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Container(
                height: 4 * PdfPageFormat.cm,
                child: Center(
                    child: Text('Tax Invoice',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0)))),
            SizedBox(height: 0.3 * PdfPageFormat.cm),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 9 * PdfPageFormat.cm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sent To:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            SizedBox(height: 0.5 * PdfPageFormat.cm),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${invoice.invoiceMiddle!.customerName}',
                                          style: TextStyle(fontSize: 11.0)),
                                      // Text('PATEL STORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
                                      SizedBox(height: 0.2 * PdfPageFormat.cm),

                                      Text('ZAZNIBAR'),
                                      Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                            Text('TIN No.:'),
                                            Text('127876479'),
                                          ])),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('VAT Reg. No.:'),
                                            Text('07-00513-A'),
                                          ]),
                                    ]))
                          ])),
                  Container(
                      // color: PdfColor.fromHex('0xFF000000'),
                      width: 7.5 * PdfPageFormat.cm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 3 * PdfPageFormat.cm,
                                      child: Text('TIN No. :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0))),
                                  Container(
                                      width: 3.7 * PdfPageFormat.cm,
                                      child: Text('100-230-844',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0)))
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 3 * PdfPageFormat.cm,
                                      child: Text('VAT Reg No. :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0))),
                                  Container(
                                      width: 3.7 * PdfPageFormat.cm,
                                      child: Text('10-011469-I',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0)))
                                ]),
                            SizedBox(height: 0.5 * PdfPageFormat.cm),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 3 * PdfPageFormat.cm,
                                      child: Text('Inv. Number')),
                                  Text(": "),
                                  Container(
                                      width: 4 * PdfPageFormat.cm,
                                      child: Text(invoice.headerinfo!.invNum
                                          .toString()))
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 3 * PdfPageFormat.cm,
                                      child: Text('Inv. Date')),
                                  Text(": "),
                                  Container(
                                      width: 4 * PdfPageFormat.cm,
                                      child: Text(invoice.headerinfo!.invDate
                                          .toString()))
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 3 * PdfPageFormat.cm,
                                      child: Text('Sales Quotation')),
                                  Text(": "),
                                  Container(
                                      width: 4 * PdfPageFormat.cm,
                                      child: Text(invoice.headerinfo!.salesOrder
                                          .toString()))
                                ]),
                            SizedBox(height: 0.4 * PdfPageFormat.cm),
                            Row(children: [
                              Container(
                                  width: 3 * PdfPageFormat.cm,
                                  child: Text('Your Order Ref')),
                              Text(": "),
                              Container(
                                  width: 3.7 * PdfPageFormat.cm,
                                  child: Text(invoice.headerinfo!.ordReference
                                      .toString()))
                            ]),
                          ]))
                ]),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            Table.fromTextArray(
              columnWidths: {
                0: FlexColumnWidth(0.9),
                1: FlexColumnWidth(3.7),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1.2),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1.3),
                6: FlexColumnWidth(1.7),
              },
              headerStyle:
                  TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              cellStyle: TextStyle(
                fontSize: 10.0,
              ),
              headers: headers,
              data: data,
            ),
            SizedBox(height: 0.7 * PdfPageFormat.cm),
            Container(
                width: 15 * PdfPageFormat.cm,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 1.5 * PdfPageFormat.cm,
                          // right: 5 * PdfPageFormat.cm,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Pails:", style: TextStyle()),
                              SizedBox(width: 0.3 * PdfPageFormat.cm),
                              Text("20.00 ", style: TextStyle()),
                            ]),
                      ),
                      Container(
                          child: Row(children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text("Cartons:", style: TextStyle()),
                              SizedBox(height: 0.2 * PdfPageFormat.cm),
                              Text("Loose Tins:", style: TextStyle()),
                            ])),
                        SizedBox(width: 0.3 * PdfPageFormat.cm),
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text("12.00", style: TextStyle()),
                              SizedBox(height: 0.2 * PdfPageFormat.cm),
                              Text("28.00", style: TextStyle()),
                            ]))
                      ])),
                      Container(
                          child: Row(children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text("Total Pack:", style: TextStyle()),
                              SizedBox(width: 0.2 * PdfPageFormat.cm),
                              Text("Tonnage:", style: TextStyle()),
                            ])),
                        SizedBox(width: 0.3 * PdfPageFormat.cm),
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text("60", style: TextStyle()),
                              SizedBox(width: 0.2 * PdfPageFormat.cm),
                              Text("0.79200", style: TextStyle()),
                            ]))
                      ])),
                    ])),
            SizedBox(height: 1.5 * PdfPageFormat.cm),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        SizedBox(height: 0.5 * PdfPageFormat.cm),
                        Container(
                            width: 8 * PdfPageFormat.cm,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 2.4 * PdfPageFormat.cm,
                                              child: Divider(
                                                thickness: 1,
                                              )),
                                          Text("Prepared by",
                                              style: TextStyle()),
                                        ]),
                                  ),
                                  Container(
                                    child: Column(children: [
                                      Container(
                                          width: 2.3 * PdfPageFormat.cm,
                                          child: Divider(
                                            thickness: 1,
                                          )),
                                      Text("Checked by", style: TextStyle()),
                                    ]),
                                  ),
                                  Container(
                                    child: Column(children: [
                                      Container(
                                          width: 2.3 * PdfPageFormat.cm,
                                          child: Divider(
                                            thickness: 1,
                                          )),
                                      Text("Approved by", style: TextStyle()),
                                    ]),
                                  ),
                                ])),
                        SizedBox(height: 0.3 * PdfPageFormat.cm),
                        Text('Received in good order and condition'),
                        SizedBox(height: 0.1 * PdfPageFormat.cm),
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Row(children: [
                                  Text("Date"),
                                  Container(
                                      alignment: Alignment.bottomCenter,
                                      height: 2.3 * PdfPageFormat.cm,
                                      width: 2.3 * PdfPageFormat.cm,
                                      child: Divider(
                                        thickness: 1,
                                      )),
                                ])),
                                SizedBox(width: 0.1 * PdfPageFormat.cm),
                                Container(
                                    child: Row(children: [
                                  Text("Signature"),
                                  Container(
                                      alignment: Alignment.bottomCenter,
                                      height: 2.3 * PdfPageFormat.cm,
                                      width: 2.3 * PdfPageFormat.cm,
                                      child: Divider(
                                        thickness: 1,
                                      )),
                                ])),
                              ]),
                        ),
                      ])),
                  Container(
                      // width: 300,
                      width: 8.3 * PdfPageFormat.cm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text('Total (Excl) Tshs',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                  Text('${exclTxTotal}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                ])),
                            SizedBox(height: 0.7 * PdfPageFormat.cm),
                            Container(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text('VAT Tshs',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                  Text('${vatTx}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                ])),
                            SizedBox(height: 0.4 * PdfPageFormat.cm),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Text('---------------------------')),
                            Container(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //
                                    children: [
                                  Text('Total (Incl) Tshs',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0)),
                                  Text('${inclTxTotal}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0))
                                ])),
                            // SizedBox(height: 0.2 * PdfPageFormat.cm),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Text('---------------------------')),
                          ])),
                ])),
            SizedBox(height: 2 * PdfPageFormat.cm),
            FooterContainer(invoice),
          ])
    ]);
  }

  static FooterContainer(Invoice invoice) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 3 * PdfPageFormat.cm,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('126/20231017'),
                                  Text('90428'),
                                  Text('B06A9F90428'),
                                ])), //0xf00cc qr

                        SizedBox(width: 0.5 * PdfPageFormat.cm),
                        Container(
                            width: 2 * PdfPageFormat.cm,
                            height: 2 * PdfPageFormat.cm,
                            child: BarcodeWidget(
                                data: invoice.headerinfo!.invNum!.toString(),
                                barcode: Barcode.qrCode()))
                        // Container(
                        //     width: 2 * PdfPageFormat.cm,
                        //     child: pw.Icon(
                        //       IconData(0xf00cc),
                        //     )),
                      ])),
              Row(children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TERMS AND CONDITIONS AS STATED OVERLEAF.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.0)),
                          SizedBox(height: 0.4 * PdfPageFormat.cm),
                          Text('Print Status :       Original',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ))
                        ])),
              ])
            ]));
  }

  static Widget inVoiceTable(Invoice invoice) {
    final headers = ["s.No", "Description", "Quantity"];
    final data = invoice.items!.map((e) {
      final total = (e.quantity);
      return [e.slNo, (e.descripton), (e.quantity)];
    }).toList();
    return Table.fromTextArray(headers: headers, data: data);
  }
}

// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
// import 'package:posproject/Pages/PrintPDF/invoice.dart';
// import 'package:posproject/Pages/PrintPDF/pdfApi.dart';

// class PdfOrderApiii {
//   static int? height;
//   static String? remark;
//   static double exclTxTotal = 0;
//   static double inclTxTotal = 0;
//   static double vatTx = 0;

//   static Future<File> gennnerate(Invoice invoice) async {
//     final pdff = pw.Document();
//     pdff.addPage(pw.MultiPage(
//         maxPages: 100,
//         pageFormat: 
//         // PdfPageFormat.a4,
//         PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginAll: 9.0 * PdfPageFormat.mm),

//         // PdfPageFormat(15 * PdfPageFormat.cm, height! * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),

//         // build: (pw.Context context) {
//         //   return
//         //   pw.Center(
//         //     child:   invoiceMiddle(invoice),
//         //   ); // Center
//         // }));
//         build: (context) => [
//               invoiceMiddle(invoice),
//             ]));

//     return PdffAApi.savveDocument(name: "${invoice.invoiceMiddle!.customerName}.pdf", pdf: pdff);
//   }

//   static Widget invoiceMiddle(Invoice invoice) {
//     final headers = ["S.No", "Description", "Qty", "Unit Price", "Disc ", "VAT", "Net Amount"];
//     final data = invoice.items!.map((e) {
//       final total = (e.quantity);
//       return [
//         e.slNo,
//         (e.descripton),
//         (e.quantity),
//         (e.unitPrice),
//         (e.dics),
//         (e.vat),
//         (e.netTotal),
//       ];
//     }).toList();
//     return Wrap(children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//         Center(child: Text('Tax Invoice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
//         SizedBox(height: 0.8 * PdfPageFormat.cm),
//         Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Container(
//               width: 8 * PdfPageFormat.cm,
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Text('Sent To:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
//                 SizedBox(height: 0.5 * PdfPageFormat.cm),
//                 Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 2,
//                       ),
//                       shape: BoxShape.rectangle,
//                     ),
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                       Text('${invoice.invoiceMiddle!.customerName}', style: TextStyle(fontSize: 11.0)),
//                       // Text('PATEL STORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//                       SizedBox(height: 0.2 * PdfPageFormat.cm),

//                       Text('ZAZNIBAR'),
//                       Container(
//                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                         Text('TIN No.:'),
//                         Text('127876479'),
//                       ])),
//                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                         Text('VAT Reg. No.:'),
//                         Text('07-00513-A'),
//                       ]),
//                     ]))
//               ])),
//           Container(
//               // color: PdfColor.fromHex('0xFF000000'),
//               width: 6.8 * PdfPageFormat.cm,
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(width: 2.8 * PdfPageFormat.cm, child: Text('TIN No.:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0))), Text('100-230-844', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0))]),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [Container(width: 2.8 * PdfPageFormat.cm, child: Text('VAT Reg No.:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0))), Text('10-011469-I', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0))]),
//                 SizedBox(height: 0.5 * PdfPageFormat.cm),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(width: 3 * PdfPageFormat.cm, child: Text('Inv. Number')), Text(": "), Container(width: 3.7 * PdfPageFormat.cm, child: Text(invoice.headerinfo!.invNum.toString()))]),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(width: 3 * PdfPageFormat.cm, child: Text('Inv. Date')), Text(": "), Container(width: 3.7 * PdfPageFormat.cm, child: Text(invoice.headerinfo!.invDate.toString()))]),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(width: 3 * PdfPageFormat.cm, child: Text('Sales Order')), Text(": "), Container(width: 3.7 * PdfPageFormat.cm, child: Text('7871'))]),
//                 SizedBox(height: 0.4 * PdfPageFormat.cm),
//                 Row(children: [Container(width: 3 * PdfPageFormat.cm, child: Text('Your Order Ref')), Text(": "), Container(width: 3.7 * PdfPageFormat.cm, child: Text(invoice.headerinfo!.ordReference.toString()))]),
//               ]))
//         ]),
//         SizedBox(height: 0.4 * PdfPageFormat.cm),
//         Table.fromTextArray(
//           columnWidths: {
//             0: FlexColumnWidth(0.9),
//             1: FlexColumnWidth(3.7),
//             2: FlexColumnWidth(1),
//             3: FlexColumnWidth(1.4),
//             4: FlexColumnWidth(1),
//             5: FlexColumnWidth(1.3),
//             6: FlexColumnWidth(1.5),
//           },
//           headerStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
//           cellStyle: TextStyle(
//             fontSize: 10.0,
//           ),
//           headers: headers,
//           data: data,
//         ),
//         SizedBox(height: 0.5 * PdfPageFormat.cm),
//         Container(
//             width: 15 * PdfPageFormat.cm,
//             child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 1.5 * PdfPageFormat.cm,
//                   // right: 5 * PdfPageFormat.cm,
//                 ),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                   Text("Pails:", style: TextStyle()),
//                   SizedBox(width: 0.3 * PdfPageFormat.cm),
//                   Text("20.00 ", style: TextStyle()),
//                 ]),
//               ),
//               Container(
//                   child: Row(children: [
//                 Container(
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text("Cartons:", style: TextStyle()),
//                   SizedBox(height: 0.2 * PdfPageFormat.cm),
//                   Text("Loose Tins:", style: TextStyle()),
//                 ])),
//                 SizedBox(width: 0.3 * PdfPageFormat.cm),
//                 Container(
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text("12.00", style: TextStyle()),
//                   SizedBox(height: 0.2 * PdfPageFormat.cm),
//                   Text("28.00", style: TextStyle()),
//                 ]))
//               ])),
//               Container(
//                   child: Row(children: [
//                 Container(
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text("Total Pack:", style: TextStyle()),
//                   SizedBox(width: 0.2 * PdfPageFormat.cm),
//                   Text("Tonnage:", style: TextStyle()),
//                 ])),
//                 SizedBox(width: 0.3 * PdfPageFormat.cm),
//                 Container(
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text("60", style: TextStyle()),
//                   SizedBox(width: 0.2 * PdfPageFormat.cm),
//                   Text("0.79200", style: TextStyle()),
//                 ]))
//               ])),
//             ])),
//         SizedBox(height: 0.6 * PdfPageFormat.cm),
//         Container(
//             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             SizedBox(height: 0.5 * PdfPageFormat.cm),
//             Container(
//                 width: 8 * PdfPageFormat.cm,
//                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                   Container(
//                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
//                       Container(
//                           width: 2.4 * PdfPageFormat.cm,
//                           child: Divider(
//                             thickness: 1,
//                           )),
//                       Text("Prepared by", style: TextStyle()),
//                     ]),
//                   ),
//                   Container(
//                     child: Column(children: [
//                       Container(
//                           width: 2.3 * PdfPageFormat.cm,
//                           child: Divider(
//                             thickness: 1,
//                           )),
//                       Text("Checked by", style: TextStyle()),
//                     ]),
//                   ),
//                   Container(
//                     child: Column(children: [
//                       Container(
//                           width: 2.3 * PdfPageFormat.cm,
//                           child: Divider(
//                             thickness: 1,
//                           )),
//                       Text("Approved by", style: TextStyle()),
//                     ]),
//                   ),
//                 ])),
//             SizedBox(height: 0.2 * PdfPageFormat.cm),
//             Text('Received in good order and condition'),
//             SizedBox(height: 0.1 * PdfPageFormat.cm),
//             Container(
//               child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Container(
//                     child: Row(children: [
//                   Text("Date"),
//                   Container(
//                       alignment: Alignment.bottomCenter,
//                       height: 30,
//                       width: 2.3 * PdfPageFormat.cm,
//                       child: Divider(
//                         thickness: 1,
//                       )),
//                 ])),
//                 SizedBox(width: 0.1 * PdfPageFormat.cm),
//                 Container(
//                     child: Row(children: [
//                   Text("Signature"),
//                   Container(
//                       alignment: Alignment.bottomCenter,
//                       height: 30,
//                       width: 2.3 * PdfPageFormat.cm,
//                       child: Divider(
//                         thickness: 1,
//                       )),
//                 ])),
//               ]),
//             ),
//           ])),
//           Container(
//               // width: 300,
//               width: 8.3 * PdfPageFormat.cm,
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Container(
//                     child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                   Text('Total (Excl) Tshs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
//                   Text('${exclTxTotal}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
//                 ])),
//                 SizedBox(height: 0.7 * PdfPageFormat.cm),
//                 Container(
//                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                   Text('VAT Tshs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
//                   Text('${vatTx}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
//                 ])),
//                 SizedBox(height: 0.4 * PdfPageFormat.cm),
//                 Container(alignment: Alignment.centerRight, child: Text('---------------------------')),
//                 Container(child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //
//                     children: [Text('Total (Incl) Tshs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)), Text('${inclTxTotal}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0))])),
//                 // SizedBox(height: 0.2 * PdfPageFormat.cm),
//                 Container(alignment: Alignment.centerRight, child: Text('---------------------------')),
//               ])),
//         ])),
//         SizedBox(height: 6 * PdfPageFormat.cm),
//         Container(
//             // height: 2 * PdfPageFormat.cm,
//             alignment: Alignment.bottomCenter,
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               Container(
//                   // width: 4.3 * PdfPageFormat.cm,
//                   alignment: Alignment.centerRight,
//                   child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end, children: [
//                     Container(
//                         //  width: 4.3 * PdfPageFormat.cm,
//                         child: Column(children: [
//                       Text('126/20231017'),
//                       Text('90428'),
//                       Text('B06A9F90428'),
//                     ])), //0xf00cc qr
//                     Container(width: 2 * PdfPageFormat.cm, height: 2 * PdfPageFormat.cm, child: BarcodeWidget(data: invoice.headerinfo!.invNum!.toString(), barcode: Barcode.qrCode()))
//                   ])),
//               Row(children: [
//                 Container(
//                     alignment: Alignment.bottomCenter,
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                       Text("TERMS AND CONDITIONS AS STATED OVERLEAF.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0)),
//                       SizedBox(height: 0.4 * PdfPageFormat.cm),
//                       Text('Print Status :       Orginal',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.0,
//                           ))
//                     ])),
//               ])
//             ])),
//       ])
//     ]);
//   }

//   static Widget inVoiceTable(Invoice invoice) {
//     final headers = ["s.No", "Description", "Quantity"];
//     final data = invoice.items!.map((e) {
//       final total = (e.quantity);
//       return [e.slNo, (e.descripton), (e.quantity)];
//     }).toList();
//     return Table.fromTextArray(headers: headers, data: data);
//   }
// }
