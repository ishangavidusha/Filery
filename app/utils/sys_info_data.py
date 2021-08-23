import psutil

INCLUDED_PARTITIONS = set(['/'])

def sysInfo():
    mem_data = psutil.virtual_memory()
    mem = {
        "total": mem_data.total,
        "available": mem_data.available,
        "free": mem_data.free,
        "cached": mem_data.cached,
        "buffers": mem_data.buffers,
    }
    disk_partitions = {}
    partitions = psutil.disk_partitions()
    for p in partitions:
        if p.mountpoint in INCLUDED_PARTITIONS:
            usage = psutil.disk_usage(p.mountpoint)
            disk_partitions[p.mountpoint] = {
                "device": p.device,
                "fstype": p.fstype,
                "total": usage.total,
                "used": usage.used
            }

    cpu_stats_data = psutil.cpu_stats()
    cpu_stats = {
        "ctx_switches": cpu_stats_data.ctx_switches,
        "interrupts": cpu_stats_data.interrupts,
        "soft_interrupts": cpu_stats_data.soft_interrupts,
        "syscalls": cpu_stats_data.syscalls
    }

    disk_io_counters_data = psutil.disk_io_counters()
    disk_io_counters = {
        "read_count": disk_io_counters_data.read_count,
        "write_count": disk_io_counters_data.write_count,
        "read_bytes": disk_io_counters_data.read_bytes,
        "write_bytes": disk_io_counters_data.write_bytes,
        "read_time": disk_io_counters_data.read_time,
        "write_time": disk_io_counters_data.write_time,
        "read_merged_count": disk_io_counters_data.read_merged_count,
        "write_merged_count": disk_io_counters_data.write_merged_count,
        "busy_time": disk_io_counters_data.busy_time,
    }

    net_io_counters_data = psutil.net_io_counters()
    net_io_counters = {
        "bytes_sent": net_io_counters_data.bytes_sent,
        "bytes_recv": net_io_counters_data.bytes_recv,
        "packets_sent": net_io_counters_data.packets_sent,
        "packets_recv": net_io_counters_data.packets_recv,
        "errin": net_io_counters_data.errin,
        "errout": net_io_counters_data.errout,
        "dropin": net_io_counters_data.dropin,
        "dropout": net_io_counters_data.dropout
    }

    swap_memory_data = psutil.swap_memory()
    swap_memory = {
        "total": swap_memory_data.total,
        "used": swap_memory_data.used,
        "free": swap_memory_data.free,
        "percent": swap_memory_data.percent,
        "sin": swap_memory_data.sin,
        "sout": swap_memory_data.sout
    }

    system = {
        'boot_time': psutil.boot_time(),
        'cpu_count': psutil.cpu_count(),
        'cpu_stats': cpu_stats,
        'cpu_load': psutil.cpu_percent(interval=1),
        'disk_io_counters': disk_io_counters,
        'disk_usage': disk_partitions,
        'net_io_counters': net_io_counters,
        'swap_memory': swap_memory,
        'virtual_memory': mem
    }
    return system