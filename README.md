This is a reworking for Raspbian release 'bookworm' of part of the AutoHotspot functionality
that derives from RaspberryConnect code AutoHotspot-Installer on GitHub.

#  AutoWAP

The functionality is focussed on providing a Wireless Access Point (WAP)
if, when the network comes online, there is no connection to a local
network.  This happens at boot time.

There is a configuration file that defines the SSID, Password, and
Network, of the WAP.  This file can be updated via a web browser using a
companion package canpi-web-app-ssr running on the Raspberry Pi.

# Installation

Use dpkg to install the package ...

`dpkg --install autowap-0.2.0-linux-5.1-all.deb`

... and uninstall 

`dpkg --purge autowap`

Mark Thornber
M3748
merg.org.uk

