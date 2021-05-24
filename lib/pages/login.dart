import 'package:agenda/pages/signIn.dart';
import 'package:flutter/material.dart';
import 'package:agenda/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatefulWidget {
  static String tag = '/login';
  @override
  _loginState createState() => _loginState();
}
int cont = 0;
class _loginState extends State<login> {
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _validarUsuario(String nome, String senha, BuildContext context) async{
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      var snap = await db.collection("usuarios").where('usuario', isEqualTo: _controllerLogin.text).where('senha', isEqualTo: _controllerSenha.text).get();

      if (snap.size > 0)  {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          ),
        );
      }
    } catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USUÁRIOS"),
      ),
      body: Form( //consegue armazenar o estado dos campos de texto e além disso, fazer a validação
        key: _formKey, //estado do formulário
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "email:",
                    hintText: "Digite o email"
                ),
                controller: _controllerLogin
            ),
            SizedBox(height: 10,),
            TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Senha:",
                    hintText: "Digite a senha"
                ),
                obscureText: true,
                controller: _controllerSenha
            ),
            SizedBox(height: 20,),
            Container(
              height: 46,
              child: ElevatedButton(
                  child: Text("Entrar",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),),
                  onPressed: (){
                    bool formOk = _formKey.currentState.validate();
                    if(! formOk){

                      return;
                    }
                    else{
                      _validarUsuario(_controllerLogin.text, _controllerSenha.text, context);
                    }
                  }
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 46,
              child: ElevatedButton(
                  child: Text("Cadastrar",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),),
                  onPressed: (){
                    bool formOk = _formKey.currentState.validate();
                    if(! formOk){
                      return;
                    }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => signIn()
                        ),
                      );
                    }

                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}