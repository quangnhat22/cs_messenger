case "$(uname -sr)" in

   Darwin*)
     #!/bin/zsh
     ;;

   Linux*Microsoft*)
     echo 'WSL'  # Windows Subsystem for Linux
     ;;

   Linux*)
     #!/bin/bash
     ;;

   CYGWIN*|MINGW*|MINGW32*|MSYS*)
     echo 'MS Windows'
     ;;

   *)
     echo 'Other OS'
     ;;
esac

echo "Installing fvm..."
dart pub global activate fvm
echo "Installing Melos..."
dart pub global activate melos
echo "Installing FlutterGen..."
dart pub global activate flutter_gen
# echo "Installing Lefthook..."
# dart pub global activate lefthook
echo "Installing Dart code metrics..."
dart pub global activate dart_code_metrics