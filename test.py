import psutil
import time


BYTES_READ = 0.0
BYTES_WRITE = 0.0

def net_usage(inf = "eth0"):   #change the inf variable according to the interface
    disk_stat = psutil.disk_io_counters(nowrap=True)
    print(disk_stat)
    # net_in_1 = disk_stat.bytes_recv
    # net_out_1 = disk_stat.bytes_sent
    time.sleep(1)
    # disk_stat = psutil.net_io_counters(pernic=True, nowrap=True)[inf]
    # net_in_2 = disk_stat.bytes_recv
    # net_out_2 = disk_stat.bytes_sent

    # net_in = round((net_in_2 - net_in_1) / 1024 / 1024, 2)
    # net_out = round((net_out_2 - net_out_1) / 1024 / 1024, 2)

    # print(f"Current net-usage: IN: {net_in} MB/s, OUT: {net_out} MB/s")


while True:
    net_usage()