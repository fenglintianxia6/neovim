#!/bin/bash

# 安装 Dart LSP
echo "Installing Dart LSP..."

# 检查是否已安装 Dart
if ! command -v dart &> /dev/null; then
    echo "Dart is not installed. Please install Dart first."
    echo "Visit: https://dart.dev/get-dart"
    exit 1
fi

# 安装 Dart LSP
dart pub global activate dart_language_server

echo "Dart LSP installed successfully!"
echo "Make sure to add the Dart SDK bin directory to your PATH:"
echo "export PATH=\"\$PATH:\$HOME/.pub-cache/bin\"" 