This is a reworking for Raspbian release 'bookworm' of part of the AutoHotspot functionality
that derives from RaspberryConnect code AutoHotspot-Installer on GitHub.

#  AutoWAP

The functionality is focussed on providing a Wireless Access Point (WAP)
if, when the network is online, there is no connection to a local
network.  This happens at boot time or when the network manager is
restarted.

There is a configuration file that defines the SSID, Password, and
Network, of the WAP.  This file can be updated via a web browser using a
companion package canpi-web-app-ssr running on the Raspberry Pi.

# Installation

Use apt to install the package.  There is an apt repository available.
To get access to this repository ...

Mark Thornber
merg.org.uk

