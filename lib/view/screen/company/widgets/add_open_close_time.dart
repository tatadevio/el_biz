import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/seller_controller.dart';
import '../../../../data/model/base/timing_date_model.dart';
import '../../../../utils/color_resources.dart';
import '../../../base/custom_button.dart';

class BottomSheetContentTiming extends StatelessWidget {
  final List<DaySchedule> schedule;

  const BottomSheetContentTiming({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return GetBuilder<SellerController>(builder: (sellerController) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "working_hours".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            for (int i = 0; i < schedule.length; i++)
              DayRow(
                daySchedule: schedule[i],
                sellerController: sellerController,
                index: i,
              ),
            // ...schedule.map((daySchedule) {
            //   return DayRow(daySchedule: daySchedule, sellerController: sellerController);
            // }).toList(),
            const SizedBox(height: 16),
            Text(
              "lunch_break".tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LunchBreakRow(),
            const SizedBox(height: 16),
            Center(
              child: CustomButton(
                onTap: () {
                  Get.back();
                },
                title: "save".tr,
                height: 45,
                width: size.width * .9,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DayRow extends StatelessWidget {
  final DaySchedule daySchedule;
  final SellerController sellerController;
  final int index;
  final TextEditingController openingTimeController = TextEditingController();
  final TextEditingController closingTimeController = TextEditingController();

  DayRow({super.key, required this.daySchedule, required this.sellerController, required this.index}) {
    openingTimeController.text = daySchedule.openingTime;
    closingTimeController.text = daySchedule.closingTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Checkbox(
                  activeColor: ColorResources.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  value: sellerController.scheduleTiming[index].isOpen,
                  onChanged: (value) {
                    daySchedule.isOpen = value ?? false;
                    sellerController.updateDay(index, value!);
                  },
                ),
                Text(
                  daySchedule.day,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: openingTimeController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  daySchedule.openingTime = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorResources.dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: closingTimeController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  daySchedule.closingTime = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorResources.dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LunchBreakRow extends StatelessWidget {
  final TextEditingController lunchStartController = TextEditingController();
  final TextEditingController lunchEndController = TextEditingController();

  LunchBreakRow({super.key}) {
    // Default values for lunch break
    lunchStartController.text = "13:00";
    lunchEndController.text = "14:00";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "lunch_break".tr,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: lunchStartController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorResources.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: lunchEndController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorResources.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
