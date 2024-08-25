from uptime_kuma_api import UptimeKumaApi, MonitorType

# Login to Uptime Kuma API
api = UptimeKumaApi("https://uptimekuma.zorab.im")
api.login("daniel", "logMEin777")

# result = api.add_monitor(type=MonitorType.HTTP, name="Google", url="https://google.com")
result = api.get_monitor(3)
print(result)

# Disconnect from API
api.disconnect()
