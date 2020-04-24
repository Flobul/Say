ARCHS = arm64 armv7 armv7s armv6
TARGET = iphone:clang:latest:9.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = say
say_FILES = say.m
say_PRIVATE_FRAMEWORKS = AVFoundation VoiceServices
say_CFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/tool.mk
