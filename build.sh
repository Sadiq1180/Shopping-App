#!/bin/sh

echo "command: $1"

# flutter clean
# flutter pub get

case ${1} in
    'build_runner') echo "running build_runner"
        dart run build_runner build --delete-conflicting-outputs
    ;;
    'apk_dev') echo "Build android apk dev"
        flutter build apk --debug --shrink --obfuscate --split-debug-info=./build/obfuscated
    ;;
    'apk') echo "Build android apk release"
        flutter build apk --release --shrink --obfuscate --split-debug-info=./build/obfuscated
    ;;
    'bundle_dev') echo "Build android bundle dev"
        flutter build appbundle --debug --shrink --obfuscate --split-debug-info=./build/obfuscated
    ;;
    'bundle') echo "Build android bundle prod"
        flutter build appbundle --release --shrink --obfuscate --split-debug-info=./build/obfuscated
    ;;
    'ios') echo "Build ios ipa prod"
        flutter build ios --release
    ;;
esac