import psutil

INCLUDED_PARTITIONS = set(['/'])

def sysInfo():
    try:
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
                disk_partitions["root"] = {
                    "device": p.device,
                    "fstype": p.fstype,
                    "mountpoint": p.mountpoint,
                    "total": usage.total,
                    "used": usage.used
                }

        cpu_stats_data = psutil.cpu_stats()
        cpu_stats = {
            "ctxSwitches": cpu_stats_data.ctx_switches,
            "interrupts": cpu_stats_data.interrupts,
            "softInterrupts": cpu_stats_data.soft_interrupts,
            "syscalls": cpu_stats_data.syscalls
        }

        disk_io_counters_data = psutil.disk_io_counters()
        disk_io_counters = {
            "readCount": disk_io_counters_data.read_count,
            "writeCount": disk_io_counters_data.write_count,
            "readBytes": disk_io_counters_data.read_bytes,
            "writeBytes": disk_io_counters_data.write_bytes,
            "readTime": disk_io_counters_data.read_time,
            "writeTime": disk_io_counters_data.write_time,
            "readMergedCount": disk_io_counters_data.read_merged_count,
            "writeMergedCount": disk_io_counters_data.write_merged_count,
            "busyTime": disk_io_counters_data.busy_time,
        }

        net_io_counters_data = psutil.net_io_counters()
        net_io_counters = {
            "bytesSent": net_io_counters_data.bytes_sent,
            "bytesRecv": net_io_counters_data.bytes_recv,
            "packetsSent": net_io_counters_data.packets_sent,
            "packetsRecv": net_io_counters_data.packets_recv,
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
            'bootTime': psutil.boot_time(),
            'cpuCount': psutil.cpu_count(),
            'cpuStats': cpu_stats,
            'cpuLoad': psutil.cpu_percent(interval=1),
            'diskIoCounters': disk_io_counters,
            'diskUsage': disk_partitions,
            'netIoCounters': net_io_counters,
            'swapMemory': swap_memory,
            'virtualMemory': mem
        }
        return system
    except:
        system = {
            'bootTime': None,
            'cpuCount': None,
            'cpuStats': None,
            'cpuLoad': None,
            'diskIoCounters': None,
            'diskUsage': None,
            'netIoCounters': None,
            'swapMemory': None,
            'virtualMemory': None
        }
        return system