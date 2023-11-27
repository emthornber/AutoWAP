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

Use dpkg to install the package which requires dnsmasq, hostapd, and wpasupplicant
package to be installed on the system.  This can be done using apt.

Mark Thornber
merg.org.uk

