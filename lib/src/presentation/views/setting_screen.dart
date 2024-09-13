import 'dart:io';

import 'package:clothing_mart/src/config/router/routes_name.dart';
import 'package:clothing_mart/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../presentation/widgets/image_network.dart';
import '../../util/extensions.dart';
import 'package:provider/provider.dart';
import '../../config/themes/strings.dart';
import '../../util/constants.dart';
import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';
import '../providers/app_provider.dart';
import '../widgets/animated_snackbar.dart';
import '../widgets/custom_radio.dart';
import '../widgets/custom_text_form_field.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final TextEditingController emailController =
        TextEditingController(text: provider.user!.email);
    final TextEditingController usernameController =
        TextEditingController(text: provider.user!.name);
    final TextEditingController birthdayController =
        TextEditingController(text: provider.user!.birthday);
    final TextEditingController weightController =
        TextEditingController(text: provider.user!.weight.toString());
    final TextEditingController heightController =
        TextEditingController(text: provider.user!.height.toString());

    return SizedBox(
      height: context.screenHeight,
      child: Stack(
        children: [
          Container(
            height: 240,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width / 12,
              right: MediaQuery.sizeOf(context).width / 12,
              top: 150,
            ),
            elevation: 6,
            color: Colors.white,
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
                width: MediaQuery.sizeOf(context).width,
                child: Column(children: [
                  CustomTextFormField(
                    hintText: 'Name',
                    isRoundedTextField: true,
                    controller: usernameController,
                  ),
                  16.marginHeight,
                  CustomTextFormField(
                    readOnly: true,
                    hintText: 'Email',
                    isRoundedTextField: true,
                    controller: emailController,
                  ),
                  16.marginHeight,
                  datePickerField(
                    birthdayController,
                    context,
                    provider,
                  ),
                  16.marginHeight,
                  weightAndHeightFields(
                    context,
                    weightController,
                    heightController,
                  ),
                  6.marginHeight,
                  radioGroup(context, provider),
                  10.0.marginHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Selector<AppProvider, bool>(
                        selector: (_, provider) => provider.isLoading,
                        builder: (_, loading, __) => CustomButton(
                          height: 40,
                          text: 'Save',
                          color: ColorManager.primaryColor,
                          onPressed: () {
                            provider.updateUser(
                              usernameController.text,
                              birthdayController.text,
                              weightController.text,
                              heightController.text,
                              () {
                                AnimatedSnackBar.show(
                                  context: context,
                                  message: const Text(
                                    "Your info. has been updated",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.done_rounded,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                );
                              },
                              (msg) {
                                AnimatedSnackBar.show(
                                  context: context,
                                  message: Text(
                                    msg,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                );
                              },
                            );
                          },
                          width: 100,
                          borderRadius: 20,
                          isLoading: loading,
                          circularProgressIndicatorSize: 18,
                        ),
                      ),
                      20.0.marginWidth,
                      ElevatedButton(
                        onPressed: () {
                          provider.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesName.loginRoute,
                            (Route<dynamic> route) =>
                                false, // This removes all routes from the stack
                          );
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                  12.0.marginHeight,
                ]),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 100,
              horizontal: context.screenWidth / 2.6,
            ),
            child: imagePicker(provider),
          ),
        ],
      ),
    );
  }

  CustomTextFormField datePickerField(
    TextEditingController birthdayController,
    BuildContext context,
    AppProvider provider,
  ) {
    return CustomTextFormField(
      readOnly: true,
      iconColor: ColorManager.greyColor,
      hintText: StringManager.birthday,
      controller: birthdayController,
      isRoundedTextField: true,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime(
            int.parse(provider.user!.birthday.split('-')[2]),
            int.parse(provider.user!.birthday.split('-')[1]),
            int.parse(provider.user!.birthday.split('-')[0]),
          ),
          firstDate: DateTime(Constants.firstDate),
          lastDate: DateTime(Constants.lastDate),
        );
        if (date != null) {
          birthdayController.text = "${date.day}-${date.month}-${date.year}";
        }
      },
    );
  }

  Row weightAndHeightFields(
    BuildContext context,
    TextEditingController weightController,
    TextEditingController heightController,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextFormField(
          width: context.screenWidth / 2.7,
          controller: weightController,
          hintText: StringManager.weight,
          isNumericKeyboardType: true,
          enableInteractiveSelection: false,
          isRoundedTextField: true,
        ),
        CustomTextFormField(
          isRoundedTextField: true,
          width: context.screenWidth / 2.7,
          controller: heightController,
          iconColor: ColorManager.greyColor,
          hintText: StringManager.height,
          isNumericKeyboardType: true,
          enableInteractiveSelection: false,
        )
      ],
    );
  }

  Column radioGroup(BuildContext context, AppProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.gender,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorManager.grey2Color,
            fontSize: Dimensions.s16,
          ),
        ),
        Dimensions.s6.marginHeight,
        Selector<AppProvider, String>(
          selector: (_, provider) => provider.currentOption,
          builder: (_, currentOption, __) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRadio(
                width: (context.screenWidth / 2.7),
                text: StringManager.male,
                value: provider.maleOption,
                groupValue: currentOption,
                onChanged: (value) {
                  provider.currentOption = value.toString();
                },
              ),
              Dimensions.s5.marginWidth,
              CustomRadio(
                width: (context.screenWidth / 2.7),
                text: StringManager.female,
                value: provider.femaleOption,
                groupValue: currentOption,
                onChanged: (value) {
                  provider.currentOption = value.toString();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  InkWell imagePicker(AppProvider provider) {
    return InkWell(
      onTap: () async {
        provider.selectImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      },
      overlayColor: const MaterialStatePropertyAll(Colors.white),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Selector<AppProvider, XFile?>(
            selector: (_, provider) => provider.selectedImage,
            builder: (_, userImage, __) => ClipOval(
              child: CircleAvatar(
                radius: Dimensions.s40,
                backgroundColor: ColorManager.primaryColor,
                child: provider.user!.imageUrl == "" && userImage == null
                    ? Padding(
                        padding: const EdgeInsets.all(Dimensions.s16),
                        child: Image.asset(
                          Constants.userAsset,
                          color: Colors.white,
                        ),
                      )
                    : userImage != null
                        ? Image.file(
                            File(userImage.path),
                            fit: BoxFit.cover,
                            width: Dimensions.s80,
                            height: Dimensions.s80,
                          )
                        : ImageNetwork(
                            imageUrl: provider.user!.imageUrl,
                            fit: BoxFit.cover,
                            circularProgressIndicatorColor:
                                ColorManager.primaryColor,
                            padding: const EdgeInsets.only(
                              bottom: Dimensions.s6,
                              left: Dimensions.s16,
                              right: Dimensions.s16,
                            ),
                          ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                right: Dimensions.s6, bottom: Dimensions.s2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.s100),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                size: Dimensions.s18,
                Icons.camera_alt_rounded,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
