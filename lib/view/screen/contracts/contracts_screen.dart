import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/view/base/appbar_notification_button.dart';
import 'package:el_biz/view/screen/contracts/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contracts'),
          actions: const [
            AppbarNotificationButton(),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<ContractsBloc, ContractsState>(builder: (context, contractState) {
            return ListView.builder(
              itemCount: contractState.contracts.length,
              itemBuilder: (context, index) {
                return ContractItem(contractModel: contractState.contracts[index]);
              },
            );
          }),
        ));
  }
}
