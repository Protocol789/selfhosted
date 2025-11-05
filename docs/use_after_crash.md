# View journal logs from before the crash
sudo journalctl -b -1 --no-pager | tail -1000

# Check what was consuming CPU
sudo tail -100 /var/log/resource-monitor/cpu.log

# Check what was consuming memory
sudo tail -100 /var/log/resource-monitor/memory.log

# Check system stats before crash
sudo tail -50 /var/log/resource-monitor/system.log