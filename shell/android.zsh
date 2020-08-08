#!/bin/zsh

export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_TOOLS=${ANDROID_HOME}/tools

export PATH=${PATH}:${ANDROID_HOME}
export PATH=${PATH}:${ANDROID_HOME}/emulator
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/tools/bin
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
