import 'package:employee_management/controller/user_list_notifier.dart';
import 'package:employee_management/model/user_model.dart';
import 'package:employee_management/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userListProvider = context.watch<UserListNotifier>();
    final userList = userListProvider.val ?? [];
    final nameCntrllr = useTextEditingController();
    final newEmailCntrllr = useTextEditingController();
    final designationCntrllr = useTextEditingController();
    final employeeIdCntrllr = useTextEditingController();
    final newUserName = useTextEditingController();
    final newUserDesignation = useTextEditingController();
    final newUserEmail = useTextEditingController();
    final newUserEmployeeId = useTextEditingController();
    final newUserNumber = useTextEditingController();
    final date = useState<String>("Date of birth");

    Future<String> pickDate() async {
      final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1950),
        currentDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      final date =
          "${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}";
      return date;
    }

    final userStream = UserRepository().fetchUser();
    // UserModel allData;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final userDetails = UserModel.fromFirestore(data[index]);
                    return Container(
                      height: 200,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            userDetails.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            userDetails.designation,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            userDetails.employeeId,
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.4,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                226,
                                                223,
                                                223,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              controller: nameCntrllr,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Name",
                                                contentPadding: EdgeInsets.only(
                                                  left: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                226,
                                                223,
                                                223,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              controller: newEmailCntrllr,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                contentPadding: EdgeInsets.only(
                                                  left: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                226,
                                                223,
                                                223,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              controller: designationCntrllr,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "designation",
                                                contentPadding: EdgeInsets.only(
                                                  left: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 16,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                255,
                                                226,
                                                223,
                                                223,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 0.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: employeeIdCntrllr,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Employee id",
                                                contentPadding: EdgeInsets.only(
                                                  left: 8,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              final name = nameCntrllr.text
                                                  .trim();
                                              final email = newEmailCntrllr.text
                                                  .trim();
                                              final designation =
                                                  designationCntrllr.text
                                                      .trim();
                                              final employeeId =
                                                  employeeIdCntrllr.text.trim();
                                              userListProvider.updateUser(
                                                name == "" ? null : name,
                                                email == "" ? null : email,
                                                designation == ""
                                                    ? null
                                                    : designation,
                                                employeeId == ""
                                                    ? null
                                                    : employeeId,
                                                userDetails.docId,
                                              );
                                              userListProvider
                                                      .val![index]
                                                      .name =
                                                  name;
                                              nameCntrllr.clear();
                                              newEmailCntrllr.clear();
                                              designationCntrllr.clear();
                                              employeeIdCntrllr.clear();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black,
                                                ),
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 70),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              userListProvider.deleteUser(userDetails.docId);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // child: ListView.builder(
            //   itemCount: userList.length,
            //   itemBuilder: (context, index) {
            //     final data = userList[index];
            //     final docId = data.docId;
            //     return Container(
            //       margin: EdgeInsets.all(8),
            //       height: 100,
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 0.5, color: Colors.black),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Row(
            //         children: [
            //           SizedBox(width: 40),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               Text(data.name),
            //               Text(data.designation),
            //               Text(data.employeeId),
            //             ],
            //           ),
            //           Expanded(
            //             child: IconButton(
            //               onPressed: () {
            //                 userListProvider.deleteUser(docId);
            //               },
            //               icon: Icon(Icons.delete),
            //             ),
            //           ),
            //           Expanded(
            //             child: IconButton(
            //               onPressed: () {
            //                 showModalBottomSheet(
            //                   isScrollControlled: true,
            //                   context: context,
            //                   builder: (context) {
            //                     return Padding(
            //                       padding: EdgeInsets.only(
            //                         bottom: MediaQuery.of(
            //                           context,
            //                         ).viewInsets.bottom,
            //                       ),
            //                       child: Container(
            //                         decoration: BoxDecoration(),
            //                         height:
            //                             MediaQuery.of(context).size.height *
            //                             0.4,
            //                         child: Column(
            //                           children: [
            //                             Container(
            //                               margin: EdgeInsets.symmetric(
            //                                 horizontal: 16,
            //                                 vertical: 16,
            //                               ),
            //                               decoration: BoxDecoration(
            //                                 color: const Color.fromARGB(
            //                                   255,
            //                                   226,
            //                                   223,
            //                                   223,
            //                                 ),
            //                                 borderRadius: BorderRadius.circular(
            //                                   10,
            //                                 ),
            //                                 border: Border.all(
            //                                   width: 0.5,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                               child: TextField(
            //                                 keyboardType:
            //                                     TextInputType.visiblePassword,
            //                                 controller: nameCntrllr,
            //                                 decoration: InputDecoration(
            //                                   border: InputBorder.none,
            //                                   hintText: "Name",
            //                                   contentPadding: EdgeInsets.only(
            //                                     left: 8,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Container(
            //                               margin: EdgeInsets.symmetric(
            //                                 horizontal: 16,
            //                                 vertical: 16,
            //                               ),
            //                               decoration: BoxDecoration(
            //                                 color: const Color.fromARGB(
            //                                   255,
            //                                   226,
            //                                   223,
            //                                   223,
            //                                 ),
            //                                 borderRadius: BorderRadius.circular(
            //                                   10,
            //                                 ),
            //                                 border: Border.all(
            //                                   width: 0.5,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                               child: TextField(
            //                                 keyboardType:
            //                                     TextInputType.visiblePassword,
            //                                 controller: newEmailCntrllr,
            //                                 decoration: InputDecoration(
            //                                   border: InputBorder.none,
            //                                   hintText: "Email",
            //                                   contentPadding: EdgeInsets.only(
            //                                     left: 8,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Container(
            //                               margin: EdgeInsets.symmetric(
            //                                 horizontal: 16,
            //                                 vertical: 16,
            //                               ),
            //                               decoration: BoxDecoration(
            //                                 color: const Color.fromARGB(
            //                                   255,
            //                                   226,
            //                                   223,
            //                                   223,
            //                                 ),
            //                                 borderRadius: BorderRadius.circular(
            //                                   10,
            //                                 ),
            //                                 border: Border.all(
            //                                   width: 0.5,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                               child: TextField(
            //                                 keyboardType:
            //                                     TextInputType.visiblePassword,
            //                                 controller: designationCntrllr,
            //                                 decoration: InputDecoration(
            //                                   border: InputBorder.none,
            //                                   hintText: "designation",
            //                                   contentPadding: EdgeInsets.only(
            //                                     left: 8,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             Container(
            //                               margin: EdgeInsets.symmetric(
            //                                 horizontal: 16,
            //                                 vertical: 16,
            //                               ),
            //                               decoration: BoxDecoration(
            //                                 color: const Color.fromARGB(
            //                                   255,
            //                                   226,
            //                                   223,
            //                                   223,
            //                                 ),
            //                                 borderRadius: BorderRadius.circular(
            //                                   10,
            //                                 ),
            //                                 border: Border.all(
            //                                   width: 0.5,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                               child: TextField(
            //                                 keyboardType: TextInputType.number,
            //                                 controller: employeeIdCntrllr,
            //                                 decoration: InputDecoration(
            //                                   border: InputBorder.none,
            //                                   hintText: "Employee id",
            //                                   contentPadding: EdgeInsets.only(
            //                                     left: 8,
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             GestureDetector(
            //                               onTap: () {
            //                                 final name = nameCntrllr.text
            //                                     .trim();
            //                                 final email = newEmailCntrllr.text
            //                                     .trim();
            //                                 final designation =
            //                                     designationCntrllr.text.trim();
            //                                 final employeeId = employeeIdCntrllr
            //                                     .text
            //                                     .trim();
            //                                 userListProvider.updateUser(
            //                                   name == "" ? null : name,
            //                                   email == "" ? null : email,
            //                                   designation == ""
            //                                       ? null
            //                                       : designation,
            //                                   employeeId == ""
            //                                       ? null
            //                                       : employeeId,
            //                                   docId,
            //                                 );
            //                                 nameCntrllr.clear();
            //                                 newEmailCntrllr.clear();
            //                                 designationCntrllr.clear();
            //                                 employeeIdCntrllr.clear();
            //                                 Navigator.pop(context);
            //                               },
            //                               child: Container(
            //                                 height: 50,
            //                                 width: 150,
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(10),
            //                                   border: Border.all(
            //                                     width: 0.5,
            //                                     color: Colors.black,
            //                                   ),
            //                                   color: Colors.black,
            //                                 ),
            //                                 child: Center(
            //                                   child: Text(
            //                                     "Submit",
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                       fontSize: 16,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             SizedBox(height: 70),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 );
            //               },
            //               icon: Icon(Icons.edit),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 223),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: newUserName,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            contentPadding: EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 223),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: newUserEmail,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            contentPadding: EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 223),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: TextField(
                          controller: newUserDesignation,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "designation",
                            contentPadding: EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 223),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: newUserEmployeeId,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Employee id",
                            contentPadding: EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 226, 223, 223),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: TextField(
                          controller: newUserNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "number",
                            contentPadding: EdgeInsets.only(left: 8),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 16),
                            child: Text(
                              "Date of birth  -  ${date.value}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: IconButton(
                              onPressed: () async {
                                final pickedDate = await pickDate();
                                date.value = pickedDate;
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final name = newUserName.text;
                            final email = newUserEmail.text;
                            final designation = newUserDesignation.text;
                            final employeeId = newUserEmployeeId.text;
                            final number = newUserNumber.text;
                            final newDate = date.value;
                            if (name.isNotEmpty &&
                                email.isNotEmpty &&
                                designation.isNotEmpty &&
                                employeeId.isNotEmpty &&
                                number.isNotEmpty &&
                                newDate.isNotEmpty) {
                              userListProvider.addUser(
                                name,
                                email,
                                employeeId,
                                designation,
                              );
                              newUserName.clear();
                              newUserNumber.clear();
                              newUserEmail.clear();
                              newUserEmployeeId.clear();
                              newUserDesignation.clear();
                              date.value = "Date of birth";
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Field empty"),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height *
                                        0.8,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                                color: Colors.black,
                              ),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
