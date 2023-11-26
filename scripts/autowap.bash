#! /bin/bash
################################################################################
#
#       autowap.bash
#   A service to start a Wireless Access Point (WAP) if there is no
#   connection to a local wifi network.  This service is a 'one-shot'
#   that runs after the netork-online target has been achieved.
#
#   25 November, 2023 - E M Thornber
#   Created
#
################################################################################

AWK="/usr/bin/awk"
GREP="/usr/bin/grep"
IW="/usr/sbin/iw"
NMCLI="/usr/bin/nmcli"
# Find the device name of wifi interface - wlan0 is the default
wifidev=`$IW dev | $AWK '/Interface/ { print $2 }'`

hs_conn="Hotspot"

if $NMCLI --terse connection show | $GREP -q $hs_conn
then
    # Delete connection in case configuration has changed
    $NMCLI connection delete id $hs_conn
fi
# See if wifi is connected to a local network
if $NMCLI --fields device --terse connection show --active | $GREP -q $wifidev
then
    # connected so nothing to do
    echo Local network available on $wifidev
    exit
fi

# Create temporary connection for WAP
# Read configuration
source /usr/local/etc/autowap/autowap.conf
hsaddr=`echo $ap_network | $AWK -F'.' '{ OFS = "." ; print $1, $2, $3, "254/24" }'`

# Create hotspot connection
$NMCLI device wifi hotspot ifname $wifidev con-name $hs_conn \
    ssid $ap_ssid band bg channel $ap_channel password "$ap_password"

$NMCLI device modify $wifidev ipv4.addresses $hsaddr
