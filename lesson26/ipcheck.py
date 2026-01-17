import subprocess
f_res = "ping_results.txt"

def ping_host(host):
    command = ['/usr/bin/ping', '-c', '4', '-W', '1', host]
    result = subprocess.run(command, capture_output=True, text=True, check=False)
    if result.returncode == 0:
        return f"[{host}] Доступен\n{result.stdout}"
    else:
        return f"[{host}] Недоступен (код {result.returncode})\n{result.stderr}"

def check_hosts(ip_list):
    with open(f_res, "w", encoding="utf-8") as file:
        for ip in ip_list:
            result = ping_host(ip)
            print(result)
            file.write(result + "\n")

ip_addresses = ["8.8.8.8", "localhost", "192.0.2.1", "256.256.256.256"]

check_hosts(ip_addresses)
