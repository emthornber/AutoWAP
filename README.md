# AutoWAP

This is a reworking for Raspbian release 'bookworm' of part of the AutoHotspot
functionality that derives from RaspberryConnect code AutoHotspot-Installer on
GitHub.

The functionality is focussed on providing a Wireless Access Point (WAP)
if, when the network comes online, there is no connection to a local
network.  This happens at boot time.

There is a configuration file that defines the SSID, Password, and
Network, of the WAP.  This file can be updated via a web browser using a
companion package `canpi-web-app-ssr` running on the Raspberry Pi.

Building and installation instructions are in [INSTALL.md](INSTALL.md)
