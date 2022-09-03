import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  bool _passwordVisible = false;

  CustomTextField({
    Key key,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      color: Color(0xffF1F5F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      shadowColor: Color(0xffE9EBEC),
      child: StatefulBuilder(
        builder: (cont, setStates) {
          return hintText == 'Password'
              ? Stack(
            alignment: AlignmentDirectional.centerEnd,
                  children: [
                    TextFormField(
                      controller: controller,
                      obscureText: hintText == 'Password' && !_passwordVisible
                          ? true
                          : false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14, right: 14),
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle:
                            Theme.of(context).textTheme.headline6.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .color
                                      .withOpacity(0.9),
                                  letterSpacing: 0.6,
                                  fontSize: 14,
                                ),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setStates(() => _passwordVisible = !_passwordVisible);
                        },
                        child: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff0E2F56),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                )
              : TextFormField(
                  controller: controller,
                  obscureText: hintText == 'Password' && !_passwordVisible
                      ? true
                      : false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 14, right: 14),
                    focusColor: Colors.white,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .caption
                              .color
                              .withOpacity(0.9),
                          letterSpacing: 0.6,
                          fontSize: 14,
                        ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                  ),
                );
        },
      ),
    );
  }
}
