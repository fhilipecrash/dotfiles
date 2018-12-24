#!/bin/python
# -*- coding: utf-8 -*-

import requests

CITY = "3445831"
API_KEY = "642a76e68929c32f7bdee0ed86ed30a3"
UNITS = "Metric"
UNIT_KEY = "C"

REQ = requests.get("http://api.openweathermap.org/data/2.5/weather?id={}&appid={}&units={}".format(CITY, API_KEY, UNITS))
try:
    # HTTP CODE = OK
    if REQ.status_code == 200:
        CURRENT = REQ.json()["weather"][0]["description"].capitalize()
        TEMP = int(float(REQ.json()["main"]["temp"]))
        print("{}, {} °{}".format(CURRENT, TEMP, UNIT_KEY))
    else:
        print("Error: BAD HTTP STATUS CODE " + str(REQ.status_code))
except (ValueError, IOError):
    print("Error: Unable print the data")
