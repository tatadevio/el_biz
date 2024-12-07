import 'package:el_biz/controller/contracts_controller.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/contracts/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contracts'),
          actions: [
            AppbarNotificationButton(),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<ContractsController>(builder: (contractsController) {
            return ListView.builder(
              itemCount: contractsController.contracts.length,
              itemBuilder: (context, index) {
                return ContractItem(contractModel: contractsController.contracts[index]);
              },
            );
          }),
        ));
  }
}
