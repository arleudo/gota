import 'package:flutter/material.dart';
import 'package:gota/components/g_text_field.dart';
import 'package:gota/models/tank.dart';
import 'package:gota/services/tank_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color colorPrimary = const Color.fromARGB(255, 81, 180, 86);
  String? selectedCarModel;
  List<String> carModels = [];
  List<Tank> tankList = [];
  Tank? selectedTank;
  String? id;

  TextEditingController litroController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController abastecimentoController = TextEditingController();

  final TankService service = TankService();

  @override
  void initState() {
    super.initState();
    loadCarModels();
  }

  void loadCarModels() async {
    List<Tank> tanks = await service.loadModels();
    setState(() {
      tankList = tanks;
    });
  }



  Future<void> calcular() async {
    final literValue = litroController.text;
    final totalValue = totalController.text;

    final success = await service.calculate(
      id!,
      literValue
    );

    print(success!.value.toString());
    totalController.text = 'Valor a pagar: RS ' + success.value.toString();
    abastecimentoController.text = success.filled.toString() + " litros abastecidos";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("G.O.T.A.", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Bem-vindo ao Gota!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage("assets/gota.png"),
                width: 100,
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<Tank>(
                value: selectedTank,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Modelo do Carro',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorPrimary),
                  ),
                ),
                items: tankList.map((Tank tank) {
                  return DropdownMenuItem<Tank>(
                    value: tank,
                    child: Text(tank.model!), // Exibe o modelo
                  );
                }).toList(),
                onChanged: (Tank? newValue) {
                  setState(() {
                    selectedTank = newValue;
                    id = selectedTank?.id;
                  });
                },
              ),
              const SizedBox(height: 20),
              GTextField(
                labelText: "Valor Por Litro",
                controller: litroController,
              ),
              const SizedBox(height: 20),
              TextField(
                enabled: false,
                controller: abastecimentoController,
              ),
              const SizedBox(height: 20),
              TextField(
                enabled: false,
                controller: totalController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: calcular,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
