<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# index_cut
The widget represents a screen like an index cut

## Demo
<img src="https://github.com/Shoryu-Y/index_cut/assets/44453803/1fd28f30-7c38-4968-b58f-adee359d531a" width="400">

## Usage

```dart
class IndexCutView extends StatefulWidget {
  const IndexCutView({super.key});

  @override
  State<IndexCutView> createState() => _IndexCutViewState();
}

class _IndexCutViewState extends State<IndexCutView> {
  int currentIndex = 0;

  final items = [
    const Text('1', style: TextStyle(fontSize: 18)),
    const Text('2', style: TextStyle(fontSize: 18)),
    const Text('3', style: TextStyle(fontSize: 18)),
    const Text('4', style: TextStyle(fontSize: 18)),
  ];

  @override
  Widget build(BuildContext context) {
    return IndexCut(
      currentIndex: currentIndex,
      icons: items,
      isOneWay: false,
      onChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      child: Center(
        child: items[currentIndex],
      ),
    );
  }
}
```
