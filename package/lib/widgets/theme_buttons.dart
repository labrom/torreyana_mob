import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const menuButtonVisualDensity = VisualDensity(
    horizontal: VisualDensity.minimumDensity,
    vertical: VisualDensity.minimumDensity);

const textElementFonts = [
  'Lora',
  'Anaheim',
  'Source Sans Pro',
  'PT Serif',
  'Antic Slab',
  'Scheherazade',
  'Gabriela',
  'Gamja Flower',
  'Inconsolata',
  'Glass Antiqua',
  'Averia Serif Libre',
  // 'Baloo Bhaina 2',
  // 'Baloo Da 2',
  'Scope One',
  'Suravaram'
];

class TextFontButton extends StatefulWidget {

  const TextFontButton({
    required this.onFontSelected, super.key,
    this.font,
  });
  final void Function(String) onFontSelected;
  final String? font;

  @override
  State<StatefulWidget> createState() => _TextFontButtonState();
}

class _TextFontButtonState extends State<TextFontButton>
    with _Picker<TextFontButton> {
  late String? _font;

  @override
  void initState() {
    super.initState();
    _font = widget.font;
    if (_font?.isNotEmpty != true) _font = textElementFonts.first;
  }

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => togglePicker(context),
        child: Text(_font!, style: GoogleFonts.getFont(_font!)),
      );

  @override
  Widget menuContent(BuildContext context) => SizedBox(
        width: 160,
        height: 200,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: textElementFonts
              .map((font) => GestureDetector(
                    onTap: () => _selectFont(font),
                    child: Text(
                      font,
                      style: GoogleFonts.getFont(font),
                    ),
                  ))
              .toList(),
        ),
      );

  void _selectFont(String font) {
    dismissPicker();
    setState(() {
      _font = font;
    });
    widget.onFontSelected(font);
  }
}

class TextSizeButton extends StatefulWidget {

  const TextSizeButton({
    required this.onSizeSelected, super.key,
    this.textStyle,
  });
  final void Function(int) onSizeSelected;
  final TextStyle? textStyle;

  @override
  State<StatefulWidget> createState() => _TextSizeButtonState();
}

class _TextSizeButtonState extends State<TextSizeButton>
    with _Picker<TextSizeButton> {
  @override
  Widget build(BuildContext context) => IconButton(
        visualDensity: menuButtonVisualDensity,
        icon: const Icon(Icons.format_size),
        onPressed: () => togglePicker(context),
      );

  @override
  Widget menuContent(BuildContext context) => Padding(
        padding: const EdgeInsets.all(1),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.textStyle?.backgroundColor,
            borderRadius: BorderRadius.circular(roundedCornerRadius - 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [11, 14, 18, 24, 32, 42, 54, 68]
                .map(_sizeSelector)
                .toList(),
          ),
        ),
      );

  Widget _sizeSelector(int size) {
    return GestureDetector(
      onTap: () => _selectSize(size),
      child: Padding(
        padding: EdgeInsets.all((72 - size) / 8),
        child: Text(
          'T',
          style: widget.textStyle?.copyWith(fontSize: size.toDouble()) ??
              TextStyle(
                fontSize: size.toDouble(),
              ),
        ),
      ),
    );
  }

  void _selectSize(int size) {
    dismissPicker();
    widget.onSizeSelected(size);
  }
}

class TextAlignmentButton extends StatefulWidget {

  const TextAlignmentButton(
    this._align, {
    required this.onAlign, super.key,
  });
  final TextAlign _align;
  final void Function(TextAlign align) onAlign;

  @override
  State<StatefulWidget> createState() => _TextAlignmentButtonState();
}

class _TextAlignmentButtonState extends State<TextAlignmentButton> {
  late TextAlign _align;

  @override
  void initState() {
    super.initState();
    _align = widget._align;
  }

  @override
  Widget build(BuildContext context) => IconButton(
        visualDensity: menuButtonVisualDensity,
        icon: Icon(_icon),
        onPressed: _nextAlignment,
      );

  IconData get _icon {
    switch (_align) {
      case TextAlign.right:
      case TextAlign.end:
        return Icons.format_align_right;
      case TextAlign.center:
        return Icons.format_align_center;
      case TextAlign.justify:
        return Icons.format_align_justify;
      case TextAlign.left:
      case TextAlign.start:
        return Icons.format_align_left;
    }
  }

  void _nextAlignment() {
    setState(() {
      switch (_align) {
        case TextAlign.right:
        case TextAlign.end:
          _align = TextAlign.justify;
        case TextAlign.center:
          _align = TextAlign.right;
        case TextAlign.justify:
          _align = TextAlign.left;
        case TextAlign.left:
        case TextAlign.start:
          _align = TextAlign.center;
      }
    });
    widget.onAlign(_align);
  }
}

class ThemePrimaryColorButton extends StatefulWidget {

  const ThemePrimaryColorButton({
    required this.onColor, super.key,
    this.initialColor = Colors.black,
    this.pickerAlignment = PickerAlignment.leftBelow,
  });
  final Color initialColor;
  final void Function(Color color) onColor;
  final PickerAlignment pickerAlignment;

  @override
  State<StatefulWidget> createState() => _ThemePrimaryColorButtonState();
}

class _ThemePrimaryColorButtonState extends State<ThemePrimaryColorButton>
    with _Picker<ThemePrimaryColorButton> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
    alignment = widget.pickerAlignment;
  }

  @override
  Widget build(BuildContext context) => FilledButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => _color)),
        onPressed: () => togglePicker(context),
        child: Text('#'
            '${_color.red.toRadixString(16).toUpperCase().padLeft(2, '0')}'
            '${_color.green.toRadixString(16).toUpperCase().padLeft(2, '0')}'
            '${_color.blue.toRadixString(16).toUpperCase().padLeft(2, '0')}'),
      );

  @override
  Widget menuContent(BuildContext context) => _ColorPicker(
        selectedColor: _color,
        minValue: 0.4,
        minSaturation: 0.3,
        onColorPicked: (color) {
          dismissPicker();
          setState(() => _color = color);
          widget.onColor(_color);
        },
      );
}

class _ColorPicker extends StatelessWidget {

  const _ColorPicker({
    required this.onColorPicked, this.selectedColor,
    this.minValue = 0,
    this.maxValue = 1,
    this.minSaturation = 0,
    this.maxSaturation = 1,
  })  : assert(minValue >= 0),
        assert(minValue <= maxValue),
        assert(maxValue <= 1),
        assert(minSaturation >= 0),
        assert(minSaturation <= maxSaturation),
        assert(maxSaturation <= 1);
  final Color? selectedColor;
  final double minValue;
  final double maxValue;
  final double minSaturation;
  final double maxSaturation;
  final void Function(Color) onColorPicked;

  @override
  Widget build(BuildContext context) {
    const columns = 12;
    const rows = 8;
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
      children: List.generate(
        rows,
        (row) => TableRow(
          children: List.generate(
            columns,
            (column) => _colorBox(
                context,
                HSVColor.fromAHSV(
                        1,
                        360 / columns * column,
                        minSaturation +
                            (maxSaturation - minSaturation) / rows * row,
                        minValue + (maxValue - minValue) / rows * row)
                    .toColor()),
          ),
        ),
      ),
    );
  }

  Widget _colorBox(BuildContext context, Color color) => GestureDetector(
        onTap: () => onColorPicked(color),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: color.opacity == 0
                ? _TransparentColorBoxDecoration(
                    color: Theme.of(context).dividerColor)
                : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    color: color,
                  ),
            width: 20,
            height: 20,
            child: color == selectedColor
                ? Center(
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: color.opacity > 0 &&
                              color.value < Colors.grey.shade500.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : null,
          ),
        ),
      );
}

class _TransparentColorBoxDecoration extends Decoration {

  const _TransparentColorBoxDecoration({this.color = Colors.black});
  final Color color;

  @override
  bool get isComplex => false;

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) =>
      _TransparentColorBoxPainter(color);
}

class _TransparentColorBoxPainter extends BoxPainter {

  _TransparentColorBoxPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final clipRadius = (rect.width - 2) / 2;
    final rectCenter =
        Offset(rect.left + rect.width / 2, rect.top + rect.height / 2);
    final clip = Path()
      ..addOval(Rect.fromCircle(center: rectCenter, radius: clipRadius));
    canvas..save()
    ..clipPath(clip)
    ..drawLine(rect.topLeft, rect.bottomRight, paint)
    ..drawLine(rect.topRight, rect.bottomLeft, paint)
    ..restore()
    ..drawCircle(rectCenter, clipRadius, paint);
  }
}

class ToggleIconButton extends StatefulWidget {

  const ToggleIconButton(
      {super.key,
      required this.icon,
      this.uncheckedIcon,
      this.onToggle,
      this.initiallyChecked = false,
      this.tooltip});
  final IconData icon;
  final IconData? uncheckedIcon;
  final String? tooltip;
  final void Function(bool value)? onToggle;
  final bool initiallyChecked;

  @override
  State<StatefulWidget> createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initiallyChecked;
  }

  @override
  Widget build(BuildContext context) => IconButton(
        visualDensity: menuButtonVisualDensity,
        icon: widget.uncheckedIcon != null
            ? Icon(
                _checked ? widget.icon : widget.uncheckedIcon,
              )
            : Icon(
                widget.icon,
                color: _checked
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
        tooltip: widget.tooltip,
        onPressed: () {
          widget.onToggle?.call(!_checked);
          setState(() => _checked = !_checked);
        },
      );
}

enum PickerAlignment { rightBelow, rightAbove, leftBelow, leftAbove }

mixin _Picker<T extends StatefulWidget> on State<T> {
  final roundedCornerRadius = 4.0;
  PickerAlignment alignment = PickerAlignment.leftBelow;
  OverlayEntry? _overlay;
  bool _overlayRemoved = false;
  bool _pickerShown = false;

  @override
  void initState() {
    super.initState();
    _pickerShown = false;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  Widget menuContent(BuildContext context);

  void togglePicker(BuildContext context) {
    if (_pickerShown) {
      dismissPicker();
      return;
    }

    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    Positioned overlay;
    switch (alignment) {
      case PickerAlignment.leftBelow:
        overlay = Positioned(
          left: offset.dx,
          top: offset.dy + renderBox.size.height + 4,
          child: _menu(context),
        );
      case PickerAlignment.leftAbove:
        overlay = Positioned(
          left: offset.dx,
          bottom: screenSize.height - offset.dy + 4,
          child: _menu(context),
        );
      case PickerAlignment.rightBelow:
        overlay = Positioned(
          right: screenSize.width - offset.dx - renderBox.size.width,
          top: offset.dy + renderBox.size.height + 4,
          child: _menu(context),
        );
      case PickerAlignment.rightAbove:
        overlay = Positioned(
          right: screenSize.width - offset.dx - renderBox.size.width,
          bottom: screenSize.height - offset.dy + 4,
          child: _menu(context),
        );
    }

    _removeOverlay();
    _overlayRemoved = false;
    _overlay = OverlayEntry(builder: (context) => overlay);
    Overlay.of(context).insert(_overlay!);
    setState(() => _pickerShown = true);
  }

  void dismissPicker() {
    setState(() {
      _pickerShown = false;
    });
    _removeOverlay();
  }

  void _removeOverlay() {
    if (!_overlayRemoved) {
      if (_overlay != null) {
        _overlay!.remove();
        _overlay = null;
      }
      _overlayRemoved = true;
    }
  }

  Material _menu(BuildContext context) {
    return Material(
      color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedCornerRadius)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            menuContent(context),
            TextButton(
              onPressed: _removeOverlay,
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            )
          ],
        ),
      ),
    );
  }
}
