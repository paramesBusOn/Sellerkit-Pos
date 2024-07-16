
const String draftCustomerTable = "Draft Customer";

// class CustomerDetals {
//   String? cardCode;
//   String? phNo;
//   String? name;
//   List<Address>? address;
//   String? accBalance;
//   String? tarNo;
//   String? email;
//   String? point;
//   CustomerDetals(
//       { this.name,
//        this.phNo,
//       this.cardCode,
//      this.accBalance,
//       this.point,
//       this.address,
//       this.tarNo,
//       this.email});
// }

class ShipAddress {
  String? billAddress;
  String? billCity;
  String? billstate;
  String? billPincode;
  String? billCountry;

  // String shipAddress;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  ShipAddress(
      {
      required this.billAddress,
      required this.billCity,
      required this.billCountry,
      required this.billPincode,
      required this.billstate,
      // required this.shipAddress,
      // required this.shipCity,
      // required this.shipCountry,
      // required this.shipPincode,
      // required this.shipstate
      });
}
