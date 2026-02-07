# AutoWAP

This is an update for Raspbian release 'trixie' of part of the AutoHotspot
functionality that derives from RaspberryConnect code AutoHotspot-Installer on
GitHub.  This is V2 of AutoWAP that uses libgpiod library.  The prior version V1
uses pigpiod which is not supported by trixie.

The functionality is focussed on providing a Wireless Access Point (WAP)
if, when the network comes online, there is no connection to a local
network.  This happens at boot time.

There is a configuration file that defines the SSID, Password, and
Network, of the WAP.  This file can be updated via a web browser using a
companion package `canpi-web-app-ssr` running on the Raspberry Pi.

Building and installation instructions are in [INSTALL.md](INSTALL.md)
