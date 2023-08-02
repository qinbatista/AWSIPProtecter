# -*- coding: utf-8 -*-
import requests
import time
from socket import *
from datetime import datetime

class LightSail:
    def __init__(self):
        self.__target_server = "timov4.qinyupeng.com"
        self._can_connect = 0
    def _update_this_server(self):
        udpClient = socket(AF_INET, SOCK_DGRAM)
        while True:
            try:
                this_docker_ipv4 = self.__get_current_ipv4()
                this_docker_ipv6 = self.__get_current_ipv6()
                self._can_connect = 0
                udpClient.sendto((f"{gethostbyname(self.__target_server)},{str(self._can_connect)}").encode(encoding="utf-8"), (self.__target_server, 7171))
                print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}][update_this_server]Updated reachable={this_docker_ipv4},{self._can_connect}")
                time.sleep(10)
            except Exception as e:
                time.sleep(60)
                print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}][update_this_server]Error: {str(e)}")

    def __get_current_ipv6(self):
        try:
            return requests.get("https://api6.ipify.org", timeout=5).text
        except requests.exceptions.ConnectionError as ex:
            return None

    def __get_current_ipv4(self):
        try:
            return requests.get("https://checkip.amazonaws.com").text.strip()
        except Exception as e:
            self.__log("[get_host_ip ] "+str(e))
            return ""

if __name__ == "__main__":
    ls = LightSail()
    ls._update_this_server()
