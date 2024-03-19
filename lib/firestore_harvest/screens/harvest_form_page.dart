import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_textfield.dart';
import 'package:foresty/firestore_batch/models/batch.dart';

class HarvestFormPage extends StatefulWidget {
  ProductBatch? batch;

  HarvestFormPage({Key? key, this.batch}) : super(key: key);

  @override
  _HarvestFormPageState createState() => _HarvestFormPageState();
}

class _HarvestFormPageState extends State<HarvestFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ValueNotifier<String> selectedUnit = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedSaleType = ValueNotifier<String>('Selecione');
  final TextEditingController _saleValue = TextEditingController();
  final TextEditingController _labelValue = TextEditingController();
  final TextEditingController _quantityProduced = TextEditingController();
  final TextEditingController _quantityOfLabels = TextEditingController();
  final TextEditingController _quantityLabel = TextEditingController();

  String harvestDate = '';

  final _unitOfMeasurementItems = [
    'Selecione',
    'Quilo (kg)',
    'Maço',
    'Litro (L)',
    'Unidade',
    'Saca (50kg)',
    'Cacho',
  ];

  final _saleTypeItems = [
    'Selecione',
    'Direta (para o consumidor)',
    'Revenda (outro comerciante)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Colheita'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.topLeft,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Data da Colheita',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd/MM/yyyy',
                  initialValue: harvestDate,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.green[800]!,
                  ),
                  dateLabelText: 'Ex: 31/10/2023',
                  onChanged: (val) {
                    setState(() {
                      harvestDate = val;
                    });
                  },
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[900]!,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Quantidade produzida',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 180,
                child: MyTextFieldWrapper(
                  hintText: 'Número',
                  controller: _quantityProduced,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe a quantidade vendida';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Unidade de medida',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              MyDropdownFormField(
                selectedValueNotifier: selectedSaleType,
                itemsList: _unitOfMeasurementItems,
                onChanged: (value) {
                  setState(() {
                    selectedSaleType.value = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: MyButton(
                      textButton: 'Descartar',
                      isRed: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: MyButton(
                      onTap: () async {
                        // Feche o formulário ou faça qualquer outra ação necessária
                        Navigator.pop(context);
                      },
                      textButton: 'Salvar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
