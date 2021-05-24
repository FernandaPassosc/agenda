import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  static String tag = '/home';
  @override
  Widget build(BuildContext context) {
    var tituloController = TextEditingController();
    var descricaoController = TextEditingController();
    var sobrenome = TextEditingController();
    var email = TextEditingController();
    var endereco = TextEditingController();
    var CEP = TextEditingController();
    var ID = 0;

    FirebaseFirestore db = FirebaseFirestore.instance;
    var snap = db.collection("contatos").where('excluido', isEqualTo: false).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda de Contatos"),
      ),
      body: StreamBuilder(
        stream: snap,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot
            ) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, i){
                var item = snapshot.data.docs[i];

                return ListTile(
                  title: Text(item['Nome']),
                  subtitle: Text(item['Telefone']),
                  onTap:(){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            content: SingleChildScrollView
                              (scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Nome"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o nome",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: tituloController,
                                    ),

                                    SizedBox(height: 20,),
                                    Text("Telefone"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o telefone",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: descricaoController,
                                    ),
                                    SizedBox(height: 20,),
                                    Text("Sobrenome"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o sobrenome",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: sobrenome,
                                    ),
                                    SizedBox(height: 20,),
                                    Text("Email"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: email,
                                    ),
                                    SizedBox(height: 20,),
                                    Text("Endereço"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o endereço",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: endereco,
                                    ),
                                    SizedBox(height: 20,),
                                    Text("CEP"),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Digite o CEP",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: CEP,
                                    ),

                                  ],
                                )
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Cancelar"
                                  )
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await db.collection("contatos").
                                    add({'Nome': tituloController.text,
                                      'Telefone': descricaoController.text,
                                      'concluido': false,
                                      'excluido': false} );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Salvar"
                                  )
                              ),
                            ],
                          );
                        }
                    );
                  },
                  trailing: TextButton.icon(icon:
                    Icon(Icons.auto_delete_rounded),
                      label: Text(""),
                      onPressed:()
                      async{
                          await db.collection("contatos").doc(item.id).update({'excluido': true});

                    }
                  ),
                );
              },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: SingleChildScrollView
                    (scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Nome"),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Digite o nome",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: tituloController,
                          ),

                          SizedBox(height: 20,),
                          Text("Telefone"),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Digite o telefone",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: descricaoController,
                          ),
                        SizedBox(height: 20,),
                        Text("Sobrenome"),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Digite o sobrenome",
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                        ),
                        ),
                        controller: sobrenome,
                        ),
                        SizedBox(height: 20,),
                          Text("Email"),
                          TextFormField(
                          decoration: InputDecoration(
                          hintText: "Digite o email",
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                          ),
                          controller: email,
                          ),
                          SizedBox(height: 20,),
                          Text("Endereço"),
                          TextFormField(
                          decoration: InputDecoration(
                          hintText: "Digite o endereço",
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                          ),
                          controller: endereco,
                          ),
                          SizedBox(height: 20,),
                          Text("CEP"),
                          TextFormField(
                          decoration: InputDecoration(
                          hintText: "Digite o CEP",
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                          ),
                          controller: CEP,
                          ),

                        ],
                      )
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancelar"
                        )
                    ),
                    TextButton(
                        onPressed: () async {
                          await db.collection("contatos").
                          add({'Nome': tituloController.text,
                            'Telefone': descricaoController.text,
                            'concluido': false,
                            'excluido': false} );
                          Navigator.of(context).pop();
                        },
                        child: Text("Salvar"
                        )
                    ),
                  ],
                );
              }
          );
        },
        tooltip: "Adicionar novo",
        child: Icon(Icons.add),
      ),
    );
  }
}