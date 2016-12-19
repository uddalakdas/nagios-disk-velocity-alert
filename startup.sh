#!/bin/bash

chmod -R 777 /opt/nagios/libexec/sendEmail/ 
chmod 777 /opt/nagios/libexec/velocity.sh
chmod 777 /opt/nagios/libexec/space.sh 

service ssh start

if [ -z "$WINDOWS_HOST" ]; then
	echo "WINDOWS_HOST not set."
else
	sed -i "s/<WINDOWS_HOST>/${WINDOWS_HOST}/g" /opt/nagios/etc/objects/windows.cfg
fi

if [ -z "$SMTP_SERVER" ]; then
	echo "SMTP_SERVER not set."
else
	sed -i "s/<SMTP_SERVER>/${SMTP_SERVER}/g" /opt/nagios/etc/objects/commands.cfg
fi
if [ -z "$SMTP_PORT" ]; then
	echo "SMTP_PORT not set."
else
	sed -i "s/<SMTP_PORT>/${SMTP_PORT}/g" /opt/nagios/etc/objects/commands.cfg
fi
if [ -z "$ADMIN_EMAIL" ]; then
	echo "ADMIN_EMAIL not set."
else
	sed -i "s/<ADMIN_EMAIL>/${ADMIN_EMAIL}/g" /opt/nagios/etc/objects/contacts.cfg
fi

if [ -z "$NAGIOS_SERVER_EMAIL" ]; then
	echo "NAGIOS_SERVER_EMAIL not set."
else
	sed -i "s/<NAGIOS_SERVER_EMAIL>/${NAGIOS_SERVER_EMAIL}/g" /opt/nagios/etc/objects/commands.cfg
fi

if [ -z "$WARNING_VELOCITY" ]; then
	echo "WARNING_VELOCITY not set."
else
	sed -i "s/<WARNING_VELOCITY>/${WARNING_VELOCITY}/g" /opt/nagios/etc/objects/windows.cfg
fi

if [ -z "$ERROR_VELOCITY" ]; then
	echo "ERROR_VELOCITY not set."
else
	sed -i "s/<ERROR_VELOCITY>/${ERROR_VELOCITY}/g" /opt/nagios/etc/objects/windows.cfg
fi

if [ -z "$WARNING_PERCENTAGE" ]; then
	echo "WARNING_PERCENTAGE not set."
else
	sed -i "s/<WARNING_PERCENTAGE>/${WARNING_PERCENTAGE}/g" /opt/nagios/etc/objects/windows.cfg
fi

if [ -z "$ERROR_PERCENTAGE" ]; then
	echo "ERROR_PERCENTAGE not set."
else
	sed -i "s/<ERROR_PERCENTAGE>/${ERROR_PERCENTAGE}/g" /opt/nagios/etc/objects/windows.cfg
fi

/usr/local/bin/start_nagios

