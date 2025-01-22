#! /bin/bash
################################################################################
#
#       autowapctl.bash
#   A service to start a Wireless Access Point (WAP) if there is no
#   connection to a local wifi network.  This service is a 'one-shot'
#   that runs after the network-online target has been achieved.
#
#   25 November, 2023 - E M Thornber
#   Created
#
#   27 November, 2023 - E M Thornber
#   Script name change
#   Add entry points for shutdown and restart
#
#   28 December, 2024 - E M Thornber
#   Add pigpiod service check
#   Add LED control
#
#   22 January, 2025 - E M Thornber
#   Remove pigpiod service check - not needed
#   Improved Hotspot configuration
#
################################################################################

AWK="/usr/bin/awk"
GREP="/usr/bin/grep"
IW="/usr/sbin/iw"
NMCLI="/usr/bin/nmcli"
PY3="/usr/bin/python3"

#
ARGV="$@"
#
# |||||||||||||||||||| START CONFIGURATION SECTION ||||||||||||||||||||
# --------------------                             --------------------
#
# Find the device name of wifi interface - wlan0 is the default
WIFI_DEV=`$IW dev | $AWK '/Interface/ { print $2 }'`

# Read configuration
if test -f "$HTSPT_INI_FILE" ; then
    . $HTSPT_INI_FILE
else
    ap_ssid="canpiwi"
    ap_password="1234567890"
    ap_channel=6
    ap_network="192.168.45.1"
    ap_gpio_pin=22
fi

# Create IP Address for WAP
HSADDR=`echo $ap_network | $AWK -F'.' '{ OFS = "." ; print $1, $2, $3, "254/24" }'`

# Connection ID of WAP
HS_CONN="Hotspot"

#
# --------------------                             --------------------
# |||||||||||||||||||| END CONFIGURATION SECTION ||||||||||||||||||||
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
        # Turn the Red LED off
        $PY3 /usr/local/bin/gpio_set_pin_value.py -g $ap_gpio_pin -v off
    else
        # not connected so start hotspot
        echo Starting hotspot on $WIFI_DEV
		# Create hotspot connection
		$NMCLI device wifi hotspot ifname $WIFI_DEV con-name $HS_CONN \
			ssid $ap_ssid band bg channel $ap_channel password $ap_password
		ERROR=$?
		if [ "$ERROR" = 0 ] ; then
			$NMCLI connection modify $HS_CONN ipv4.method shared
			$NMCLI connection modify $HS_CONN ipv4.addresses $HSADDR
            $NMCLI connection up $HS_CONN
			ERROR=$?
			if [ "$ERROR" != 0 ] ; then
			WHERE="connection modify"
			fi
		else
			WHERE="device hotspot"
		fi
        # Turn the Red LED on
        $PY3 /usr/local/bin/gpio_set_pin_value.py -g $ap_gpio_pin -v on
    fi
    ;;
stop|restart)
    if $NMCLI --terse connection show --active | $GREP -q $HS_CONN
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

