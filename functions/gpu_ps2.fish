function gpu_ps2
flatpak run --env=__NV_PRIME_RENDER_OFFLOAD=1 --env=__GLX_VENDOR_LIBRARY_NAME=nvidia net.pcsx2.PCSX2 &
end
