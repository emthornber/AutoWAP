#! /bin/bash
################################################################################
#
#       autowapctl.bash
#   A service to start a Wireless Access Point (WAP) if there is no
#   connection to a local wifi network.  This service is a 'one-shot'
#   that runs after the netork-online target has been achieved.
#
#   25 November, 2023 - E M Thornber
#   Created
#
#   27 November, 2023 - E M Thornber
#   Script name change
#   Add entry points for shutdown and restart
#
################################################################################

AWK="/usr/bin/awk"
GREP="/usr/bin/grep"
IW="/usr/sbin/iw"
NMCLI="/usr/bin/nmcli"

#
ARGV="$@"
#
# |||||||||||||||||||| START CONFIGURATION SECTION ||||||||||||||||||||
# --------------------                             --------------------
#
# Find the device name of wifi interface - wlan0 is the default
WIFI_DEV=`$IW dev | $AWK '/Interface/ { print $2 }'`

# Read configuration
AUTOWAP_ENVVARS="/usr/local/etc/autowap/autowap.conf"
if test -f $AUTOWAP_ENVVARS ; then
    . $AUTOWAP_ENVVARS
else
    ap_ssid="canpiwi"
    ap_password="1234567890"
    ap_channel=6
    ap_network="192.168.45.1"
fi

# Create IP Address for WAP
HSADDR=`echo $ap_network | $AWK -F'.' '{ OFS = "." ; print $1, $2, $3, "254/24" }'`

# Connection ID of WAP
HS_CONN="Hotspot"

#
# --------------------                             --------------------
# |||||||||||||||||||| START CONFIGURATION SECTION ||||||||||||||||||||
#

ERROR=0
WHERE=""
if [ "x$ARGV" = "x" ] || [ "x$ARGV" = "xusage" ] || [ "x$ARGV" = "xhelp" ] || [ "x$ARGV" = "x--help" ]; then 
    echo "Usage: $0 start|stop|restart" >&2
    exit 1
fi

case "$ARGV" in
start)
    # See if wifi is connected to a local network
    if $NMCLI --fields device --terse connection show --active | $GREP -q $WIFI_DEV
    then
	# connected so nothing to do
	echo Local network available on $WIFI_DEV
    else
	# Create hotspot connection
	$NMCLI device wifi hotspot ifname $WIFI_DEV con-name $HS_CONN \
	    ssid $ap_ssid band bg channel $ap_channel password "$ap_password"
	ERROR=$?
	if [ "$ERROR" = 0 ] ; then
	    $NMCLI device modify $WIFI_DEV ipv4.addresses $HSADDR
	    ERROR=$?
	    if [ "$ERROR" != 0 ] ; then
		WHERE="device modify"
	    fi
	else
	    WHERE="device hotspot"
	fi
    fi
    ;;
stop|restart)
    if $NMCLI --terse connection show | $GREP -q $HS_CONN
    then
	# Remove hotspot connection
	$NMCLI connection delete id $HS_CONN
	ERROR=$?
	if [ "$ERROR" != 0 ] ; then
	    WHERE="connection delete"
	fi
    else
	echo No hotspot connection to remove
    fi
    ;;
*)
esac

if [ "$ERROR" != 0 ] ; then
    echo Action \'"$@"\' failed at \'"$WHERE"\'
    echo The nmcli log may have more information
fi

exit $ERROR

