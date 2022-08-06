disable_splash=1
boot_delay=0

gpu_mem=16
gpu_mem_256=64

ifdef(`xHDMI', `include(xHDMI)',
`hdmi_drive=1
hdmi_group=2
hdmi_mode=1
hdmi_mode=87
hdmi_cvt 800 480 60 6 0 0 0')


[all]
enable_uart=1
ifelse(xARCH, `aarch64',
`arm_64bit=1
enable_gic=1')
