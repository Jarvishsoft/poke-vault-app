import 'package:poke_vault/app/packages/packages.dart';

class AttributeColumn extends StatelessWidget {
  final String label;
  final String value;
  const AttributeColumn({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: valueStyle),
        const SizedBox(height: 4),
        Text(label, style: labelStyle),
      ],
    );
  }
}
