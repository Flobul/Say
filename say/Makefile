ARCHS = arm64 armv7 armv7s
BINPATH = /usr/bin

include $(THEOS)/makefiles/common.mk

TOOL_NAME += say
say_FILES = say.m
say_PRIVATE_FRAMEWORKS = AVFoundation VoiceServices
say_INSTALL_PATH = $(BINPATH)

include $(THEOS_MAKE_PATH)/tool.mk
