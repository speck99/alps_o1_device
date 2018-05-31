
# Inherit from those products. Most specific first.
#$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

# Set target and base project for flavor build
MTK_TARGET_PROJECT := $(subst full_,,$(TARGET_PRODUCT))
MTK_BASE_PROJECT := $(MTK_TARGET_PROJECT)
MTK_PROJECT_FOLDER := $(LOCAL_PATH)
MTK_TARGET_PROJECT_FOLDER := $(LOCAL_PATH)

# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, device/mediateksample/$(MTK_TARGET_PROJECT)/device.mk)

# set locales & aapt config.
include $(LOCAL_PATH)/ProjectConfig.mk
# Vanzo:yucheng on: Wed, 21 Sep 2016 19:48:30 +0800
# added for aosp management to import custom config
project_name:=$(shell echo $(VANZO_INNER_PROJECT_NAME))
-include zprojects/$(project_name)/$(project_name).mk
# End of Vanzo:yucheng
ifneq (,$(filter OP01%, $(OPTR_SPEC_SEG_DEF)))
  ifeq ($(OP01_COMPATIBLE), yes)
    PRODUCT_LOCALES:=zh_CN en_US zh_TW ja_JP en_GB fr_FR
  else
    PRODUCT_LOCALES:=zh_CN en_US zh_TW
  endif
else ifneq (,$(filter OP09%, $(OPTR_SPEC_SEG_DEF)))
  PRODUCT_LOCALES:=zh_CN zh_HK zh_TW en_US pt_BR pt_PT en_GB fr_FR ja_JP
else
  PRODUCT_LOCALES := en_US zh_CN zh_TW es_ES pt_BR ru_RU fr_FR de_DE tr_TR vi_VN ms_MY in_ID th_TH it_IT ar_EG hi_IN bn_IN ur_PK fa_IR pt_PT nl_NL el_GR hu_HU tl_PH ro_RO cs_CZ ko_KR km_KH iw_IL my_MM pl_PL es_US bg_BG hr_HR lv_LV lt_LT sk_SK uk_UA de_AT da_DK fi_FI nb_NO sv_SE en_GB hy_AM zh_HK et_EE ja_JP kk_KZ sr_RS sl_SI ca_ES
endif

# Vanzo:songlixin on: Sat, 31 Jan 2015 16:41:22 +0800
# for locales and aapt customization
ifneq ($(strip $(VANZO_PRODUCT_LOCALES)),)
  PRODUCT_LOCALES := $(VANZO_PRODUCT_LOCALES)
endif
ifneq ($(strip $(VANZO_PRODUCT_AAPT_CONFIG)),)
    PRODUCT_AAPT_CONFIG := $(VANZO_PRODUCT_AAPT_CONFIG)
endif
# End of Vanzo:songlixin

# Set those variables here to overwrite the inherited values.
PRODUCT_MANUFACTURER := alps
PRODUCT_NAME := full_fd3901
PRODUCT_DEVICE := fd3901
PRODUCT_MODEL := fd3901
PRODUCT_POLICY := android.policy_phone
PRODUCT_BRAND := alps

ifeq ($(TARGET_BUILD_VARIANT), eng)
KERNEL_DEFCONFIG ?= fd3901_debug_defconfig
else
KERNEL_DEFCONFIG ?= fd3901_defconfig
endif
PRELOADER_TARGET_PRODUCT ?= fd3901
LK_PROJECT ?= fd3901
TRUSTY_PROJECT ?= fd3901

#A-GO
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
# Reduces GC frequency of foreground apps by 50%
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0
$(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackageGo.mk)
