import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room/room_model.dart';
import 'package:nosk/src/route/route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:validatorless/validatorless.dart';

class NumberFormatter extends TextInputFormatter {
  final NumberFormat numberFormat = NumberFormat("#,###.##");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Remove all non-numeric characters except the decimal point
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Prevent multiple decimal points
    if (numericString.indexOf('.') != numericString.lastIndexOf('.')) {
      return oldValue;
    }

    // Parse number safely
    double? parsedValue = double.tryParse(numericString);
    if (parsedValue == null) return oldValue;

    // Format the number with thousands separator and decimals
    String formattedString = numberFormat.format(parsedValue);

    // Maintain cursor position
    return TextEditingValue(
      text: formattedString,
      selection: TextSelection.collapsed(offset: formattedString.length),
    );
  }
}

class CreateRoomPage extends RouteFulWidget {
  const CreateRoomPage({super.key});

  static CreateRoomPage get route => const CreateRoomPage();

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();

  @override
  String path() => '/create-room';

  @override
  String title() => 'Create Room';

  @override
  Transition transition() => Transition.rightToLeftWithFade;
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  final RoomLogic _roomLogic = RoomLogic.to;
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final RxList<String> _amenities = <String>[].obs;
  final RxList<String> _roomNumbers = <String>[].obs;

  List<File> _selectedFiles = [];
  final RxBool _isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();

  /// Pick multiple images
  Future<void> _pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  final cloudinary = Cloudinary.signedConfig(
    apiSecret: 'Q4LRyUHcSi0UD7BxJth9obH4vlU',
    cloudName: 'dvid1qlwp',
    apiKey: '248665321255432',
  );

  Future<void> onSubmit() async {
    if (_isLoading.isTrue) return;
    _isLoading.value = true;
    try {
      if (_formKey.currentState!.validate()) {
        if (_amenities.isEmpty) {
          context.toast(
            toastMessage: 'Amenities cannot be empty',
            type: ToastSnackBarType.warning,
          );
          return;
        }
        if (_roomNumbers.isEmpty) {
          context.toast(
            toastMessage: 'Room numbers cannot be empty',
            type: ToastSnackBarType.warning,
          );
          return;
        }
        if (_selectedFiles.isEmpty) {
          context.toast(
            toastMessage: 'You must select at least one image',
            type: ToastSnackBarType.warning,
          );
          return;
        }
        final List<String> files = [];
        for (File file in _selectedFiles) {
          String fileName =
              'uploads/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
          final response = await cloudinary.upload(
            file: file.path,
            fileBytes: file.readAsBytesSync(),
            resourceType: CloudinaryResourceType.image,
            folder: 'nosk',
            fileName: fileName,
          );
          if (response.isSuccessful) {
            String downloadUrl = response.url ?? '';
            files.add(downloadUrl);
          }
        }
        if (files.length != _selectedFiles.length) {
          if (mounted) {
            context.toast(
              toastMessage: 'Error uploading images, please try again',
              type: ToastSnackBarType.danger,
            );
          }
          return;
        }
        await Future.wait(
          files.map(
            (file) => cloudinary.destroy(
              'dvid1qlwp',
              url: file,
              resourceType: CloudinaryResourceType.image,
            ),
          ),
        );

        final newRoom = RoomModel(
          name: _roomNameController.text,
          description: _descriptionController.text,
          isAvailable: true,
          amenities: _amenities,
          images: files,
          price:
              NumberFormat("#,###.##").parse(_priceController.text).toDouble(),
          roomNumber: _roomNumbers,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _roomLogic.addRoom(newRoom: newRoom);
        _formKey.currentState?.reset();
        _amenities.clear();
        _selectedFiles.clear();
        _roomNumbers.clear();
        _roomNameController.clear();
        _descriptionController.clear();
        _priceController.clear();
        _amenitiesController.clear();
        _roomNumberController.clear();
        if (mounted) {
          context.toast(
            toastMessage: 'Room Created',
            type: ToastSnackBarType.success,
          );
        }
      }
    } catch (error) {
      if (mounted) {
        context.toast(
          toastMessage: error.toString(),
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Room'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please provide the following to create new room.',
              style: context.textTheme.bodySmall,
            ).addOpacity(0.6),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _roomNameController,
              style: context.textTheme.bodySmall,
              autofocus: true,
              enableSuggestions: true,
              maxLength: 84,
              keyboardType: TextInputType.text,
              validator: Validatorless.required('Room name is required'),
              decoration: const InputDecoration(
                labelText: 'Room Name',
                hintText: 'Enter room name',
              ),
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _descriptionController,
              style: context.textTheme.bodySmall,
              autofocus: false,
              enableSuggestions: true,
              maxLength: 4048,
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 6,
              validator: Validatorless.required('Description is required'),
              decoration: InputDecoration(
                contentPadding: 10.cl(10, 20).pdYX(15.cl(15, 30)),
                labelText: 'Description',
                hintText: 'Enter room description',
              ),
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _priceController,
              style: context.textTheme.bodySmall,
              autofocus: false,
              enableSuggestions: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: Validatorless.multiple([
                Validatorless.required('Price is required'),
                Validatorless.regex(
                    RegExp(r'^[\d|\.|\,]+'), 'Price must be a number')
              ]),
              inputFormatters: [NumberFormatter()],
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: 'Enter room price',
                prefixIcon: Text(''.toMoney).center.sized(
                      width: 18.cl(16, 26),
                    ),
              ),
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _roomNumberController,
              style: context.textTheme.bodySmall,
              autofocus: false,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Room Number',
                hintText: 'Enter room number.',
                suffixIcon: TextButton(
                  onPressed: () {
                    if (_roomNumberController.text.isEmpty) {
                      context.toast(
                        toastMessage: 'Room number cannot be empty',
                        type: ToastSnackBarType.info,
                      );
                      return;
                    }
                    if (_roomNumbers
                        .map((v) => v.toLowerCase().trim())
                        .contains(
                            _roomNumberController.text.toLowerCase().trim())) {
                      context.toast(
                        toastMessage: 'Room number already exists',
                        type: ToastSnackBarType.warning,
                      );
                      return;
                    }
                    _roomNumbers.add(_roomNumberController.text);
                    _roomNumberController.text = '';
                  },
                  child: Text('Add'),
                ),
              ),
            ),
            10.cl(10, 20).hSpacer,
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Numbers',
                    style: context.textTheme.headlineSmall,
                  ),
                  10.cl(10, 20).hSpacer,
                  if (_roomNumbers.isEmpty)
                    Text(
                      'No room numbers added yet.',
                      style: context.textTheme.bodySmall,
                    ).addOpacity(0.6).center.expand
                  else
                    Wrap(
                      spacing: 8.cl(4, 12),
                      runSpacing: 8.cl(4, 12),
                      children: _roomNumbers.map((roomNumber) {
                        return Chip(
                          label: Text(
                            roomNumber.toUpperCase(),
                            style: context.textTheme.bodySmall,
                          ),
                          deleteIconColor: Colors.red,
                          deleteButtonTooltipMessage: 'Remove Room Number',
                          onDeleted: () {
                            _roomNumbers.remove(roomNumber);
                          },
                        );
                      }).toList(),
                    )
                        .scrollable(
                          physics: const BouncingScrollPhysics(),
                        )
                        .expand
                ],
              ).sized(
                width: 100.w,
                height: 200,
              ),
            ),
            10.cl(10, 20).hSpacer,
            TextFormField(
              controller: _amenitiesController,
              style: context.textTheme.bodySmall,
              autofocus: false,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Amenities',
                hintText: 'Enter amenity.',
                suffixIcon: TextButton(
                  onPressed: () {
                    if (_amenitiesController.text.isEmpty) {
                      context.toast(
                        toastMessage: 'Amenity cannot be empty',
                        type: ToastSnackBarType.info,
                      );
                      return;
                    }
                    if (_amenities.map((v) => v.toLowerCase().trim()).contains(
                        _amenitiesController.text.toLowerCase().trim())) {
                      context.toast(
                        toastMessage: 'Amenity already exists',
                        type: ToastSnackBarType.warning,
                      );
                      return;
                    }
                    _amenities.add(_amenitiesController.text);
                    _amenitiesController.text = '';
                  },
                  child: Text('Add'),
                ),
              ),
            ),
            10.cl(10, 20).hSpacer,
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amenities',
                    style: context.textTheme.headlineSmall,
                  ),
                  10.cl(10, 20).hSpacer,
                  if (_roomNumbers.isEmpty)
                    Text(
                      'No amenities added yet.',
                      style: context.textTheme.bodySmall,
                    ).addOpacity(0.6).center.expand
                  else
                    Wrap(
                      spacing: 8.cl(4, 12),
                      runSpacing: 8.cl(4, 12),
                      children: _amenities.map((amenity) {
                        return Chip(
                          label: Text(
                            amenity.toUpperCase(),
                            style: context.textTheme.bodySmall,
                          ),
                          deleteIconColor: Colors.red,
                          deleteButtonTooltipMessage: 'Remove Room Number',
                          onDeleted: () {
                            _amenities.remove(amenity);
                          },
                        );
                      }).toList(),
                    )
                        .scrollable(
                          physics: const BouncingScrollPhysics(),
                        )
                        .expand
                ],
              ).sized(
                width: 100.w,
                height: 200,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Images',
                  style: context.textTheme.headlineSmall,
                ),
                10.cl(10, 20).hSpacer,
                if (_selectedFiles.isEmpty)
                  Text(
                    'No images selected.',
                    style: context.textTheme.bodySmall,
                  ).addOpacity(0.6).center.expand
                else
                  ListView.builder(
                    itemCount: _selectedFiles.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final image = _selectedFiles[index];
                      return Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            margin: 10.cl(10, 20).pdXY(10.cl(10, 20)),
                            width: 30.cw(100, 350),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: 10.cl(10, 20).brcAll,
                              image: DecorationImage(
                                image: FileImage(image),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ).positionFill(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedFiles.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                              backgroundColor: Colors.red.all,
                              foregroundColor: Colors.white.all,
                              fixedSize: 16.cl(16, 28).sized.all,
                              padding: 0.cl(0, 0).pdAll.all,
                            ),
                          ).position(
                            top: 0,
                            left: 0,
                          )
                        ],
                      ).aspectRatio(aspectRatio: 1);
                    },
                  ).expand
              ],
            ).sized(height: 210),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Select Images'),
            ),
            10.hSpacer,
            Obx(
              () => ElevatedButton.icon(
                onPressed: _isLoading.isFalse.whenOnly(use: onSubmit),
                style: ButtonStyle(minimumSize: Size(240, 26.cl(30, 55)).all),
                icon: _isLoading.isTrue.whenOnly(
                  use: CircularProgressIndicator(
                    backgroundColor: context.theme.primaryColor.lighten(20),
                    color: Colors.white,
                    strokeWidth: 2.cl(2, 4),
                  ).sized(
                    width: 18.cl(20, 34),
                    height: 18.cl(20, 34),
                  ),
                ),
                label: Text('Create Room'),
              ),
            ).center,
            50.cl(50, 140).hSpacer
          ],
        ),
      )
          .scrollable()
          .contain(
            width: 100.w,
            height: 100.h,
            padding: 15.cl(15, 35).pdX,
            color: context.theme.scaffoldBackgroundColor,
          )
          .gestureHandler(
            onTap: context.focus.unfocus,
          ),
    );
  }
}
