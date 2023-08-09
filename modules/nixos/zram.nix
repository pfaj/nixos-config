{ ... }:
{
    zramSwap.enable = true;
    zramSwap.memoryPercent = 100;
    boot.kernel.sysctl."vm.swappiness" = 180; # zram is relatively cheap, prefer swap
    boot.kernel.sysctl."vm.page-cluster" = 0; # zram is in memory, no need to readahead
    boot.kernel.sysctl."vm.dirty_background_bytes" = 128 * 1024 * 1024; # Start asynchronously writing at 128 MiB dirty memory
    boot.kernel.sysctl."vm.dirty_ratio" = 50; # Start synchronously writing at 50% dirty memory
    boot.kernel.sysctl."vm.dirty_bytes" = 64 * 1024 * 1024;
    boot.kernel.sysctl."vm.vfs_cache_pressure" = 500;
    systemd.oomd.enable = false; # With 32 GiB of RAM and zram enabled OOM is unlikely
}
