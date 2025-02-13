# flutter_task_app_test

![Main screen](static/main_screen.png)

## VS Code plugins
- [Data class generator](https://marketplace.visualstudio.com/items?itemName=ricardo-emerson.dart-data-class-tools)
- [Pub spec assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)

## Development
### cleanup 
```sh
sudo chmod -R 777 ~/dev/flutter-examples/flutter_tasks_app_bloc/build/ios

flutter clean
flutter pub get
cd ios
pod cache clean --all
rm -rf Pods
rm -rf ~/Library/Caches/CocoaPods
pod install --verbose
cd ..
cd android
./gradlew clean
cd ..
flutter pub get
flutter run
```

## Design
### Tasktile Layout

![Task tile layout](static/task_tile_layout.png)


## Dependencies
### intl
```dart
Text(DateFormat().add_yMEd().format(DateTime.now()))
Text(DateFormat().add_yMEd().add_Hms().format(DateTime.now()))
Text(DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now()))
```