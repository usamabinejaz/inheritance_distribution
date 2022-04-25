import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:inheritance_distribution/app_reserved/constants.dart';
import 'package:inheritance_distribution/widgets/custom_app_bar.dart';
import 'package:inheritance_distribution/widgets/responsive_fields.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PersonInformation extends StatefulWidget {
  const PersonInformation({Key? key}) : super(key: key);

  @override
  State<PersonInformation> createState() => _PersonInformationState();
}

class _PersonInformationState extends State<PersonInformation> {
  late bool alive;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alive = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          closeThis: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FormBuilder(
                key: _formKey,
                child: ResponsiveGridRow(
                  children: [
                    fullWidthResponsiveField(
                      children: [
                        FormBuilderRadioGroup<String>(
                          decoration: const InputDecoration(
                            label: Text("Gender"),
                            border: InputBorder.none,
                          ),
                          name: 'gender',
                          options: const [
                            FormBuilderFieldOption<String>(
                              value: 'male',
                              child: Text('Male'),
                            ),
                            FormBuilderFieldOption<String>(
                              value: 'female',
                              child: Text('Female'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    formResponsiveField(
                      child: FormBuilderTextField(
                        name: 'name',
                        decoration: const InputDecoration(
                          label: Text("Name"),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    formResponsiveField(
                      child: FormBuilderDateTimePicker(
                        inputType: InputType.date,
                        name: 'dob',
                        currentDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(
                            hours: Duration.hoursPerDay * 365 * 150)),
                        lastDate: DateTime.now(),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                          label: Text('Date Of Birth'),
                          focusColor: Constants.appPrimaryColorLight,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    formResponsiveField(
                      child: FormBuilderSwitch(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        name: 'isDead',
                        title: const Text('Person Alive?'),
                        inactiveTrackColor: Constants.appGrey,
                        inactiveThumbColor: Constants.appGrey,
                        initialValue: alive,
                        onChanged: (value) {
                          setState(() {
                            alive = value!;
                          });
                        },
                      ),
                    ),
                    // Visibility(
                    //   visible: !alive,
                    //   child: const SizedBox(
                    //     height: 10,
                    //   ),
                    // ),
                    formResponsiveField(
                      visible: !alive,
                      child: FormBuilderDateTimePicker(
                        inputType: InputType.date,
                        name: 'dod',
                        currentDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(
                            hours: Duration.hoursPerDay * 365 * 150)),
                        lastDate: DateTime.now(),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                          label: Text('Date Of Death'),
                          focusColor: Constants.appPrimaryColorLight,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    fullWidthResponsiveField(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            icon: const Icon(Icons.restart_alt),
                            label: const Text('Reset Form'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.save),
                            label: const Text('Save information'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
