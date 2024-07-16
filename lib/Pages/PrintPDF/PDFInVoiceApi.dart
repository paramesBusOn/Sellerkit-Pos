// // ignore_for_file: prefer_const_constructors

// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:printing/printing.dart';

class PdfInvoiceApiii extends StatelessWidget {
  PdfInvoiceApiii(this.title, this.theme, {Key? key}) : super(key: key);

  final String title;
  Configure config = Configure();

  final ThemeData theme;
  static Invoice? iinvoicee;
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static int? pails = 0;
  static int? cartons = 0;
  static double? looseTins = 0;
  static double? tonnage = 0;
  static var totalPack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        build: (format) => createPdfFile(theme),

        //createTable
      ),
    );
  }

  Future<Uint8List> createPdfFile(ThemeData theme) {
    var pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginAll: 2.0 * PdfPageFormat.cm),
        // PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            headerContianer(),
            createTable(
              theme,
            ),
            calculationWork(),
            FooterContainer(iinvoicee!),
          ];
        }));
    return pdf.save();
  }

  static headerContianer() {
    return pw.Container(
      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, mainAxisSize: pw.MainAxisSize.min, children: [
        pw.Container(
            // color: PdfColors.red,
            child: pw.Column(
          children: [
            pw.Container(height: 3 * PdfPageFormat.cm, child: pw.Center(child: pw.Text('Tax Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20.0)))),
            pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Container(
                  width: 9 * PdfPageFormat.cm,
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                    pw.Text('Sent To:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                    pw.Container(
                        padding: pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            width: 1,
                          ),
                          shape: pw.BoxShape.rectangle,
                        ),
                        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                          pw.Text('${iinvoicee!.invoiceMiddle!.customerName}',
                              style: pw.TextStyle(
                                fontSize: 11.0,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          // pw.Text('PATEL STORE', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
                          pw.SizedBox(height: 0.2 * PdfPageFormat.cm),

                          pw.Text('ZAZNIBAR',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                              )),
                          pw.Container(
                              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                            pw.Text('TIN No.:',
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                )),
                            pw.Text('127876479',
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                )),
                          ])),
                          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                            pw.Text('VAT Reg. No.:',
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                )),
                            pw.Text('07-00513-A',
                                style: pw.TextStyle(
                                  fontSize: 10.0,
                                )),
                          ]),
                        ]))
                  ])),
              pw.Container(
                  width: 7.5 * PdfPageFormat.cm,
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('TIN No. :', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))),
                      pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('100-230-844', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)))
                    ]),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('VAT Reg No. :', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))),
                      pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('10-011469-I', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)))
                    ]),
                    pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Container(
                          width: 3.5 * PdfPageFormat.cm,
                          child: pw.Text('Inv. Number',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                              ))),
                      pw.Text(": "),
                      pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invNum.toString()))
                    ]),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Container(
                          width: 3.5 * PdfPageFormat.cm,
                          child: pw.Text('Inv. Date',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                              ))),
                      pw.Text(": "),
                      pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invDate.toString()))
                    ]),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Container(
                          width: 3.5 * PdfPageFormat.cm,
                          child: pw.Text('Sales Order',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                              ))),
                      pw.Text(": "),
                      pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.salesOrder != null ? iinvoicee!.headerinfo!.salesOrder.toString() : ''))
                    ]),
                    pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
                    pw.Row(children: [
                      pw.Container(
                          width: 3.5 * PdfPageFormat.cm,
                          child: pw.Text('Your Order Ref',
                              style: pw.TextStyle(
                                fontSize: 10.0,
                              ))),
                      pw.Text(": "),
                      pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.ordReference.toString()))
                    ]),
                  ]))
            ]),
          ],
        )),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
      ]),
    );
  }
  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (pw.Context context) {
  // return
  // final headers = ["S.No", "Description", "Qty", "Unit Price", "Disc ", "VAT", "Net Amount"];
  // final data = iinvoicee!.items!.map((e) {
  //   final total = (e.quantity);
  //   return [
  //     (e.slNo),
  //     (e.descripton),
  //     (e.quantity),
  //     (e.unitPrice),
  //     (e.discountamt),
  //     (e.vat),
  //     (e.netTotal),
  //   ];
  // }).toList();
  // return
  // pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
  //   pw.SizedBox(height: 1 * PdfPageFormat.cm),
  // pw.Container(height: 4 * PdfPageFormat.cm, child: pw.Center(child: pw.Text('Tax Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22.0)))),
  // pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
  // pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //   pw.Container(
  //       width: 9 * PdfPageFormat.cm,
  //       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //         pw.Text('Sent To:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 10.0)),
  //         pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
  //         pw.Container(
  //             padding: pw.EdgeInsets.all(10),
  //             decoration: pw.BoxDecoration(
  //               border: pw.Border.all(
  //                 width: 2,
  //               ),
  //               shape: pw.BoxShape.rectangle,
  //             ),
  //             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //               pw.Text('${iinvoicee!.invoiceMiddle!.customerName}', style: pw.TextStyle(fontSize: 11.0)),
  //               // pw.Text('PATEL STORE', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
  //               pw.SizedBox(height: 0.2 * PdfPageFormat.cm),

  //               pw.Text('ZAZNIBAR'),
  //               pw.Container(
  //                   child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //                 pw.Text('TIN No.:'),
  //                 pw.Text('127876479'),
  //               ])),
  //               pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //                 pw.Text('VAT Reg. No.:'),
  //                 pw.Text('07-00513-A'),
  //               ]),
  //             ]))
  //       ])),
  //   pw.Container(
  //       width: 7.5 * PdfPageFormat.cm,
  //       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('TIN No. :', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))),
  //           pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('100-230-844', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)))
  //         ]),
  //         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('VAT Reg No. :', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))),
  //           pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('10-011469-I', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)))
  //         ]),
  //         pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
  //         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Inv. Number')), pw.Text(": "), pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invNum.toString()))]),
  //         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Inv. Date')), pw.Text(": "), pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invDate.toString()))]),
  //         pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Sales Order')), pw.Text(": "), pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.salesOrder.toString()))]),
  //         pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
  //         pw.Row(children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Your Order Ref')), pw.Text(": "), pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.ordReference.toString()))]),
  //       ]))
  // ]),
  // pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
  // // Table.fromTextArray(
  // //   pw.ColumnWidths: {
  // //     0: Flexpw.ColumnWidth(0.9),
  // //     1: Flexpw.ColumnWidth(3.7),
  // //     2: Flexpw.ColumnWidth(1),
  // //     3: Flexpw.ColumnWidth(1.2),
  // //     4: Flexpw.ColumnWidth(1),
  // //     5: Flexpw.ColumnWidth(1.3),
  // //     6: Flexpw.ColumnWidth(1.7),
  // //   },
  // //   headerStyle:pw.TextStyle(fontSize: 10.0, fontWeight:pw.FontWeight.bold),
  // //   cellStyle:pw.TextStyle(
  // //     fontSize: 10.0,
  // //   ),
  // //   headers: headers,
  // //   data: data,
  // // ),
  // pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
  // pw.Container(
  //     width: 15 * PdfPageFormat.cm,
  //     child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //       pw.Container(
  //         padding: pw.EdgeInsets.only(
  //           left: 1.5 * PdfPageFormat.cm,
  //           // right: 5 * PdfPageFormat.cm,
  //         ),
  //         child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Text("Pails:", style: pw.TextStyle()),
  //           pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
  //           pw.Text("20.00 ", style: pw.TextStyle()),
  //         ]),
  //       ),
  //       pw.Container(
  //           child: pw.Row(children: [
  //         pw.Container(
  //             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text("Cartons:", style: pw.TextStyle()),
  //           pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
  //           pw.Text("Loose Tins:", style: pw.TextStyle()),
  //         ])),
  //         pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
  //         pw.Container(
  //             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text("12.00", style: pw.TextStyle()),
  //           pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
  //           pw.Text("28.00", style: pw.TextStyle()),
  //         ]))
  //       ])),
  //       pw.Container(
  //           child: pw.Row(children: [
  //         pw.Container(
  //             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text("Total Pack:", style: pw.TextStyle()),
  //           pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
  //           pw.Text("Tonnage:", style: pw.TextStyle()),
  //         ])),
  //         pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
  //         pw.Container(
  //             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //           pw.Text("60", style: pw.TextStyle()),
  //           pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
  //           pw.Text("0.79200", style: pw.TextStyle()),
  //         ]))
  //       ])),
  //     ])),
  // pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
  // pw.Container(
  //     child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //   pw.Container(
  //       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //     pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
  //     pw.Container(
  //         width: 8 * PdfPageFormat.cm,
  //         child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Container(
  //             child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //               pw.Container(
  //                   width: 2.4 * PdfPageFormat.cm,
  //                   child: pw.Divider(
  //                     thickness: 1,
  //                   )),
  //               pw.Text("Prepared by", style: pw.TextStyle()),
  //             ]),
  //           ),
  //           pw.Container(
  //             child: pw.Column(children: [
  //               pw.Container(
  //                   width: 2.3 * PdfPageFormat.cm,
  //                   child: pw.Divider(
  //                     thickness: 1,
  //                   )),
  //               pw.Text("Checked by", style: pw.TextStyle()),
  //             ]),
  //           ),
  //           pw.Container(
  //             child: pw.Column(children: [
  //               pw.Container(
  //                   width: 2.3 * PdfPageFormat.cm,
  //                   child: pw.Divider(
  //                     thickness: 1,
  //                   )),
  //               pw.Text("Approved by", style: pw.TextStyle()),
  //             ]),
  //           ),
  //         ])),
  //     pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
  //     pw.Text('Received in good order and condition'),
  //     pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
  //     pw.Container(
  //       child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //         pw.Container(
  //             child: pw.Row(children: [
  //           pw.Text("Date"),
  //           pw.Container(
  //               alignment: pw.Alignment.bottomCenter,
  //               height: 2.3 * PdfPageFormat.cm,
  //               width: 2.3 * PdfPageFormat.cm,
  //               child: pw.Divider(
  //                 thickness: 1,
  //               )),
  //         ])),
  //         pw.SizedBox(width: 0.1 * PdfPageFormat.cm),
  //         pw.Container(
  //             child: pw.Row(children: [
  //           pw.Text("Signature"),
  //           pw.Container(
  //               alignment: pw.Alignment.bottomCenter,
  //               height: 2.3 * PdfPageFormat.cm,
  //               width: 2.3 * PdfPageFormat.cm,
  //               child: pw.Divider(
  //                 thickness: 1,
  //               )),
  //         ])),
  //       ]),
  //     ),
  //   ])),
  //   pw.Container(
  //       // width: 300,
  //       width: 8.3 * PdfPageFormat.cm,
  //       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //         pw.Container(
  //             child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Text('Total (Excl) Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
  //           pw.Text('${'exclTxTotal'}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
  //         ])),
  //         pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
  //         pw.Container(
  //             child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
  //           pw.Text('VAT Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
  //           pw.Text('${'vatTx'}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
  //         ])),
  //         pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
  //         pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('---------------------------')),
  //         pw.Container(child: pw.Row(
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             //
  //             children: [pw.Text('Total (Incl) Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)), pw.Text('${'inclTxTotal'}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))])),
  //         //pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
  //         pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('---------------------------')),
  //       ])),
  // ])),
  // pw.SizedBox(height: 2 * PdfPageFormat.cm),
  // // FooterContainer(invoice),
  // ]);
  //   ];
//         },
//       ),
//     );

//     return pdf.save();
//   }
// }

// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/iinvoicee!.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/pdfApi.dart';

// class PdfInvoiceApiii extends StatelessWidget {
//    PdfInvoiceApiii({super.key});
// static int? height;
//   static String? remark;
//   static double exclTxTotal = 0;
//   static double inclTxTotal = 0;
//   static double vatTx = 0;

//   @override
//   Widget build(BuildContext context) {
//     return  Placeholder();
//   }

//   static Future<File> gennnerate(Invoice invoice) async {

//     final pdff = pw.Document();
//     pdff.addPage(pw.MultiPage(
//         maxPages: 100,
//         pageFormat:
//             // PdfPageFormat.a4,
//             PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginAll: 9.0 * PdfPageFormat.mm),
//         build: (context) => [
//               invoiceMiddle(invoice, context),
//             ]));

//     return PdffAApi.savveDocument(name: "${iinvoicee!.invoiceMiddle!.customerName}.pdf", pdf: pdff);
//   }

// static Widget invoiceMiddle(Invoice invoice, context) {
// final headers = ["S.No", "Description", "Qty", "Unit Price", "Disc ", "VAT", "Net Amount"];
// final data = iinvoicee!.items!.map((e) {
//   final total = (e.quantity);
//   return [
//     (e.slNo),
//     (e.descripton),
//     (e.quantity),
//     (e.unitPrice),
//     (e.discountamt),
//     (e.vat),
//     (e.netTotal),
//   ];
// }).toList();
// return Wrap(children: [
//   pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceEvenly, children: [
//    pw.SizedBox(height: 1 * PdfPageFormat.cm),
//    pw.Container(height: 4 * PdfPageFormat.cm, child: Center(child: pw.Text('Tax Invoice', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 22.0)))),
//    pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
//    pw.Row(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//      pw.Container(
//           width: 9 * PdfPageFormat.cm,
//           child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//             pw.Text('Sent To:', style:pw.TextStyle(fontWeight:pw.FontWeight.bold,fontSize: 10.0)),
//            pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
//            pw.Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                   ),
//                   shape: BoxShape.rectangle,
//                 ),
//                 child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//                   pw.Text('${iinvoicee!.invoiceMiddle!.customerName}', style:pw.TextStyle(fontSize: 11.0)),
//                   // pw.Text('PATEL STORE', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
//                  pw.SizedBox(height: 0.2 * PdfPageFormat.cm),

//                   pw.Text('ZAZNIBAR'),
//                  pw.Container(
//                       child:pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//                     pw.Text('TIN No.:'),
//                     pw.Text('127876479'),
//                   ])),
//                  pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//                     pw.Text('VAT Reg. No.:'),
//                     pw.Text('07-00513-A'),
//                   ]),
//                 ]))
//           ])),
//      pw.Container(
//           width: 7.5 * PdfPageFormat.cm,
//           child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//            pw.Row(
//                mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,
//                 children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('TIN No. :', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0))),pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('100-230-844', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)))]),
//            pw.Row(
//                mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,
//                 children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('VAT Reg No. :', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0))),pw.Container(width: 3.7 * PdfPageFormat.cm, child: pw.Text('10-011469-I', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)))]),
//            pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
//            pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Inv. Number')), pw.Text(": "),pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invNum.toString()))]),
//            pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Inv. Date')), pw.Text(": "),pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.invDate.toString()))]),
//            pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Sales Order')), pw.Text(": "),pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.salesOrder.toString()))]),
//            pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//            pw.Row(children: [pw.Container(width: 3.5 * PdfPageFormat.cm, child: pw.Text('Your Order Ref')), pw.Text(": "),pw.Container(width: 4 * PdfPageFormat.cm, child: pw.Text(iinvoicee!.headerinfo!.ordReference.toString()))]),
//           ]))
//     ]),
//    pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//     // Table.fromTextArray(
//     //   pw.ColumnWidths: {
//     //     0: Flexpw.ColumnWidth(0.9),
//     //     1: Flexpw.ColumnWidth(3.7),
//     //     2: Flexpw.ColumnWidth(1),
//     //     3: Flexpw.ColumnWidth(1.2),
//     //     4: Flexpw.ColumnWidth(1),
//     //     5: Flexpw.ColumnWidth(1.3),
//     //     6: Flexpw.ColumnWidth(1.7),
//     //   },
//     //   headerStyle:pw.TextStyle(fontSize: 10.0, fontWeight:pw.FontWeight.bold),
//     //   cellStyle:pw.TextStyle(
//     //     fontSize: 10.0,
//     //   ),
//     //   headers: headers,
//     //   data: data,
//     // ),
//    pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
//    pw.Container(
//         width: 15 * PdfPageFormat.cm,
//         child:pw.Row(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//          pw.Container(
//             padding: EdgeInsets.only(
//               left: 1.5 * PdfPageFormat.cm,
//               // right: 5 * PdfPageFormat.cm,
//             ),
//             child:pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//               pw.Text("Pails:", style:pw.TextStyle()),
//              pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
//               pw.Text("20.00 ", style:pw.TextStyle()),
//             ]),
//           ),
//          pw.Container(
//               child:pw.Row(children: [
//            pw.Container(
//                 child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//               pw.Text("Cartons:", style:pw.TextStyle()),
//              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
//               pw.Text("Loose Tins:", style:pw.TextStyle()),
//             ])),
//            pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
//            pw.Container(
//                 child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//               pw.Text("12.00", style:pw.TextStyle()),
//              pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
//               pw.Text("28.00", style:pw.TextStyle()),
//             ]))
//           ])),
//          pw.Container(
//               child:pw.Row(children: [
//            pw.Container(
//                 child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//               pw.Text("Total Pack:", style:pw.TextStyle()),
//              pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
//               pw.Text("Tonnage:", style:pw.TextStyle()),
//             ])),
//            pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
//            pw.Container(
//                 child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//               pw.Text("60", style:pw.TextStyle()),
//              pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
//               pw.Text("0.79200", style:pw.TextStyle()),
//             ]))
//           ])),
//         ])),
//    pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
//    pw.Container(
//         child:pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,pw.CrossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//      pw.Container(
//           child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
//        pw.Container(
//             width: 8 * PdfPageFormat.cm,
//             child:pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//              pw.Container(
//                 child: pw.Column(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,pw.CrossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//                  pw.Container(
//                       width: 2.4 * PdfPageFormat.cm,
//                       child: Divider(
//                         thickness: 1,
//                       )),
//                   pw.Text("Prepared by", style:pw.TextStyle()),
//                 ]),
//               ),
//              pw.Container(
//                 child: pw.Column(children: [
//                  pw.Container(
//                       width: 2.3 * PdfPageFormat.cm,
//                       child: Divider(
//                         thickness: 1,
//                       )),
//                   pw.Text("Checked by", style:pw.TextStyle()),
//                 ]),
//               ),
//              pw.Container(
//                 child: pw.Column(children: [
//                  pw.Container(
//                       width: 2.3 * PdfPageFormat.cm,
//                       child: Divider(
//                         thickness: 1,
//                       )),
//                   pw.Text("Approved by", style:pw.TextStyle()),
//                 ]),
//               ),
//             ])),
//        pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
//         pw.Text('Received in good order and condition'),
//        pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
//        pw.Container(
//           child:pw.Row(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//            pw.Container(
//                 child:pw.Row(children: [
//               pw.Text("Date"),
//              pw.Container(
//                   alignment: Alignment.bottomCenter,
//                   height: 2.3 * PdfPageFormat.cm,
//                   width: 2.3 * PdfPageFormat.cm,
//                   child: Divider(
//                     thickness: 1,
//                   )),
//             ])),
//            pw.SizedBox(width: 0.1 * PdfPageFormat.cm),
//            pw.Container(
//                 child:pw.Row(children: [
//               pw.Text("Signature"),
//              pw.Container(
//                   alignment: Alignment.bottomCenter,
//                   height: 2.3 * PdfPageFormat.cm,
//                   width: 2.3 * PdfPageFormat.cm,
//                   child: Divider(
//                     thickness: 1,
//                   )),
//             ])),
//           ]),
//         ),
//       ])),
//      pw.Container(
//           // width: 300,
//           width: 8.3 * PdfPageFormat.cm,
//           child: pw.Column(crossAxisAlignment:pw.CrossAxisAlignment.start, children: [
//            pw.Container(
//                 child:pw.Row(crossAxisAlignment:pw.CrossAxisAlignment.start,mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//               pw.Text('Total (Excl) Tshs', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
//               pw.Text('${'exclTxTotal'}', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
//             ])),
//            pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
//            pw.Container(
//                 child:pw.Row(mainAxisAlignment:pw.MainAxisAlignment.spaceBetween, children: [
//               pw.Text('VAT Tshs', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
//               pw.Text('${'vatTx'}', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)),
//             ])),
//            pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//            pw.Container(alignment: Alignment.centerRight, child: pw.Text('---------------------------')),
//            pw.Container(child:pw.Row(
//                mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,
//                 //
//                 children: [pw.Text('Total (Incl) Tshs', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0)), pw.Text('${inclTxTotal}', style:pw.TextStyle(fontWeight:pw.FontWeight.bold, fontSize: 10.0))])),
//             //pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
//            pw.Container(alignment: Alignment.centerRight, child: pw.Text('---------------------------')),
//           ])),
//     ])),
//    pw.SizedBox(height: 2 * PdfPageFormat.cm),
//     // FooterContainer(invoice),
//   ])
// ]);
// }

  static FooterContainer(Invoice invoice) {
    return pw.Container(
        alignment: pw.Alignment.bottomCenter,
        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.SizedBox(height: 2 * PdfPageFormat.cm),
          pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.end, mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Container(
                    width: 3 * PdfPageFormat.cm,
                    child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
                      pw.Text('126/20231017', style: pw.TextStyle(fontSize: 10)),
                      pw.Text('90428', style: pw.TextStyle(fontSize: 10)),
                      pw.Text('B06A9F90428', style: pw.TextStyle(fontSize: 10)),
                    ])), //0xf00cc qr

                pw.SizedBox(width: 0.5 * PdfPageFormat.cm),
                pw.Container(width: 2 * PdfPageFormat.cm, height: 2 * PdfPageFormat.cm, child: pw.BarcodeWidget(data: iinvoicee!.headerinfo!.invNum!.toString(), barcode: pw.Barcode.qrCode()))
              ])),
          pw.Row(children: [
            pw.Container(
                alignment: pw.Alignment.bottomCenter,
                child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Text("TERMS AND CONDITIONS AS STATED OVERLEAF.", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
                  pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
                  pw.Container(child: pw.Row(children: [pw.Text('Print Status : '), pw.Text(' Original', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0, color: PdfColors.red))])),
                ])),
          ])
        ]));
  }

  static calculationWork() {
    Configure config = Configure();

    return pw.Container(
        child: pw.Column(children: [
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Container(
          width: 15 * PdfPageFormat.cm,
          child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Container(
              padding: pw.EdgeInsets.only(
                left: 1.5 * PdfPageFormat.cm,
                // right: 5 * PdfPageFormat.cm,
              ),
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Text("Pails:", style: pw.TextStyle()),
                pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
                pw.Text("${pails} ", style: pw.TextStyle()),
              ]),
            ),
            pw.Container(
                child: pw.Row(children: [
              pw.Container(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("Cartons:", style: pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
                pw.Text("Loose Tins:", style: pw.TextStyle(fontSize: 10)),
              ])),
              pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
              pw.Container(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("${cartons}", style: pw.TextStyle(fontSize: 10)),
                pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
                pw.Text("${looseTins}", style: pw.TextStyle(fontSize: 10)),
              ]))
            ])),
            pw.Container(
                child: pw.Row(children: [
              pw.Container(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("Total Pack:", style: pw.TextStyle(fontSize: 10)),
                pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
                pw.Text("Tonnage:", style: pw.TextStyle(fontSize: 10)),
              ])),
              pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
              pw.Container(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text("${totalPack}", style: pw.TextStyle(fontSize: 10)),
                pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
                pw.Text(config.splitValues(tonnage!.toStringAsFixed(2)), style: pw.TextStyle(fontSize: 10)),
              ]))
            ])),
          ])),
      pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
      pw.Container(
          child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Container(
            // color: PdfColors.blue,
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
          pw.Container(
              width: 8 * PdfPageFormat.cm,
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Container(
                  child: pw.Column(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                    pw.Container(
                        width: 2.4 * PdfPageFormat.cm,
                        child: pw.Divider(
                          thickness: 1,
                        )),
                    pw.Text("Prepared by", style: pw.TextStyle(fontSize: 10)),
                  ]),
                ),
                pw.Container(
                  child: pw.Column(children: [
                    pw.Container(
                        width: 2.3 * PdfPageFormat.cm,
                        child: pw.Divider(
                          thickness: 1,
                        )),
                    pw.Text("Checked by", style: pw.TextStyle(fontSize: 10)),
                  ]),
                ),
                pw.Container(
                  child: pw.Column(children: [
                    pw.Container(
                        width: 2.3 * PdfPageFormat.cm,
                        child: pw.Divider(
                          thickness: 1,
                        )),
                    pw.Text("Approved by", style: pw.TextStyle(fontSize: 10)),
                  ]),
                ),
              ])),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Text('Received in good order and condition', style: pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
          pw.Container(
            child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Container(
                  child: pw.Row(children: [
                pw.Text("Date", style: pw.TextStyle(fontSize: 10)),
                pw.Container(
                    alignment: pw.Alignment.bottomCenter,
                    height: 2.3 * PdfPageFormat.cm,
                    width: 2.3 * PdfPageFormat.cm,
                    child: pw.Divider(
                      thickness: 1,
                    )),
              ])),
              pw.SizedBox(width: 0.1 * PdfPageFormat.cm),
              pw.Container(
                  child: pw.Row(children: [
                pw.Text("Signature", style: pw.TextStyle(fontSize: 10)),
                pw.Container(
                    alignment: pw.Alignment.bottomCenter,
                    height: 2.3 * PdfPageFormat.cm,
                    width: 2.3 * PdfPageFormat.cm,
                    child: pw.Divider(
                      thickness: 1,
                    )),
              ])),
            ]),
          ),
        ])),
        pw.Container(
            // color: PdfColors.blue,
            width: 9 * PdfPageFormat.cm,
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Container(
                  child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Text('Total (Excl) Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
                pw.Text(config.splitValues(exclTxTotal.toStringAsFixed(2)), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
              ])),
              pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
              pw.Container(
                  child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Text('VAT Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
                pw.Text(config.splitValues(vatTx.toStringAsFixed(2)), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)),
              ])),
              pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
              pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('---------------------------')),
              pw.Container(child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  //
                  children: [pw.Text('Total (Incl) Tshs', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0)), pw.Text(config.splitValues(inclTxTotal.toStringAsFixed(2)), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10.0))])),
              pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('---------------------------')),
            ])),
      ]))
    ]));
  }

  static createTable(
    ThemeData theme,
  ) {
    Configure config = Configure();

    return pw.Container(
        child: pw.Table(
            border: pw.TableBorder.symmetric(
                outside: pw.BorderSide(
                  color: PdfColors.black,
                ),
                inside: pw.BorderSide(
                  color: PdfColors.black,
                )),
            columnWidths: {
          0: pw.FlexColumnWidth(0.8),
          1: pw.FlexColumnWidth(4.5),
          2: pw.FlexColumnWidth(1.2),
          3: pw.FlexColumnWidth(1.5),
          4: pw.FlexColumnWidth(1.8),
          5: pw.FlexColumnWidth(2),
        },
            children: [
          pw.TableRow(children: [
            pw.Container(
              child: pw.Text(
                "S.No",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                  // color: PdfColors.white,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              // alignment: Alignment.center,
              // color: PdfColors.blue,
              padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: pw.Text(
                "Description",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                  // color: PdfColors.white,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              // color: PdfColors.blue,
              padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              child: pw.Text(
                "Qty",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  // color: PdfColors.white,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              // color: PdfColors.blue,
              padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              child: pw.Text(
                "Disc %",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                  // fontSize: 16,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              // color: PdfColors.blue,
              padding: pw.EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 1,
              ),
              child: pw.Text(
                "VAT",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  // color: PdfColors.black,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              // color: PdfColors.blue,
              padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: pw.Text(
                "Net Amount",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                  // color: PdfColors.white,
                  // fontSize: 16,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ]), //
          for (int i = 0; i < iinvoicee!.items!.length; i++)
            pw.TableRow(
                // decoration: pw.BoxDecoration(color: PdfColors.grey, borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(10.0))),

                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                    child: pw.Container(
                      height: 0.3 * PdfPageFormat.cm,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        "${i + 1}",
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    child: pw.Text(
                      iinvoicee!.items![i].descripton.toString(),
                      // "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(fontSize: 10
                          // fontSize: 16,
                          // color: theme.primaryColor,
                          ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                    child: pw.Container(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        // "600000",
                        iinvoicee!.items![i].quantity.toString(),
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          // color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                    child: pw.Container(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        // '500',
                        iinvoicee!.items![i].dics.toString(),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                    child: pw.Container(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        // '5000',
                        config.splitValues(iinvoicee!.items![i].vat!.toStringAsFixed(2)),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 10,
                          // color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                    child: pw.Container(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        // "6340000",
                        config.splitValues(iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ])
        ]));

    // List<TableRow> rows = [];
    // rows.add(TableRow(children: [
    //   Container(
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //     child: Text(
    //       "S.No",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         fontSize: 16,
    //         color: Colors.white,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   Container(
    //     // alignment: Alignment.center,
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //     child: Text(
    //       "Description",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         fontSize: 16,
    //         color: Colors.white,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   Container(
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //     child: Text(
    //       "Qty",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         color: Colors.white,
    //         fontSize: 16,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   Container(
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //     child: Text(
    //       "Disc %",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         color: Colors.white,
    //         fontSize: 16,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   Container(
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //     child: Text(
    //       "VAT",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         color: Colors.white,
    //         fontSize: 16,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   Container(
    //     color: theme.primaryColor,
    //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //     child: Text(
    //       "Net Amount",
    //       style: theme.textTheme.bodyLarge?.copyWith(
    //         fontWeight: FontWeight.normal,
    //         color: Colors.white,
    //         fontSize: 16,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // ]));
    // print("Above Row");
    // for (int i = 0; i < invoicee.items!.length; ++i) {
    //   // print("in Row");
    //   rows.add(TableRow(children: [
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    //       child: Container(
    //         height: 0.3 * PdfPageFormat.cm,
    //         alignment: Alignment.center,
    //         child: Text(
    //           "${i + 1}",
    //           textAlign: TextAlign.left,
    //           style: theme.textTheme.bodyText1?.copyWith(
    //             fontSize: 16,
    //             // color: theme.primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
    //       child: Text(
    //         invoicee.items![i].descripton.toString(),
    //         // "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
    //         textAlign: TextAlign.left,
    //         style: theme.textTheme.bodyText2?.copyWith(
    //           fontSize: 16,
    //           // color: theme.primaryColor,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: Text(
    //           invoicee.items![i].quantity.toString(),
    //           //  earnKeyss[i].amount!.toStringAsFixed(2),
    //           textAlign: TextAlign.left,
    //           style: theme.textTheme.bodyText2?.copyWith(
    //             fontSize: 16,
    //             // color: theme.primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: Text(
    //           invoicee.items![i].dics.toString(),
    //           //  earnKeyss[i].amount!.toStringAsFixed(2),
    //           textAlign: TextAlign.left,
    //           style: theme.textTheme.bodyText2?.copyWith(
    //             fontSize: 16,
    //             // color: theme.primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: Text(
    //           invoicee.items![i].vat.toString(),
    //           //  earnKeyss[i].amount!.toStringAsFixed(2),
    //           textAlign: TextAlign.left,
    //           style: theme.textTheme.bodyText2?.copyWith(
    //             fontSize: 16,
    //             // color: theme.primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: Text(
    //           invoicee.items![i].netTotal.toString(),
    //           //  earnKeyss[i].amount!.toStringAsFixed(2),
    //           textAlign: TextAlign.left,
    //           style: theme.textTheme.bodyText2?.copyWith(
    //             fontSize: 16,
    //             // color: theme.primaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ]));
    // }
    // return Table(
    //     border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid)),
    //     columnWidths: {
    //       0: FlexColumnWidth(0.9),
    //       1: FlexColumnWidth(3.7),
    //       2: FlexColumnWidth(1),
    //       3: FlexColumnWidth(1.2),
    //       4: FlexColumnWidth(1),
    //       5: FlexColumnWidth(1.3),
    //       6: FlexColumnWidth(1.7),
    //     },
    //     children: rows);
  }
// // static Widget inVoiceTable(Invoice invoice) {
//   final headers = ["s.No", "Description", "Quantity"];
//   final data = iinvoicee!.items!.map((e) {
//     final total = (e.quantity);
//     return [e.slNo, (e.descripton), (e.quantity)];
//   }).toList();
//   return Table.fromTextArray(headers: headers, data: data);
// }
}
