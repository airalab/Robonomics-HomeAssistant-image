# Robonomics-HomeAssistant-image

This repository contains Robonomics Home Assistant image based on Raspberry Pi OS (previously called Raspbian).

Package versions:

- homeassistant = 2023.1.7
- robonomics-interface = 1.6.0
- IPFS = 0.17.0
- Zigbee2Mqtt = 1.28.4
- Robonomics Integration = 1.5.0
- yggdrasil = 0.4.7

## Installation 

After downloading the image you can flash it with [balena](https://www.balena.io/etcher/) or [Raspberry Pi Imager](https://www.raspberrypi.com/software/).

After flasing, open the SD card's storage and navigate inside the `boot` folder of the card. 
Inside this folder you need to create a `wpa_supplicant.conf` file, where you will provide your network credentials.
Parse to the file next:
```shell
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert 2 letter ISO 3166-1 country code here>

network={
        scan_ssid=1
        ssid="<Name of your wireless LAN>"
        psk="<Password for your wireless LAN>"
        proto=RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP
        auth_alg=OPEN
}
```
And change fields `ssid` and `psk` to your Wi-Fi name and password. Also write your country to the `country` field. Coutry code you can find [here](https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes). 

> After your Raspberry Pi is connected to power, make sure to wait a few (up to 5) minutes for it to boot up and register on the network. 

Next connect to it via ssh.
Default User is `ubuntu` and password is `ubuntu`. You will ask to change password.