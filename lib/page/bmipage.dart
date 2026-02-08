import 'package:flutter/material.dart';

class Bmipage2 extends StatefulWidget {
  const Bmipage2({
    super.key,
    required this.name,
    required this.lastname,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
  });

  final String name;
  final String lastname;
  final String gender;
  final int age;
  final int weight;
  final int height;

  @override
  State<Bmipage2> createState() => _Bmipage2State();
}

class _Bmipage2State extends State<Bmipage2> {
  late double bmi;
  late String bmiResult;
  late Color bmiColor;

  @override
  void initState() {
    super.initState();
    _calculateBMI();
  }

  void _calculateBMI() {
    final double h = widget.height / 100;
    bmi = widget.weight / (h * h);

    if (bmi < 18.5) {
      bmiResult = "ผอม";
      bmiColor = Colors.orange;
    } else if (bmi < 25) {
      bmiResult = "ปกติ";
      bmiColor = Colors.green;
    } else if (bmi < 30) {
      bmiResult = "อ้วน";
      bmiColor = Colors.deepOrange;
    } else {
      bmiResult = "อ้วนมาก";
      bmiColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String genderText = widget.gender == "male" ? "ชาย" : "หญิง";

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "ผลการคำนวณ BMI",
                  style: TextStyle(
                    fontSize: 26,
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
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            widget.gender == "male"
                                ? Icons.male
                                : Icons.female,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "${widget.name} ${widget.lastname}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "เพศ $genderText • อายุ ${widget.age} ปี",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const Divider(height: 32),
                        _infoRow("น้ำหนัก", "${widget.weight} กก."),
                        _infoRow("ส่วนสูง", "${widget.height} ซม."),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
=
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          "ค่า BMI",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: bmiColor.withOpacity(0.15),
                          ),
                          child: Center(
                            child: Text(
                              bmi.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: bmiColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          bmiResult,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: bmiColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      "ย้อนกลับ",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
