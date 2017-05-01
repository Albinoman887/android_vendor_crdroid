# Product version should match Android version
PRODUCT_VERSION_MAJOR = 7
PRODUCT_VERSION_MINOR = 1.2

# Increase CR Version with each major release.
CR_VERSION := 3.0

LINEAGE_VERSION := crDroidAndroid-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(CM_BUILD)-v$(CR_VERSION)
LINEAGE_DISPLAY_VERSION := crDroidAndroid-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-v$(CR_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.crdroid.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LINEAGE_VERSION) \
    ro.crdroid.display.version=$(LINEAGE_VERSION) \
    ro.storage_manager.enabled=1 \
    ro.substratum.verified=true \
    ro.opa.eligible_device=true \
    ro.com.google.ime.theme_id=5

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Custom packages
PRODUCT_PACKAGES += \
    OmniSwitch \
    org.dirtyunicorns.utils \
    ThemeInterfacer \
    OmniStyle \
    OmniJaws \
    crDroidWallpapers \
    crDroidFileManager \
    crDroidMusic

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Dex optimization not required
WITH_DEXPREOPT := false

ifeq ($(CRDROID_OPTIMIZATIONS),true)
    # DragonTC info
    DRAGONTC_VERSION := 5.0
    DISABLE_DTC_OPTS := false

    TARGET_GCC_VERSION_EXP := 6.3
    TARGET_LINARO_KERNEL := $(TARGET_GCC_VERSION_KERNEL)

    # Find host os
    UNAME := $(shell uname -s)
    HOST_OS := linux

    # Add extra libs for the compilers to use
    export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
    export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)
else
    DRAGONTC_VERSION := 3.8
    DISABLE_DTC_OPTS := true
endif

