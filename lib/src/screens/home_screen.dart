part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showAddTaskDialog(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorName.white,
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth, context.percentHeight * 20),
        child: _buildCustomAppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskDialog(context);
        },
        backgroundColor: colorName.primaryDark,
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveCommons().listenToTask(),
        builder: (BuildContext context, Box<TaskModel> value, Widget? child) {
          var data = value.values
              .toList()
              .sortedBy((a, b) => (a.isCompleted) ? 1 : -1);

          return (data.isEmpty)
              ? StringName.titleOfTitleTextField.richText
                  .withTextSpanChildren([
                    StringName.addNewTaskHere.textSpan.bold
                        .color(colorName.success)
                        .make()
                  ])
                  .bold
                  .color(colorName.black)
                  .makeCentered()
                  .onTap(() {
                    showAddTaskDialog(context);
                  })
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return _buildCard(context, data[index])
                        .pOnly(top: (index == 0) ? 16 : 0);
                  },
                  separatorBuilder: (context, index) => const VxDivider(
                    color: colorName.grey,
                  ).px24(),
                  itemCount: data.length,
                );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, TaskModel data) {
    return ListTile(
      selected: !data.isCompleted,
      tileColor: colorName.white,
      selectedColor: colorName.black,
      onTap: () {
        BlocProvider.of<UpdateCompleteTaskCubit>(context).updateTask(data);
      },
      leading: Icon(
        (data.isCompleted)
            ? Icons.check_circle_outline_rounded
            : Icons.circle_outlined,
        color: (data.isCompleted) ? colorName.success : colorName.grey,
      ),
      title: _customText(data.title,
          isSubtitle: false, isCompleted: data.isCompleted),
      subtitle: _customText(data.subtitle, isCompleted: data.isCompleted),
      trailing: BlocListener<DeleteTaskCubit, DeleteTaskState>(
        listener: (context, state) {
          if (state is DeleteTaskIsSuccess) {
            Commons().showMySnackBar(context, state.message, statusId: 1);
          }
          if (state is DeleteTaskIsFailed) {
            Commons().showMySnackBar(context, state.message, statusId: 3);
          }
        },
        child: IconButton(
            onPressed: () {
              BlocProvider.of<DeleteTaskCubit>(context).deleteTask(data);
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: colorName.error,
            )),
      ),
    );
  }

  Widget _customText(String text,
      {bool isSubtitle = true, bool isCompleted = false}) {
    return text.text
        .textStyle(
          TextStyle(
              fontWeight: (isSubtitle) ? FontWeight.normal : FontWeight.bold,
              decoration: (isCompleted)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        )
        .size(isSubtitle ? 12 : 14)
        .make();
  }

  Widget _buildCustomAppBar() {
    return VxBox(
      child: SafeArea(
        child: VStack([
          "${StringName.mainTitle},\n"
              .richText
              .color(colorName.white)
              .size(10)
              .withTextSpanChildren([
            StringName.mainSubTitle.textSpan
                .color(colorName.white)
                .bold
                .size(16)
                .make()
          ]).make()
        ]),
      ),
    ).p24.color(colorName.primary).bottomRightRounded(value: 24).withShadow(
        [BoxShadow(blurRadius: 20, color: colorName.shadow)]).make();
  }
}
