LOCAL_PATH := $(call my-dir)

WEBP_CFLAGS := -Wall -DANDROID -DHAVE_MALLOC_H -DHAVE_PTHREAD -DWEBP_USE_THREAD

ifeq ($(APP_OPTIM),release)
  WEBP_CFLAGS += -finline-functions -ffast-math \
                 -ffunction-sections -fdata-sections
  ifeq ($(findstring clang,$(NDK_TOOLCHAIN_VERSION)),)
    WEBP_CFLAGS += -frename-registers -s
  endif
endif

WEBP_CFLAGS += -DWEBP_HAVE_PNG -DWEBP_HAVE_JPEG


include $(CLEAR_VARS)

ifneq ($(findstring armeabi-v7a, $(TARGET_ARCH_ABI)),)
  # Setting LOCAL_ARM_NEON will enable -mfpu=neon which may cause illegal
  # instructions to be generated for armv7a code. Instead target the neon code
  # specifically.
  NEON := c.neon
else
  NEON := c
endif

LOCAL_SRC_FILES := \
    src/dec/alpha.c \
    src/dec/buffer.c \
    src/dec/frame.c \
    src/dec/idec.c \
    src/dec/io.c \
    src/dec/quant.c \
    src/dec/tree.c \
    src/dec/vp8.c \
    src/dec/vp8l.c \
    src/dec/webp.c \
    src/dsp/alpha_processing.c \
    src/dsp/alpha_processing_mips_dsp_r2.c \
    src/dsp/alpha_processing_sse2.c \
    src/dsp/cpu.c \
    src/dsp/dec.c \
    src/dsp/dec_clip_tables.c \
    src/dsp/dec_mips32.c \
    src/dsp/dec_mips_dsp_r2.c \
    src/dsp/dec_neon.$(NEON) \
    src/dsp/dec_sse2.c \
    src/dsp/enc.c \
    src/dsp/enc_avx2.c \
    src/dsp/enc_mips32.c \
    src/dsp/enc_mips_dsp_r2.c \
    src/dsp/enc_neon.$(NEON) \
    src/dsp/enc_sse2.c \
    src/dsp/filters_mips_dsp_r2.c \
    src/dsp/lossless.c \
    src/dsp/lossless_mips32.c \
    src/dsp/lossless_mips_dsp_r2.c \
    src/dsp/lossless_neon.$(NEON) \
    src/dsp/lossless_sse2.c \
    src/dsp/upsampling.c \
    src/dsp/upsampling_mips_dsp_r2.c \
    src/dsp/upsampling_neon.$(NEON) \
    src/dsp/upsampling_sse2.c \
    src/dsp/yuv.c \
    src/dsp/yuv_mips32.c \
    src/dsp/yuv_mips_dsp_r2.c \
    src/dsp/yuv_sse2.c \
    src/enc/alpha.c \
    src/enc/analysis.c \
    src/enc/backward_references.c \
    src/enc/config.c \
    src/enc/cost.c \
    src/enc/filter.c \
    src/enc/frame.c \
    src/enc/histogram.c \
    src/enc/iterator.c \
    src/enc/near_lossless.c \
    src/enc/picture.c \
    src/enc/picture_csp.c \
    src/enc/picture_psnr.c \
    src/enc/picture_rescale.c \
    src/enc/picture_tools.c \
    src/enc/quant.c \
    src/enc/syntax.c \
    src/enc/token.c \
    src/enc/tree.c \
    src/enc/vp8l.c \
    src/enc/webpenc.c \
    src/utils/bit_reader.c \
    src/utils/bit_writer.c \
    src/utils/color_cache.c \
    src/utils/filters.c \
    src/utils/huffman.c \
    src/utils/huffman_encode.c \
    src/utils/quant_levels.c \
    src/utils/quant_levels_dec.c \
    src/utils/random.c \
    src/utils/rescaler.c \
    src/utils/thread.c \
    src/utils/utils.c \
    libjpeg/jaricom.c \
    libjpeg/jcapimin.c \
    libjpeg/jcapistd.c \
    libjpeg/jcarith.c \
    libjpeg/jccoefct.c \
    libjpeg/jccolor.c \
    libjpeg/jcdctmgr.c \
    libjpeg/jchuff.c \
    libjpeg/jcinit.c \
    libjpeg/jcmainct.c \
    libjpeg/jcmarker.c \
    libjpeg/jcmaster.c \
    libjpeg/jcomapi.c \
    libjpeg/jcparam.c \
    libjpeg/jcprepct.c \
    libjpeg/jcsample.c \
    libjpeg/jctrans.c \
    libjpeg/jdapimin.c \
    libjpeg/jdapistd.c \
    libjpeg/jdarith.c \
    libjpeg/jdatadst.c \
    libjpeg/jdatasrc.c \
    libjpeg/jdcoefct.c \
    libjpeg/jdcolor.c \
    libjpeg/jddctmgr.c \
    libjpeg/jdhuff.c \
    libjpeg/jdinput.c \
    libjpeg/jdmainct.c \
    libjpeg/jdmarker.c \
    libjpeg/jdmaster.c \
    libjpeg/jdmerge.c \
    libjpeg/jdpostct.c \
    libjpeg/jdsample.c \
    libjpeg/jdtrans.c \
    libjpeg/jerror.c \
    libjpeg/jfdctflt.c \
    libjpeg/jfdctfst.c \
    libjpeg/jfdctint.c \
    libjpeg/jidctflt.c \
    libjpeg/jidctfst.c \
    libjpeg/jidctint.c \
    libjpeg/jmemmgr.c \
    libjpeg/jmemnobs.c \
    libjpeg/jquant1.c \
    libjpeg/jquant2.c \
    libjpeg/jutils.c \
    libpng/png.c \
    libpng/pngerror.c \
    libpng/pnggccrd.c \
    libpng/pngget.c \
    libpng/pngmem.c \
    libpng/pngpread.c \
    libpng/pngread.c \
    libpng/pngrio.c \
    libpng/pngrtran.c \
    libpng/pngrutil.c \
    libpng/pngset.c \
    libpng/pngtest.c \
    libpng/pngtrans.c \
    libpng/pngvcrd.c \
    libpng/pngwio.c \
    libpng/pngwrite.c \
    libpng/pngwtran.c \
    libpng/pngwutil.c \
    zlib/adler32.c \
    zlib/compress.c \
    zlib/crc32.c \
    zlib/deflate.c \
    zlib/gzclose.c \
    zlib/gzlib.c \
    zlib/gzread.c \
    zlib/gzwrite.c \
    zlib/infback.c \
    zlib/inffast.c \
    zlib/inflate.c \
    zlib/inftrees.c \
    zlib/trees.c \
    zlib/uncompr.c \
    zlib/zutil.c \

LOCAL_CFLAGS := $(WEBP_CFLAGS)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src

# prefer arm over thumb mode for performance gains
LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := cpufeatures

LOCAL_MODULE := webp

ifeq ($(ENABLE_SHARED),1)
  include $(BUILD_SHARED_LIBRARY)
else
  include $(BUILD_STATIC_LIBRARY)
endif

include $(LOCAL_PATH)/examples/Android.mk

$(call import-module,android/cpufeatures)
