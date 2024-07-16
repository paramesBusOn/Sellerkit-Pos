// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/main.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../Constant/Configuration.dart';

class OrderprintLayout extends StatelessWidget {
  OrderprintLayout({super.key});
  static Invoice? iinvoicee;
  Configure config = Configure();
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static double discountval = 0;
  static double discountper = 0;
  static double carryoverval = 0;

  static double subtotal = 0;
  static int pageindex = 0;
  static int pagecount = 0;

//context.pagesCount
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Printing Document")),
      body: PdfPreview(
        build: (format) => ordCreatePdfFile(),
      ),
    );
  }

  Future<Uint8List> ordCreatePdfFile() {
    var pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: pw.EdgeInsets.all(10),
        orientation: pw.PageOrientation.portrait,
        pageFormat: PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginAll: 2.0 * PdfPageFormat.cm),
        header: (context) {
          pageindex = context.pageNumber;
          pagecount = context.pagesCount;

          return pw.Header(
            outlineStyle: PdfOutlineStyle.normal,
            outlineColor: PdfColors.white,
            level: 2,
            child: headerContainer(),
          );
        },
        build: (pw.Context context) {

          return <pw.Widget>[
            buildContainer(),
            carryover(),
          ];
        },
        footer: (context) {
          return footerContainer();
        }));

    return pdf.save();
  }

  static buildContainer() {
    Configure config = Configure();

    return pw.Table(border: pw.TableBorder(bottom: pw.BorderSide(width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid), horizontalInside: pw.BorderSide(width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid)), columnWidths: {
      0: pw.FlexColumnWidth(0.8),
      1: pw.FlexColumnWidth(4.5),
      2: pw.FlexColumnWidth(1.2),
      3: pw.FlexColumnWidth(1.5),
      4: pw.FlexColumnWidth(2),
      5: pw.FlexColumnWidth(1),
      6: pw.FlexColumnWidth(2),
    }, children: [
      pw.TableRow(children: [
        pw.Container(
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
          child: pw.Text(
            "S.No",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
              color: PdfColors.blue100,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          width: 3 * PdfPageFormat.cm,
          alignment: pw.Alignment.centerLeft,
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: pw.Text(
            "Description",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              // color: PdfColors.black,
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
          child: pw.Text(
            "Quantity",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              // color: PdfColors.black,
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
          child: pw.Text(
            "UoM ",
            style: pw.TextStyle(
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 3,
          ),
          child: pw.Text(
            "Price",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 3,
          ),
          child: pw.Text(
            "Tax %",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          color: PdfColors.blue100,
          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: pw.Text(
            "Total",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              fontSize: 8,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ]), //
      for (int i = 0; i < iinvoicee!.items!.length; i++)
        pw.TableRow(children: [
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: pw.Container(
              //color: PdfColors.amber,
              height: 0.3 * PdfPageFormat.cm,
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                "${i + 1}",
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, color: PdfColors.grey400),
              ),
            ),
          ),
          pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              child: pw.Container(

                  //color: PdfColors.amber,
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text(
                  iinvoicee!.items![i].descripton.toString(),
                  // "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(
                  height: 0.3 * PdfPageFormat.cm,
                ),
                pw.Container(
                  // color: PdfColors.red,
                  width: 5 * PdfPageFormat.cm,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Row(children: [
                          pw.Text(
                            'Item Code:',
                            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
                          )
                        ]),
                        pw.Text(
                          'Delivery Date:',
                          style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
                        ),
                      ])),

                      pw.Container(
                          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Text(
                            // 'biuyiofei',
                            iinvoicee!.items![i].itemcode.toString(),
                            style: pw.TextStyle(
                              fontSize: 8,
                            )),
                        pw.Text('8/12/2011',
                            style: pw.TextStyle(
                              fontSize: 8,
                            )),
                      ])), //100017A
                    ],
                  ),
                )
              ]))),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: pw.Container(
              //color: PdfColors.amber,
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                // '10',
                iinvoicee!.items![i].quantity.toString(),
                textAlign: pw.TextAlign.right,
                style: pw.TextStyle(
                  fontSize: 8, fontWeight: pw.FontWeight.bold,
                  // color: theme.primaryColor,
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: pw.Container(
              //color: PdfColors.amber,
              alignment: pw.Alignment.center,
              child: pw.Text(
                '',
                // 'PAIL',
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: pw.Container(
              //color: PdfColors.amber,
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                // '12,000,000.00',
                config.splitValues(iinvoicee!.items![i].unitPrice!.toStringAsFixed(2)),
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: pw.Container(
              //color: PdfColors.amber,
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                // '12,000,000.00',
                ("18.00"),
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                // '12,000,000.00',
                config.splitValues(iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  fontSize: 8, fontWeight: pw.FontWeight.bold,
                  // color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ]),
    ]);
  }

  static carryover() {
    Configure config = Configure();

    return pw.Container(
        child: pw.Column(children: [
      pw.SizedBox(
        height: 0.5 * PdfPageFormat.cm,
      ),
      pw.Container(
          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Container(
                height: 0.3 * PdfPageFormat.cm,
                child: pw.VerticalDivider(
                  color: PdfColors.orange,
                  thickness: 3,
                )),
            pw.Text(
              'Carry Over : ',
              style: pw.TextStyle(
                fontSize: 8,
              ),
            ),
            pw.Text(
              config.splitValues(carryoverval.toStringAsFixed(2)),
              // '1,690,250.000',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
        pw.Container(alignment: pw.Alignment.centerRight, width: 4 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 2)),
      ])),
      amountCalculation(),
      pw.SizedBox(
        height: 0.5 * PdfPageFormat.cm,
      ),
      partialconfirmation(),
      pw.Text(
        '-----------------------------------------------------------------------------------------------------------------------------------------------',
        style: pw.TextStyle(color: PdfColors.blue),
      ),
      pw.SizedBox(
        height: 2 * PdfPageFormat.cm,
      ),
    ]));
  }

  static amountCalculation() {
    Configure config = Configure();

    return pw.Container(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Row(children: [
              pw.Container(
                  height: 0.3 * PdfPageFormat.cm,
                  child: pw.VerticalDivider(
                    color: PdfColors.orange,
                    thickness: 3,
                  )),
              pw.Text(
                'Tax Details',
                style: pw.TextStyle(
                  fontSize: 8, fontWeight: pw.FontWeight.bold,
                  // color: theme.primaryColor,
                ),
              )
            ]),
            pw.SizedBox(
              height: 0.2 * PdfPageFormat.cm,
            ),
            pw.Container(
                // width: 6.5 * PdfPageFormat.cm,
                child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Container(
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  width: 1.8 * PdfPageFormat.cm,
                  color: PdfColors.blue100,
                  child: pw.Text(
                    'Tax%',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  )),
              pw.Container(
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  width: 2.8 * PdfPageFormat.cm,
                  color: PdfColors.blue100,
                  child: pw.Text(
                    'Net',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  )),
              pw.Container(
                  alignment: pw.Alignment.center,
                  padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  width: 2.8 * PdfPageFormat.cm,
                  color: PdfColors.blue100,
                  child: pw.Text('Tax',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ))),
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  alignment: pw.Alignment.centerRight,
                  width: 2.8 * PdfPageFormat.cm,
                  color: PdfColors.blue100,
                  child: pw.Text('Gross',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.normal,
                      ))),
            ])),
            pw.SizedBox(
              height: 0.2 * PdfPageFormat.cm,
            ),
            pw.Container(
                alignment: pw.Alignment.center,

                // width: 6.5 * PdfPageFormat.cm,
                child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                  pw.Container(
                      alignment: pw.Alignment.center,
                      width: 1.8 * PdfPageFormat.cm,
                      // color: PdfColors.blue100,
                      child: pw.Text(
                        '18',
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.centerRight,
                      width: 2.8 * PdfPageFormat.cm,
                      // color: PdfColors.blue100,
                      child: pw.Text(
                        config.splitValues(exclTxTotal.toStringAsFixed(2)),
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      )),
                  pw.Container(
                      alignment: pw.Alignment.centerRight,
                      width: 2.8 * PdfPageFormat.cm,
                      // color: PdfColors.blue100,
                      child: pw.Text(config.splitValues(vatTx.toStringAsFixed(2)),
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                          ))),
                  pw.Container(
                      alignment: pw.Alignment.centerRight,
                      width: 2.8 * PdfPageFormat.cm,
                      // color: PdfColors.blue100,
                      child: pw.Text(config.splitValues(inclTxTotal.toStringAsFixed(2)),
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.normal,
                          ))),
                ])),
            pw.Container(width: 10.2 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
            pw.Container(
              width: 10.2 * PdfPageFormat.cm,
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Container(
                    child: pw.Row(children: [
                  pw.Container(
                      height: 0.3 * PdfPageFormat.cm,
                      child: pw.VerticalDivider(
                        color: PdfColors.orange,
                        thickness: 3,
                      )),
                  pw.Text(
                    'Payment Term',
                    style: pw.TextStyle(
                      fontSize: 8, fontWeight: pw.FontWeight.bold,
                      // color: theme.primaryColor,
                    ),
                  )
                ])),
                pw.Container(
                    child: pw.Text(
                  '30 Days',
                  style: pw.TextStyle(
                    fontSize: 8,
                    // color: theme.primaryColor,
                  ),
                ))
              ]),
            ),
            pw.SizedBox(
              height: 0.2 * PdfPageFormat.cm,
            ),
            pw.Container(width: 10.2 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
            pw.Container(
              width: 10.2 * PdfPageFormat.cm,
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Container(
                    child: pw.Row(children: [
                  pw.Container(
                      height: 0.3 * PdfPageFormat.cm,
                      child: pw.VerticalDivider(
                        color: PdfColors.orange,
                        thickness: 3,
                      )),
                  pw.Text(
                    'Additional Expenses',
                    style: pw.TextStyle(
                      fontSize: 8, fontWeight: pw.FontWeight.bold,
                      // color: theme.primaryColor,
                    ),
                  )
                ])),
                pw.Container(
                    child: pw.Text(
                  'Shipping Type:',
                  style: pw.TextStyle(
                    fontSize: 8,
                    // color: theme.primaryColor,
                  ),
                ))
              ]),
            ),
            pw.SizedBox(
              height: 0.2 * PdfPageFormat.cm,
            ),
            pw.Container(width: 10.2 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
          ])),
          pw.Container(
              width: 7 * PdfPageFormat.cm,
              child: pw.Column(children: [
                pw.Container(
                    // width: 7 * PdfPageFormat.cm,
                    child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Order SubTotal',
                      style: pw.TextStyle(
                        fontSize: 8,
                        // color: theme.primaryColor,
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                      // 'TZS ${subtotal.toString()}',
                      "TZS " + config.splitValues(subtotal.toStringAsFixed(2)),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    )),
                  ],
                )),
                pw.Text(
                  '...........................................................',
                  style: pw.TextStyle(color: PdfColors.blue),
                ),
                pw.SizedBox(
                  height: 0.1 * PdfPageFormat.cm,
                ),
                pw.Container(
                    // width: 6 * PdfPageFormat.cm,
                    child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Discount SubTotal',
                      style: pw.TextStyle(
                        fontSize: 8,
                        // color: theme.primaryColor,
                      ),
                    ),
                    pw.Text(
                      // '25%',
                      discountper.toString() + " %",
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                        // color: theme.primaryColor,
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                      "TZS " + config.splitValues(discountval.toStringAsFixed(2)),

                      // 'TZS ${discountval}',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 8,
                        // color: theme.primaryColor,
                      ),
                    )),
                  ],
                )),
                pw.Text(
                  '...........................................................',
                  style: pw.TextStyle(color: PdfColors.blue),
                ),
                pw.SizedBox(
                  height: 0.1 * PdfPageFormat.cm,
                ),
                pw.Container(
                    // width: 6 * PdfPageFormat.cm,
                    child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total Before Tax',
                      style: pw.TextStyle(
                        fontSize: 8,
                        // color: theme.primaryColor,
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                      'TZS ' + config.splitValues(exclTxTotal.toStringAsFixed(2)),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,

                        // color: theme.primaryColor,
                      ),
                    )),
                  ],
                )),
                pw.Text(
                  '...........................................................',
                  style: pw.TextStyle(color: PdfColors.blue),
                ),
                pw.SizedBox(
                  height: 0.1 * PdfPageFormat.cm,
                ),
                pw.Container(
                    // width: 6 * PdfPageFormat.cm,
                    child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total Tax Amount',
                      style: pw.TextStyle(
                        fontSize: 8,
                        // color: theme.primaryColor,
                      ),
                    ),
                    pw.Container(
                        child: pw.Text(
                      'TZS ' + config.splitValues(vatTx.toStringAsFixed(2)),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,

                        // color: theme.primaryColor,
                      ),
                    )),
                  ],
                )),
                pw.Text(
                  '..........................................................',
                  style: pw.TextStyle(color: PdfColors.blue),
                ),
                pw.SizedBox(
                  height: 0.1 * PdfPageFormat.cm,
                ),
                pw.Container(
                    // width: 6 * PdfPageFormat.cm,
                    child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        child: pw.Row(
                      children: [
                        pw.Container(
                            height: 0.3 * PdfPageFormat.cm,
                            child: pw.VerticalDivider(
                              color: PdfColors.orange,
                              thickness: 3,
                            )),
                        pw.Text(
                          'Total Amount',
                          style: pw.TextStyle(
                            fontSize: 8,
                            // color: theme.primaryColor,
                          ),
                        )
                      ],
                    )),
                    pw.Container(
                        child: pw.Text(
                      'TZS ' + config.splitValues(inclTxTotal.toStringAsFixed(2)),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,

                        // color: theme.primaryColor,
                      ),
                    )),
                  ],
                )),
                pw.Container(width: 6.7 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
              ]))
        ],
      ),
    );
  }

  // static CreateTable() {
  //   Configure config = Configure();

  //   return pw.Container(
  //       child: pw.Table(border: pw.TableBorder(bottom: pw.BorderSide(width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid), horizontalInside: pw.BorderSide(width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid)), columnWidths: {
  //     0: pw.FlexColumnWidth(0.8),
  //     1: pw.FlexColumnWidth(4.5),
  //     2: pw.FlexColumnWidth(1.2),
  //     3: pw.FlexColumnWidth(1.5),
  //     4: pw.FlexColumnWidth(2),
  //     5: pw.FlexColumnWidth(1),
  //     6: pw.FlexColumnWidth(2),
  //   }, children: [
  //     pw.TableRow(children: [
  //       pw.Container(
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
  //         child: pw.Text(
  //           "S.No",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //             color: PdfColors.blue100,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         width: 3 * PdfPageFormat.cm,
  //         alignment: pw.Alignment.centerLeft,
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
  //         child: pw.Text(
  //           "Description",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
  //         child: pw.Text(
  //           "Quantity",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
  //         child: pw.Text(
  //           "UoM ",
  //           style: pw.TextStyle(
  //             fontSize: 8,
  //             // fontSize: 16,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         alignment: pw.Alignment.center,
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(
  //           vertical: 4,
  //           horizontal: 3,
  //         ),
  //         child: pw.Text(
  //           "Price",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         alignment: pw.Alignment.center,
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(
  //           vertical: 4,
  //           horizontal: 3,
  //         ),
  //         child: pw.Text(
  //           "Tax%",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //       pw.Container(
  //         alignment: pw.Alignment.centerRight,
  //         color: PdfColors.blue100,
  //         padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
  //         child: pw.Text(
  //           "Total",
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.normal,
  //             // color: PdfColors.black,
  //             fontSize: 8,
  //             // color: PdfColors.white,
  //             // fontSize: 16,
  //           ),
  //           textAlign: pw.TextAlign.center,
  //         ),
  //       ),
  //     ]), //
  //     for (int i = 0; i < iinvoicee!.items!.length; i++)
  //       pw.TableRow(children: [
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             height: 0.3 * PdfPageFormat.cm,
  //             alignment: pw.Alignment.centerRight,
  //             child: pw.Text(
  //               "${i + 1}",
  //               textAlign: pw.TextAlign.left,
  //               style: pw.TextStyle(
  //                   // pw.theme.textTheme.bodyText1?.copyWith(
  //                   fontSize: 8,
  //                   fontWeight: pw.FontWeight.bold,
  //                   color: PdfColors.grey400),
  //             ),
  //           ),
  //         ),
  //         pw.Padding(
  //             padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
  //             child: pw.Container(

  //                 //color: PdfColors.amber,
  //                 child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //               pw.Text(
  //                 iinvoicee!.items![i].descripton.toString(),
  //                 // "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
  //                 textAlign: pw.TextAlign.left,
  //                 style: pw.TextStyle(
  //                   fontSize: 8, fontWeight: pw.FontWeight.bold,
  //                   // color: theme.primaryColor,
  //                 ),
  //               ),
  //               pw.SizedBox(
  //                 height: 0.3 * PdfPageFormat.cm,
  //               ),
  //               pw.Container(
  //                 // color: PdfColors.red,
  //                 width: 5 * PdfPageFormat.cm,
  //                 child: pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                   children: [
  //                     pw.Container(
  //                         child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //                       pw.Row(children: [
  //                         pw.Text(
  //                           'Item Code:',
  //                           style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
  //                         )
  //                       ]),
  //                       pw.Text(
  //                         'Delivery Date:',
  //                         style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
  //                       ),
  //                     ])),

  //                     pw.Container(
  //                         child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //                       pw.Text(
  //                           // 'bhjv ',
  //                           iinvoicee!.items![i].itemcode.toString(),
  //                           style: pw.TextStyle(
  //                             fontSize: 8,
  //                           )),
  //                       pw.Text('8/12/2011',
  //                           style: pw.TextStyle(
  //                             fontSize: 8,
  //                           )),
  //                     ])), //100017A
  //                   ],
  //                 ),
  //               )
  //             ]))),
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             alignment: pw.Alignment.centerRight,
  //             child: pw.Text(
  //               // '10',
  //               iinvoicee!.items![i].quantity.toString(),
  //               textAlign: pw.TextAlign.right,
  //               style: pw.TextStyle(
  //                 fontSize: 8, fontWeight: pw.FontWeight.bold,
  //                 // color: theme.primaryColor,
  //               ),
  //             ),
  //           ),
  //         ),
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             alignment: pw.Alignment.center,
  //             child: pw.Text(
  //               // 'PAIL',
  //               iinvoicee!.items![i].dics.toString(),
  //               textAlign: pw.TextAlign.left,
  //               style: pw.TextStyle(
  //                 fontSize: 8,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             alignment: pw.Alignment.centerRight,
  //             child: pw.Text(
  //               // '12,000,000.00',
  //               config.splitValues(iinvoicee!.items![i].unitPrice!.toStringAsFixed(2)),
  //               textAlign: pw.TextAlign.left,
  //               style: pw.TextStyle(
  //                 fontSize: 8, fontWeight: pw.FontWeight.bold,
  //                 // color: theme.primaryColor,
  //               ),
  //             ),
  //           ),
  //         ),
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             alignment: pw.Alignment.centerRight,
  //             child: pw.Text(
  //               ("18.00"),
  //               textAlign: pw.TextAlign.left,
  //               style: pw.TextStyle(
  //                 fontSize: 8, fontWeight: pw.FontWeight.bold,
  //                 // color: theme.primaryColor,
  //               ),
  //             ),
  //           ),
  //         ),
  //         pw.Padding(
  //           padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
  //           child: pw.Container(
  //             //color: PdfColors.amber,
  //             alignment: pw.Alignment.centerRight,
  //             child: pw.Text(
  //               // '12,000,000.00',
  //               config.splitValues(iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
  //               textAlign: pw.TextAlign.left,
  //               style: pw.TextStyle(
  //                 fontSize: 8, fontWeight: pw.FontWeight.bold,
  //                 // color: theme.primaryColor,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ]),
  //   ]));
  // }

  static partialconfirmation() {
    return pw.Container(
        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Container(
          width: 19 * PdfPageFormat.cm,
          color: PdfColors.blue100,
          child: pw.Text(
            'Allow Partial Delivery',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          )),
      pw.SizedBox(
        height: 0.2 * PdfPageFormat.cm,
      ),
      pw.Text(
        'Confirmation of Sales Order',
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.Container(
        alignment: pw.Alignment.center,
        // color: PdfColors.red,
        // width: double.infinity,
        padding: pw.EdgeInsets.only(left: 4 * PdfPageFormat.cm),
        width: 18 * PdfPageFormat.cm,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.Text(
              'Signature',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,

                // color: theme.primaryColor,
              ),
            ),
            pw.Container(alignment: pw.Alignment.bottomCenter, height: 1.1 * PdfPageFormat.cm, width: 4 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
            pw.Text(
              'Date',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,

                // color: theme.primaryColor,
              ),
            ),
            // pw.SizedBox(
            //   height: 0.5 * PdfPageFormat.cm,
            // ),
            pw.Container(alignment: pw.Alignment.bottomCenter, height: 1.1 * PdfPageFormat.cm, width: 4 * PdfPageFormat.cm, child: pw.Divider(color: PdfColors.blue, thickness: 1.5)),
          ],
        ),
      )
    ]));
  }

  static headerContainer() {
    return pw.Container(
        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Container(
          child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Container(
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('Insignia Limited', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 0.2 * PdfPageFormat.cm,
            ),
            pw.Text('PO Box 71449',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.SizedBox(
              height: 0.4 * PdfPageFormat.cm,
            ),
            pw.Text('MBOZI ROAD DAR ES SALAAM',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('TANZANIA',
                style: pw.TextStyle(
                  fontSize: 8,
                )),
          ])),
        ])),
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Container(
                      // color: PdfColors.red,
                      alignment: pw.Alignment.centerLeft,
                      width: 3 * PdfPageFormat.cm,
                      child: pw.Text('Original', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))),
                  pw.Container(
                      height: 0.3 * PdfPageFormat.cm,
                      child: pw.VerticalDivider(
                        color: PdfColors.orange,
                        thickness: 3,
                      )),
                  pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('Order Confirmation', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
                ],
              ),
            ),
            pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
            pw.Container(
                width: 9.3 * PdfPageFormat.cm,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Document Number",
                      style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal, color: PdfColors.grey500),
                    ),
                    pw.Text(
                      "Document Date",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
                    ),
                    pw.Text(
                      "Page",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
                    ),
                  ],
                )),
            pw.Container(
                width: 9.3 * PdfPageFormat.cm,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        padding: pw.EdgeInsets.only(
                          right: 0.2 * PdfPageFormat.cm,
                        ),
                        //color: PdfColors.amber,
                        width: 3.2 * PdfPageFormat.cm,
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          iinvoicee!.headerinfo!.invNum.toString(),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        )),
                    pw.Container(
                        padding: pw.EdgeInsets.only(
                          right: 0.2 * PdfPageFormat.cm,
                        ),
                        //color: PdfColors.red,
                        alignment: pw.Alignment.centerRight,
                        width: 2.5 * PdfPageFormat.cm,
                        child: pw.Text(
                          iinvoicee!.headerinfo!.invDate.toString(),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        )),
                    pw.Container(
                        padding: pw.EdgeInsets.only(
                          right: 0.2 * PdfPageFormat.cm,
                        ),
                        //color: PdfColors.amber,
                        alignment: pw.Alignment.centerRight,
                        width: 1.5 * PdfPageFormat.cm,
                        child: pw.Text(
                          '${pageindex} / ${pagecount}',
                          // "1/1",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        )),
                  ],
                )),
          ],
        )),
      ])),

      pageindex == 1 ? custdetails() : pw.Container(),

      // pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      pw.Text('-----------------------------------------------------------------------------------------------------------------------------------------------', style: pw.TextStyle(color: PdfColors.blue)),
      pw.Container(
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              //  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
            pw.Container(
                width: 2.8 * PdfPageFormat.cm,
                child: pw.Text(
                  'Delivery Date:',
                  style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
                )),
            pw.Text(
              '08/12/2011',
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ])),
      pw.Container(
          child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Container(
            child: pw.Row(children: [
          pw.Container(
              width: 2.8 * PdfPageFormat.cm,
              child: pw.Text(
                'Cancellation Date:',
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              )),
          pw.Container(
              child: pw.Text(
            '07/03/2012',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          )),
        ])),
        pw.Container(
            child: pw.Row(children: [
          pw.Text(
            'Currency :  ',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
          pw.Text(
            'TZS',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
        ])),
      ])),
    ]));
  }

  static custdetails() {
    return pw.Container(
        child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Container(
          child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.SizedBox(
          height: 2 * PdfPageFormat.cm,
        ),
        pw.RichText(
            text: pw.TextSpan(children: [
          pw.TextSpan(
            text: 'Insignia Limited',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.blue, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline),
          )
        ])),
        pw.SizedBox(
          height: 0.6 * PdfPageFormat.cm,
        ),
        pw.Text(iinvoicee!.invoiceMiddle!.customerName.toString(), style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(
          height: 0.2 * PdfPageFormat.cm,
        ),
        pw.Text('P. O. BOX 20010',
            style: pw.TextStyle(
              fontSize: 8,
            )),
        pw.SizedBox(
          height: 0.4 * PdfPageFormat.cm,
        ),
        pw.Text('KARIAKOO',
            style: pw.TextStyle(
              fontSize: 8,
            )),
        pw.Text('TANZANIA',
            style: pw.TextStyle(
              fontSize: 8,
            )),
      ])),
      pw.Container(
          child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
          pw.Container(
            width: 9.3 * PdfPageFormat.cm,
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        //color: PdfColors.red,
                        width: 3.2 * PdfPageFormat.cm,
                        child: pw.Text(
                          "Customer No.",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
                        )),
                    pw.Container(
                        //color: PdfColors.pink,
                        width: 5 * PdfPageFormat.cm,
                        child: pw.Text(
                          "Vat Number-Business Partner",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
                        )),
                    // pw.Text(
                    //   "Page",
                    //   style: pw.TextStyle(fontWeight: pw.FontWeight.normal, color: PdfColors.grey500),
                    // ),
                  ],
                ),
                pw.Container(
                    child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        // color: PdfColors.blue,
                        padding: pw.EdgeInsets.only(
                          right: 0.2 * PdfPageFormat.cm,
                        ),
                        width: 3.2 * PdfPageFormat.cm,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          iinvoicee!.headerinfo!.custcode.toString(),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        )),
                    pw.Container(
                        padding: pw.EdgeInsets.only(
                          right: 0.2 * PdfPageFormat.cm,
                        ),
                        // color: PdfColors.red,
                        alignment: pw.Alignment.centerLeft,
                        width: 5 * PdfPageFormat.cm,
                        child: pw.Text(
                          "10-000297-N",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                        )),
                  ],
                )),
              ],
            ),
          ),
          pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              // color: PdfColors.red,
              alignment: pw.Alignment.centerLeft,
              // width: 5 * PdfPageFsormat.cm,
              child: pw.Text(
                "Your Reference",
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              )),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              // color: PdfColors.red,
              alignment: pw.Alignment.centerLeft,
              // width: 5 * PdfPageFormat.cm,
              child: pw.Text(iinvoicee!.headerinfo!.ordReference.toString(),
                  // "Maggi",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ))),
          pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              // color: PdfColors.red,
              alignment: pw.Alignment.centerLeft,
              width: 5 * PdfPageFormat.cm,
              child: pw.Text(
                "Your Contact",
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              )),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              // color: PdfColors.red,
              alignment: pw.Alignment.centerLeft,
              // width: 5 * PdfPageFormat.cm,
              child: pw.Text("SANJAY BABUTA",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ))),
          pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
          pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              alignment: pw.Alignment.centerLeft,
              // width: 5 * PdfPageFormat.cm,
              child: pw.Text(
                "Delivery Address",
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
              )),
          pw.Container(
              padding: pw.EdgeInsets.only(
                right: 0.2 * PdfPageFormat.cm,
              ),
              // color: PdfColors.red,
              alignment: pw.Alignment.centerLeft,
              width: 5 * PdfPageFormat.cm,
              child: pw.Text(iinvoicee!.invoiceMiddle!.customerName.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ))),
          pw.SizedBox(
            height: 1 * PdfPageFormat.cm,
          ),
        ],
      ))
    ]));
  }

  static footerContainer() {
    return pw.Container(
        child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'CEO:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Tax Official:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(width: 2.5 * PdfPageFormat.cm, child: pw.Text('')),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Headquarters:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('100-230-844',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Website:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('www.insignia.co.tz',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            )
          ],
        )),
        pw.SizedBox(width: 1 * PdfPageFormat.cm),
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Phone No:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('255-22-2104149',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Fax:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(
                    width: 3.5 * PdfPageFormat.cm,
                    child: pw.Text(
                      '255-22-2861420',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('E-Mail:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('sapadmin@insigniatz.com',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Tax No:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('34043',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Tax ID No:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            )
          ],
        )),
        pw.SizedBox(width: 1 * PdfPageFormat.cm),
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Bank Name:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('NBC TZS',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Bank Account:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
                pw.Container(
                    width: 3.5 * PdfPageFormat.cm,
                    child: pw.Text(
                      '011103003423',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          ),
                    )),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('bank Code:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('NBC TZS',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Swift/BIC Code:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('IBAN:',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500
                          // color: theme.primaryColor,
                          )),
                ),
              ],
            )
          ],
        )),
      ],
    ));
  }
}
 // pw.Container(
      //     child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      //   pw.Container(
      //       child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //     pw.Container(

      //         // color: PdfColors.red,
      //         child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //       pw.Text('Insignia Limited', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
      //       pw.SizedBox(
      //         height: 0.2 * PdfPageFormat.cm,
      //       ),
      //       pw.Text('PO Box 71449',
      //           style: pw.TextStyle(
      //             fontSize: 8,
      //           )),
      //       pw.SizedBox(
      //         height: 0.4 * PdfPageFormat.cm,
      //       ),
      //       pw.Text('MBOZI ROAD DAR ES SALAAM',
      //           style: pw.TextStyle(
      //             fontSize: 8,
      //           )),
      //       pw.Text('TANZANIA',
      //           style: pw.TextStyle(
      //             fontSize: 8,
      //           )),
      //     ])),
      //     pw.SizedBox(
      //       height: 2 * PdfPageFormat.cm,
      //     ),
      //     pw.Container(
      //         // color: PdfColors.red,
            
      //     ])),
      //   ])),
      //   pw.Container(
      //       child: pw.Column(
      //     crossAxisAlignment: pw.CrossAxisAlignment.start,
      //     children: [
      //       pw.Container(
      //         child: pw.Row(
      //           crossAxisAlignment: pw.CrossAxisAlignment.end,
      //           children: [
      //             pw.Container(
      //                 // color: PdfColors.red,
      //                 alignment: pw.Alignment.centerLeft,
      //                 width: 3 * PdfPageFormat.cm,
      //                 child: pw.Text('Original', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold))),
      //             pw.Container(
      //                 height: 0.3 * PdfPageFormat.cm,
      //                 child: pw.VerticalDivider(
      //                   color: PdfColors.orange,
      //                   thickness: 3,
      //                 )),
      //             pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text('Order Confirmation', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
      //           ],
      //         ),
      //       ),
      //       pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
      //       pw.Container(
      //           width: 9.3 * PdfPageFormat.cm,
      //           child: pw.Row(
      //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: pw.CrossAxisAlignment.start,
      //             children: [
      //               pw.Text(
      //                 "Document Number",
      //                 style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.normal, color: PdfColors.grey500),
      //               ),
      //               pw.Text(
      //                 "Document Date",
      //                 style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
      //               ),
      //               pw.Text(
      //                 "Page",
      //                 style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
      //               ),
      //             ],
      //           )),
      //       pw.Container(
      //           width: 9.3 * PdfPageFormat.cm,
      //           child: pw.Row(
      //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: pw.CrossAxisAlignment.start,
      //             children: [
      //               pw.Container(
      //                   padding: pw.EdgeInsets.only(
      //                     right: 0.2 * PdfPageFormat.cm,
      //                   ),
      //                   //color: PdfColors.amber,
      //                   width: 3.2 * PdfPageFormat.cm,
      //                   alignment: pw.Alignment.centerRight,
      //                   child: pw.Text(
      //                     iinvoicee!.headerinfo!.invNum.toString(),
      //                     style: pw.TextStyle(
      //                       fontWeight: pw.FontWeight.bold,
      //                       fontSize: 8,
      //                     ),
      //                   )),
      //               pw.Container(
      //                   padding: pw.EdgeInsets.only(
      //                     right: 0.2 * PdfPageFormat.cm,
      //                   ),
      //                   //color: PdfColors.red,
      //                   alignment: pw.Alignment.centerRight,
      //                   width: 2.5 * PdfPageFormat.cm,
      //                   child: pw.Text(
      //                     iinvoicee!.headerinfo!.invDate.toString(),
      //                     style: pw.TextStyle(
      //                       fontWeight: pw.FontWeight.bold,
      //                       fontSize: 8,
      //                     ),
      //                   )),
      //               pw.Container(
      //                   padding: pw.EdgeInsets.only(
      //                     right: 0.2 * PdfPageFormat.cm,
      //                   ),
      //                   //color: PdfColors.amber,
      //                   alignment: pw.Alignment.centerRight,
      //                   width: 1.5 * PdfPageFormat.cm,
      //                   child: pw.Text(
      //                     "1/1",
      //                     style: pw.TextStyle(
      //                       fontWeight: pw.FontWeight.bold,
      //                       fontSize: 8,
      //                     ),
      //                   )),
      //             ],
      //           )),
      //       pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
      //       pw.Container(
      //         width: 9.3 * PdfPageFormat.cm,
      //         child: pw.Column(
      //           children: [
      //             pw.Row(
      //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: pw.CrossAxisAlignment.start,
      //               children: [
      //                 pw.Container(
      //                     //color: PdfColors.red,
      //                     width: 3.2 * PdfPageFormat.cm,
      //                     child: pw.Text(
      //                       "Customer No.",
      //                       style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
      //                     )),
      //                 pw.Container(
      //                     //color: PdfColors.pink,
      //                     width: 5 * PdfPageFormat.cm,
      //                     child: pw.Text(
      //                       "Vat Number-Business Partner",
      //                       style: pw.TextStyle(fontWeight: pw.FontWeight.normal, fontSize: 8, color: PdfColors.grey500),
      //                     )),
      //                 // pw.Text(
      //                 //   "Page",
      //                 //   style: pw.TextStyle(fontWeight: pw.FontWeight.normal, color: PdfColors.grey500),
      //                 // ),
      //               ],
      //             ),
      //             pw.Container(
      //                 child: pw.Row(
      //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //               crossAxisAlignment: pw.CrossAxisAlignment.start,
      //               children: [
      //                 pw.Container(
      //                     // color: PdfColors.blue,
      //                     padding: pw.EdgeInsets.only(
      //                       right: 0.2 * PdfPageFormat.cm,
      //                     ),
      //                     width: 3.2 * PdfPageFormat.cm,
      //                     alignment: pw.Alignment.centerLeft,
      //                     child: pw.Text(
      //                       iinvoicee!.headerinfo!.custcode.toString(),
      //                       style: pw.TextStyle(
      //                         fontWeight: pw.FontWeight.bold,
      //                         fontSize: 8,
      //                       ),
      //                     )),
      //                 pw.Container(
      //                     padding: pw.EdgeInsets.only(
      //                       right: 0.2 * PdfPageFormat.cm,
      //                     ),
      //                     // color: PdfColors.red,
      //                     alignment: pw.Alignment.centerLeft,
      //                     width: 5 * PdfPageFormat.cm,
      //                     child: pw.Text(
      //                       "10-000297-N",
      //                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
      //                     )),
      //               ],
      //             )),
      //           ],
      //         ),
      //       ),
      //       pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           // color: PdfColors.red,
      //           alignment: pw.Alignment.centerLeft,
      //           // width: 5 * PdfPageFsormat.cm,
      //           child: pw.Text(
      //             "Your Reference",
      //             style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
      //           )),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           // color: PdfColors.red,
      //           alignment: pw.Alignment.centerLeft,
      //           // width: 5 * PdfPageFormat.cm,
      //           child: pw.Text("Maggi",
      //               style: pw.TextStyle(
      //                 fontWeight: pw.FontWeight.bold,
      //                 fontSize: 8,
      //               ))),
      //       pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           // color: PdfColors.red,
      //           alignment: pw.Alignment.centerLeft,
      //           width: 5 * PdfPageFormat.cm,
      //           child: pw.Text(
      //             "Your Contact",
      //             style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
      //           )),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           // color: PdfColors.red,
      //           alignment: pw.Alignment.centerLeft,
      //           // width: 5 * PdfPageFormat.cm,
      //           child: pw.Text("SANJAY BABUTA",
      //               style: pw.TextStyle(
      //                 fontWeight: pw.FontWeight.bold,
      //                 fontSize: 8,
      //               ))),
      //       pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
      //       pw.Text('....................................................................................', style: pw.TextStyle(color: PdfColors.blue100)),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           alignment: pw.Alignment.centerLeft,
      //           // width: 5 * PdfPageFormat.cm,
      //           child: pw.Text(
      //             "Delivery Address",
      //             style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
      //           )),
      //       pw.Container(
      //           padding: pw.EdgeInsets.only(
      //             right: 0.2 * PdfPageFormat.cm,
      //           ),
      //           // color: PdfColors.red,
      //           alignment: pw.Alignment.centerLeft,
      //           width: 5 * PdfPageFormat.cm,
      //           child: pw.Text(iinvoicee!.invoiceMiddle!.customerName.toString(),
      //               style: pw.TextStyle(
      //                 fontWeight: pw.FontWeight.bold,
      //                 fontSize: 8,
      //               ))),
      //     ],
      //   )),
      // ])),
      // pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      // pw.Text('-----------------------------------------------------------------------------------------------------------------------------------------------', style: pw.TextStyle(color: PdfColors.blue)),
      // pw.Container(
      //     child: pw.Row(
      //         crossAxisAlignment: pw.CrossAxisAlignment.start,
      //         //  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //         children: [
      //       pw.Container(
      //           width: 2.8 * PdfPageFormat.cm,
      //           child: pw.Text(
      //             'Delivery Date:',
      //             style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
      //           )),
      //       pw.Text(
      //         '08/12/2011',
      //         style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
      //       ),
      //     ])),
      // pw.Container(
      //     child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //   pw.Container(
      //       child: pw.Row(children: [
      //     pw.Container(
      //         width: 2.8 * PdfPageFormat.cm,
      //         child: pw.Text(
      //           'Cancellation Date:',
      //           style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
      //         )),
      //     pw.Container(
      //         child: pw.Text(
      //       '07/03/2012',
      //       style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
      //     )),
      //   ])),
      //   pw.Container(
      //       child: pw.Row(children: [
      //     pw.Text(
      //       'Currency:',
      //       style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
      //     ),
      //     pw.Text(
      //       'TZS',
      //       style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
      //     ),
      //   ])),
      // ])),
      // pw.SizedBox(
      //   height: 0.3 * PdfPageFormat.cm,
      // ),

      // pw.Container(
      //     color: PdfColors.blue100,
      //     width: double.infinity,
      //     child: pw.Row(children: [
      //       pw.Container(
      //         // color: PdfColors.blue100,
      //         padding: pw.EdgeInsets.symmetric(vertical: 3, horizontal: 1),
      //         child: pw.Text(
      //           "S.No",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //             color: PdfColors.blue100,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 6.2 * PdfPageFormat.cm,
      //         alignment: pw.Alignment.centerLeft,
      //         // color: PdfColors.red,
      //         // blue100,
      //         padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //         child: pw.Text(
      //           "Description",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 2.2 * PdfPageFormat.cm,
      //         // color: PdfColors.blue100,
      //         padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //         child: pw.Text(
      //           "Quantity",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 2.2 * PdfPageFormat.cm,
      //         // color: PdfColors.green,
      //         padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      //         child: pw.Text(
      //           "UoM ",
      //           style: pw.TextStyle(
      //             fontSize: 8,
      //             // fontSize: 16,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 3.5 * PdfPageFormat.cm,
      //         alignment: pw.Alignment.center,
      //         // color: PdfColors.red,
      //         padding: pw.EdgeInsets.symmetric(
      //           vertical: 2,
      //           horizontal: 3,
      //         ),
      //         child: pw.Text(
      //           "Price",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 2 * PdfPageFormat.cm,
      //         alignment: pw.Alignment.center,
      //         // color: PdfColors.yellow,
      //         padding: pw.EdgeInsets.symmetric(
      //           vertical: 2,
      //           horizontal: 3,
      //         ),
      //         child: pw.Text(
      //           "Tax %",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //       pw.Container(
      //         width: 3.5 * PdfPageFormat.cm,
      //         alignment: pw.Alignment.centerRight,
      //         // color: PdfColors.green,
      //         padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      //         child: pw.Text(
      //           "Total",
      //           style: pw.TextStyle(
      //             fontWeight: pw.FontWeight.normal,
      //             // color: PdfColors.black,
      //             fontSize: 8,
      //             // color: PdfColors.white,
      //             // fontSize: 16,
      //           ),
      //           textAlign: pw.TextAlign.center,
      //         ),
      //       ),
      //     ])),

      // pw.ListView.builder(
      //   itemCount: 15,
      //   itemBuilder: (context, int index) {
      //     return pw.Container(
      //         // width: double.infinity,
      //         child: pw.Column(
      //       children: [
      //         pw.Container(
      //             child: pw.Row(
      //           crossAxisAlignment: pw.CrossAxisAlignment.start,
      //           children: [
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 4),

      //               //color: PdfColors.amber,
      //               height: 0.3 * PdfPageFormat.cm,
      //               alignment: pw.Alignment.centerRight,
      //               child: pw.Text(
      //                 "${index + 1}",
      //                 textAlign: pw.TextAlign.left,
      //                 style: pw.TextStyle(
      //                     // pw.theme.textTheme.bodyText1?.copyWith(
      //                     fontSize: 8,
      //                     fontWeight: pw.FontWeight.bold,
      //                     color: PdfColors.grey400),
      //               ),
      //             ),
      //             pw.Container(
      //                 padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //                 width: 6.7 * PdfPageFormat.cm,
      //                 // color: PdfColors.green,
      //                 child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //                   pw.Text(
      //                     // iinvoicee!.items![i].descripton.toString(),
      //                     "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
      //                     textAlign: pw.TextAlign.left,
      //                     style: pw.TextStyle(
      //                       fontSize: 8, fontWeight: pw.FontWeight.bold,
      //                       // color: theme.primaryColor,
      //                     ),
      //                   ),
      //                   pw.SizedBox(
      //                     height: 0.3 * PdfPageFormat.cm,
      //                   ),
      //                   pw.Container(
      //                     // color: PdfColors.red,
      //                     width: 5 * PdfPageFormat.cm,
      //                     child: pw.Row(
      //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                       children: [
      //                         pw.Container(
      //                             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //                           pw.Row(children: [
      //                             pw.Text(
      //                               'Item Code:',
      //                               style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
      //                             )
      //                           ]),
      //                           //   pw.Container(
      //                           //   child: pw.Icon(pw.IconData() ),
      //                           // ),
      //                           pw.Text(
      //                             'Delivery Date:',
      //                             style: pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
      //                           ),
      //                         ])),

      //                         pw.Container(
      //                             child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      //                           pw.Text('bhjv ',
      //                               // iinvoicee!.items![i].itemcode.toString(),
      //                               style: pw.TextStyle(
      //                                 fontSize: 8,
      //                               )),
      //                           pw.Text('8/12/2011',
      //                               style: pw.TextStyle(
      //                                 fontSize: 8,
      //                               )),
      //                         ])), //100017A
      //                       ],
      //                     ),
      //                   )
      //                 ])),
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //               width: 2 * PdfPageFormat.cm,
      //               // color: PdfColors.amber,
      //               alignment: pw.Alignment.centerRight,
      //               child: pw.Text(
      //                 '10',
      //                 // iinvoicee!.items![i].quantity.toString(),
      //                 textAlign: pw.TextAlign.right,
      //                 style: pw.TextStyle(
      //                   fontSize: 8, fontWeight: pw.FontWeight.bold,
      //                   // color: theme.primaryColor,
      //                 ),
      //               ),
      //             ),
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //               width: 2.2 * PdfPageFormat.cm,
      //               // color: PdfColors.red,
      //               alignment: pw.Alignment.center,
      //               child: pw.Text(
      //                 'PAIL',
      //                 // iinvoicee!.items![i].dics.toString(),
      //                 //  earnKeyss[i].amount!.toStringAsFixed(2),
      //                 textAlign: pw.TextAlign.left,
      //                 style: pw.TextStyle(
      //                   fontSize: 8,
      //                   fontWeight: pw.FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      //               width: 3.5 * PdfPageFormat.cm,
      //               // color: PdfColors.amber,
      //               alignment: pw.Alignment.centerRight,
      //               child: pw.Text(
      //                 '12,000,000.00',
      //                 // config.splitValues(iinvoicee!.items![i].unitPrice!.toStringAsFixed(2)),
      //                 textAlign: pw.TextAlign.left,
      //                 style: pw.TextStyle(
      //                   fontSize: 8, fontWeight: pw.FontWeight.bold,
      //                   // color: theme.primaryColor,
      //                 ),
      //               ),
      //             ),
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      //               width: 2 * PdfPageFormat.cm,
      //               // color: PdfColors.green,
      //               alignment: pw.Alignment.centerRight,
      //               child: pw.Text(
      //                 // '12,000,000.00',
      //                 ("18"),
      //                 textAlign: pw.TextAlign.left,
      //                 style: pw.TextStyle(
      //                   fontSize: 8, fontWeight: pw.FontWeight.bold,
      //                   // color: theme.primaryColor,
      //                 ),
      //               ),
      //             ),
      //             pw.Container(
      //               padding: pw.EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      //               width: 3.5 * PdfPageFormat.cm,
      //               // color: PdfColors.amber,
      //               alignment: pw.Alignment.centerRight,
      //               child: pw.Text(
      //                 '12,000,000.00',
      //                 // config.splitValues(iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
      //                 textAlign: pw.TextAlign.left,
      //                 style: pw.TextStyle(
      //                   fontSize: 8, fontWeight: pw.FontWeight.bold,
      //                   // color: theme.primaryColor,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         )),
      //         pw.Text(
      //           '............................................................................................................................................................................',
      //           style: pw.TextStyle(color: PdfColors.blue
      //               // color: theme.primaryColor,
      //               ),
      //         )
      //       ],
      //     ));
      //   },
      // ),