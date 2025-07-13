import 'package:flutter/material.dart';
import 'divisor_hint_card.dart';
import 'partitioning_method_hint_card.dart';
import 'necessary_conditions_hint_card.dart';

class HintCardSection extends StatelessWidget {
  const HintCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Divisibility Hints:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        DivisorHintCard(
          divisor: '2',
          rule: 'Ends with 0 2 4 6 or 8',
          positiveExample: '24 ends with 4 ⇒ 2|24',
          negativeExample: '35 ends with 5 ⇒ 2∤35',
          explanation: 'Why: Any number can be written as 10a+b where b is the last digit. Since 2 divides 10, the number is divisible by 2 if and only if the last digit is divisible by 2.',
        ),
        DivisorHintCard(
          divisor: '3',
          rule: 'Sum of digits divisible by 3',
          positiveExample: '123: 1+2+3=6 and 3|6 ⇒ 3|123',
          negativeExample: '125: 1+2+5=8 and 3∤8 ⇒ 3∤125',
          explanation: 'Why: Take 247 = 2×100 + 4×10 + 7 = (2+4+7) + (2×99 + 4×9). Since 99 and 9 are divisible by 3, only the digit sum 2+4+7=13 determines divisibility. Since 3∤13, we have 3∤247.',
        ),
        DivisorHintCard(
          divisor: '4',
          rule: 'Last 2 digits divisible by 4',
          positiveExample: '1236: last 2 digits 36 and 4|36 ⇒ 4|1236',
          negativeExample: '1234: last 2 digits 34 and 4∤34 ⇒ 4∤1234',
          explanation: 'Why: Any number can be written as 100a+b where b is the last 2 digits. Since 4 divides 100, the number is divisible by 4 if and only if the last 2 digits are divisible by 4.',
        ),
        DivisorHintCard(
          divisor: '5',
          rule: 'Ends with 0 or 5',
          positiveExample: '75 ends with 5 ⇒ 5|75',
          negativeExample: '73 ends with 3 ⇒ 5∤73',
          explanation: 'Why: Any number can be written as 10a+b where b is the last digit. Since 5 divides 10, the number is divisible by 5 if and only if the last digit is divisible by 5.',
        ),
        DivisorHintCard(
          divisor: '6',
          rule: 'Divisible by both 2 AND 3',
          positiveExample: '18: even and 1+8=9 and 3|9 ⇒ 6|18',
          negativeExample: '15: odd ⇒ 6∤15',
          explanation: 'Why: Since 2 and 3 share no common factors and 2×3 = 6, a number is divisible by 6 if and only if it is divisible by both 2 and 3.',
        ),
        DivisorHintCard(
          divisor: '8',
          rule: 'Last 3 digits divisible by 8',
          positiveExample: '1024: last 3 digits 024 and 8|24 ⇒ 8|1024',
          negativeExample: '1026: last 3 digits 026 and 8∤26 ⇒ 8∤1026',
          explanation: 'Why: Any number can be written as 1000a+b where b is the last 3 digits. Since 8 divides 1000, the number is divisible by 8 if and only if the last 3 digits are divisible by 8.',
        ),
        DivisorHintCard(
          divisor: '9',
          rule: 'Sum of digits divisible by 9',
          positiveExample: '729: 7+2+9=18 and 9|18 ⇒ 9|729',
          negativeExample: '728: 7+2+8=17 and 9∤17 ⇒ 9∤728',
          explanation: 'Why: Take 247 = 2×100 + 4×10 + 7 = (2+4+7) + (2×99 + 4×9). Since 99 and 9 are divisible by 9, only the digit sum 2+4+7=13 determines divisibility. Since 9∤13, we have 9∤247.',
        ),
        DivisorHintCard(
          divisor: '10',
          rule: 'Ends with 0',
          positiveExample: '120 ends with 0 ⇒ 10|120',
          negativeExample: '125 ends with 5 ⇒ 10∤125',
          explanation: 'Why: Any number can be written as 10a+b where b is the last digit. For divisibility by 10, the last digit must be 0.',
        ),
        DivisorHintCard(
          divisor: '12',
          rule: 'Divisible by both 3 AND 4',
          positiveExample: '36: 3+6=9 and 3|9 and 4|36 ⇒ 12|36',
          negativeExample: '35: 3+5=8 and 3∤8 ⇒ 12∤35',
          explanation: 'Why: Since 3 and 4 share no common factors and 3×4 = 12, a number is divisible by 12 if and only if it is divisible by both 3 and 4.',
        ),
        const SizedBox(height: 10),
        const Text(
          'Advanced Method:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 8),
        const NecessaryConditionsHintCard(),
        const SizedBox(height: 8),
        const PartitioningMethodHintCard(),
      ],
    );
  }
}