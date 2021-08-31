import psutil

INCLUDED_PARTITIONS = set(['/'])

BYTES_SENT = 0.0
BYTES_RECV = 0.0

def getNetBandwith(inf = "eth0"):
    global BYTES_SENT
    global BYTES_RECV
    net_stat = psutil.net_io_counters(pernic=True, nowrap=True)[inf]
    sent = net_stat.bytes_sent
    recv = net_stat.bytes_recv

    net_in = round((recv - BYTES_RECV) / 1024 / 1024, 2)
    net_out = round((sent - BYTES_SENT) / 1024 / 1024, 2)

    result = {
        "netIn": net_in,
        "netOut": net_out
    }

    if BYTES_RECV == 0.0 and BYTES_SENT == 0.0:
        result = {
        "netIn": 0.0,
        "netOut": 0.0
    }

    BYTES_SENT = sent
    BYTES_RECV = recv
    
    return result

def sysInfo():
    try:
        mem_data = psutil.virtual_memory()
        mem = {
            "total": mem_data.total,
            "used": mem_data.used,
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
            'cpuLoad': psutil.cpu_percent(),
            'diskUsage': disk_partitions,
            'netIoCounters': getNetBandwith(),
            'swapMemory': swap_memory,
            'virtualMemory': mem
        }
        return system
    except:
        system = {
            'bootTime': None,
            'cpuCount': None,
            'cpuLoad': None,
            'diskUsage': None,
            'netIoCounters': None,
            'swapMemory': None,
            'virtualMemory': None 
        }
        return system