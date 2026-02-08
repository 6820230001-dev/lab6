import 'package:flutter/material.dart';
import 'package:lab6/page/bmipage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? _gender;
  double _ageValue = 18;

  InputDecoration inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "BMI Calculator",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ข้อมูลส่วนตัว",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: nameController,
                          decoration:
                              inputStyle("ชื่อ", Icons.person),
                          validator: (v) =>
                              v!.isEmpty ? "กรุณากรอกชื่อ" : null,
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: lastnameController,
                          decoration:
                              inputStyle("นามสกุล", Icons.person_outline),
                          validator: (v) =>
                              v!.isEmpty ? "กรุณากรอกนามสกุล" : null,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "อายุ ${_ageValue.toInt()} ปี",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Slider(
                          value: _ageValue,
                          min: 10,
                          max: 100,
                          divisions: 90,
                          activeColor: Colors.blue,
                          onChanged: (v) =>
                              setState(() => _ageValue = v),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ข้อมูลร่างกาย",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration:
                              inputStyle("น้ำหนัก (กก.)", Icons.monitor_weight),
                          validator: (v) =>
                              v!.isEmpty ? "กรุณากรอกน้ำหนัก" : null,
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration:
                              inputStyle("ส่วนสูง (ซม.)", Icons.height),
                          validator: (v) =>
                              v!.isEmpty ? "กรุณากรอกส่วนสูง" : null,
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "เพศ",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _genderButton(
                              label: "ชาย",
                              icon: Icons.male,
                              value: "male",
                            ),
                            const SizedBox(width: 12),
                            _genderButton(
                              label: "หญิง",
                              icon: Icons.female,
                              value: "female",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_gender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("กรุณาเลือกเพศ")),
                          );
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bmipage2(
                              name: nameController.text,
                              lastname: lastnameController.text,
                              gender: _gender!,
                              age: _ageValue.toInt(),
                              weight: int.parse(weightController.text),
                              height: int.parse(heightController.text),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "คำนวณ BMI",
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
      ),
    );
  }

  Widget _genderButton({
    required String label,
    required IconData icon,
    required String value,
  }) {
    final bool selected = _gender == value;

    return ChoiceChip(
      label: Row(
        children: [
          Icon(icon,
              color: selected ? Colors.white : Colors.black),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      selectedColor: Colors.blue,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
      onSelected: (_) => setState(() => _gender = value),
    );
  }
}
