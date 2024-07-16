import 'package:flutter/material.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

MobPayCreateAdd(BuildContext context, ThemeData theme,
    PayreceiptController posController, double custHeight, double custWidth) {
  return StatefulBuilder(builder: (context, st) {
    return Container(
      alignment: Alignment.center,
      // height: CusHeight,
      width: custWidth,
      padding: EdgeInsets.all(
        custHeight * 0.008,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: theme.primaryColor.withOpacity(0.3))),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Text("data")
              SizedBox(
                height: custHeight * 0.1,
                width: custWidth * 0.5,
              
                child: TextFormField(
                  // controller: posController.mycontroller[7],
                  autofocus: true,
                  cursorColor: Colors.grey,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Address1";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Bill Address1",
                    // filled: false,
                    labelStyle:
                        theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                    hintStyle:
                        theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    // contentPadding: const EdgeInsets.symmetric(
                    //   vertical: 5,
                    //   horizontal: 10,
                    // ),
                  ),
                ),
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Container(
                // height: custHeight * 0.15,
                // width: custWidth * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller:posController.mycontroller[8],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Address2";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Bill Address2",
                    filled: false,
                                labelStyle:
                  theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                   theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:custHeight * 0.008,
              ),
              Container(
                // height: custHeight * 0.15,
                // width: custWidth * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  controller: posController.mycontroller[9],
                  cursorColor: Colors.grey,
                  style:theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter the Address3";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Bill Address3",
                    filled: false,
                                labelStyle:
                   theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[10],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the City Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "City",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[11],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the Pin Code";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Pin Code",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[12],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the State";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "State",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: posController.mycontroller[13],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please Enter the State";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                        hintText: "Ind",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: custHeight * 0.1,
                    child: const Text(" Copy As Ship Address"),
                  ),
                  SizedBox(
                    width: custWidth * 0.2,
                  ),
                  Checkbox(
                      side: const BorderSide(color: Colors.grey),
                      activeColor: Colors.green,
                      value: posController.checkboxx,
                      onChanged: (val) {
                        st(() {
                          posController.checkboxx = val!;
                          posController.billToShip(val);
                        });
                      }),
                ],
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: posController.mycontroller[14],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Ship Address1";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Ship Address1',
                          filled: false,
                                      labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: custHeight * 0.02,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: posController.mycontroller[15],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Ship Address2";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Ship Address2',
                          filled: false,
                                      labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: custHeight * 0.02,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 0.65,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 240, 235, 235)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: posController.mycontroller[16],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Ship Address3";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Ship Address3",
                          filled: false,
                                      labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[33],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the City Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "City",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[34],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the Pin Code";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Pin Code",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: custHeight * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: posController.mycontroller[19],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the State";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "State",
                        filled: false,
                                    labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: custHeight * 0.15,
                    width: custWidth * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: posController.mycontroller[20],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please Enter the State";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                        hintText: "Ind",
                        filled: false,
                          labelStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                hintStyle:
                    theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  });
}
