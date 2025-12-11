#

autowap (1.0.7) bookworm; urgency=low

- Reworked creation of Access Point.
- Hide ap_channel configuration item as no longer used.

-- Mark Thornber <mark.thornber@gmail.com> Thu, 11 Dec 2025 09:56:27 +0000

- Changed package filename to remove PiOS release number and add distribution name.

-- Mark Thornber <mark.thornber@gmail.com> Sat 22 Nov 2025 10:45:00 +0000

autowap (1.0.5) bookworm; urgency=low

- Update default WAP SSID to `MERGPi`
- Improved Markdown formating

-- Mark Thornber <mark.thornber@gmail.com> Tue 22 Jul 2025 13:37:00 +0100

autowap (1.0.4) bookworm; urgency=low

- Update document files

-- Mark Thornber <mark.thornber@gmail.com> Thu, 27 Feb 2025 14:15:16 +0000

autowap (1.0.3) bookworm; urgency=low

- Pass package name to pkg/Makefile as an EV derived from CMake PROJECT_NAME.

-- Mark Thornber <mark.thornber@gmail.com> Sun, 23 Feb 2025 14:14:54 +0000

autowap (1.0.2) bookworm; urgency=low

- Added functionality to light the Red LED if the WAP has been created.
- Added the attribute definition for GPIO Pin number of the Red LED for use by
 the maintence web app. This attribute is Display Only.

-- Mark Thornber <mark.thornber@gmail.com> Sat, 28 Dec 2024 11:08:00 +0100

autowap (1.0.1) bookworm; urgency=low

- Update package definition to define 'changelog' as CHANGES.md
- Added attribute definition for maintenance web app

-- Mark Thornber <mark.thornber@gmail.com> Thu, 10 Oct 2024 13:52:00 +0100

autowap (1.0.0) bookworm; urgency=low

- Reworking of AutoHotspot-Installer from RaspberryConnect that uses Network
- Manager to create and destroy a Wireless Access Point (WAP).  Network
- Manager is a replacement for dhcpd that was introduced by the bookworm release.

-- Mark Thornber <mark.thornber@gmail.com> Tue, 8 Oct 2024 12:55:00 +0100
