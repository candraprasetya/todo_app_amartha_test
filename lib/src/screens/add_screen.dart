part of 'screens.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: VStack(
        [
          //TEXTFIELD TASK
          _buildTextField(StringName.yourTask, titleController),
          16.heightBox,
          //TEXTFIELD TASK DESCRIPTION
          _buildTextField(StringName.taskDescription, subtitleController),
          24.heightBox,
          //BUTTON
          BlocConsumer<AddTaskCubit, AddTaskState>(
            listener: (context, state) {
              if (state is AddTaskIsSuccess) {
                Commons().showMySnackBar(context, state.message, statusId: 1);
                titleController.clear();
                subtitleController.clear();
                if (!state.addMoreTask) {
                  Navigator.pop(context);
                }
              }
              if (state is AddTaskIsFailed) {
                Commons().showMySnackBar(context, state.message, statusId: 3);
              }
            },
            builder: (context, state) {
              return HStack([
                _buildButton(
                        StringName.saveAndAddMore,
                        () => BlocProvider.of<AddTaskCubit>(context).addNewTask(
                            titleController.text, subtitleController.text,
                            addMoreTask: true),
                        isLoading: (state is AddTaskIsLoading))
                    .expand(flex: 2),
                16.widthBox,
                _buildButton(
                        StringName.newTask,
                        () => BlocProvider.of<AddTaskCubit>(context).addNewTask(
                            titleController.text, subtitleController.text),
                        isPrimary: false,
                        isLoading: (state is AddTaskIsLoading))
                    .expand(flex: 1)
              ]);
            },
          ),
        ],
        axisSize: MainAxisSize.min,
      ).p16(),
    );
  }

  Widget _buildButton(String title, Function()? onTap,
      {bool isLoading = false, bool isPrimary = true}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? colorName.primary : colorName.white,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: colorName.primary))),
      onPressed: isLoading ? null : onTap,
      child: title.text.center
          .color(isPrimary ? colorName.white : colorName.primary)
          .bold
          .make(),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: hint,
      ),
    );
  }
}
