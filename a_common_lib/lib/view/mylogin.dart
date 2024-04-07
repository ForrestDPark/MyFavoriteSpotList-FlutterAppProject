import 'package:flutter/material.dart';

import 'login/after_login.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late TextEditingController userIdController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(50.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/login.png'),
                    radius: 70,
                  ),
                ),
                Padding(
                  // sized box 를 써서 id Tf 를 줄일수 있다.
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(
                      labelText: '사용자 ID 를 입력하세요 ',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '패스워드 를 입력하세요 ',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      //
                      checkPassword();
                    },
                    child: const Text('Log In'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // functions
  checkPassword() {
    if (userIdController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _errorSnackBar();
    } else {
      // 빈 칸이 아닐때 로그인 프로세스
      if (userIdController.text.trim() == 'root' &&
          passwordController.text.trim() == 'qwer1234') {
        _showDialog();
      } else {
        _warnSnacBar();
      }
    }
  }

  // 아무것도 안썼을 때
  _errorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("사용자 Id 와 암호를 입력하세요. "),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("환영합니다."),
          content: const Text("신분이 확인 되었습니다."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // alert 르 없애고 이동을 해야 뒤에 alert 가 안보임.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AfterLogin(
                          Id: userIdController.text,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }

  _warnSnacBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("사용자 ID나 암호가 일치하지 않습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }
} // End
