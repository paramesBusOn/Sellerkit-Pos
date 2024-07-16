const String tableNS = "NumberingSeries";

class NumberingSriesT {
  static String id = 'id';
  static String DocID = "DocID";  
  static String DocName = "DocName";
  static String WareHouse = "WareHouse";
  static String Terminal = "Terminal";
  static String Prefix = "Prefix";
  static String FirstNo = "FirstNo";
  static String LastNo = 'LastNo';
  static String NextNo = "NextNo";
  static String FromDate = "FromDate";
  static String ToDate = "ToDate";
}

class NumberingSriesTDB {
  int? id;
  String DocName;
  int? DocID;
  String? WareHouse;
  String? Terminal;
  String? Prefix;
  int? FirstNo;
  int? LastNo;
  int NextNo;
  String? FromDate;
  String? ToDate;
  
  NumberingSriesTDB(
      {
          required this.DocName,
        required this.id,
      required this.DocID,
      required this.FirstNo,
      required this.FromDate,
      required this.LastNo,
      required this.NextNo,
      required this.Prefix,
      required this.Terminal,
      required this.ToDate,
      required this.WareHouse,
     });
//   createdUserID:item['createdUserID'] ,
  factory NumberingSriesTDB.fromMap(Map<String, dynamic> item) 
  => NumberingSriesTDB(
    id: item['id'],
    DocID: item['DocID'], FirstNo: item['FirstNo'], 
    LastNo: item['LastNo'], NextNo: item['NextNo'], 
    Terminal: item['Terminal'], ToDate: item['ToDate'],
    FromDate: item['FromDate'], Prefix:  item['Prefix'],
    WareHouse: item['WareHouse'], DocName: item['DocName'],
    );

  Map<String, Object?> toMap() => {
        NumberingSriesT.id: id,
        NumberingSriesT.DocID: DocID,
        NumberingSriesT.FirstNo: FirstNo,
        NumberingSriesT.FromDate: FromDate,
        NumberingSriesT.LastNo: LastNo,
        NumberingSriesT.NextNo: NextNo,
        NumberingSriesT.Prefix: Prefix,
        NumberingSriesT.Terminal: Terminal,
        NumberingSriesT.ToDate: ToDate,
        NumberingSriesT.WareHouse: WareHouse,
        NumberingSriesT.DocName:DocName
        };
}
