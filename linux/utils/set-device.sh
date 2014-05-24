#!/bin/bash

xinput list
echo "Select device id: "
read device_id
echo "Select device status [0] - Disabled [1] - Enabled"
read device_status
xinput set-prop device_id "Device Enabled" device_status
