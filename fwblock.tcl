#!/usr/bin/tclsh

#-----------------------------------------
# fwblock -- 1.00
# Utility to block individual IP's based on quota
# Created by Steven W. Balch Jr.
#-----------------------------------------

set timer 30

#-----------------------------------------
puts ""
puts "Starting FW Block Process"
puts ""

set src [lindex $argv 0]
#-----------------------------------------

#-----------------------------------------
if {$src == ""} {
puts {}
puts { -- It looks like you are missing the source IP address -- }
puts {}
exit
                }
#-----------------------------------------

#-----------------------------------------
proc dropquota {} {
global src timer
puts "Enabling DoS mitigation for quota"
puts ""
exec sim_dos ctl -m 0 -x 0 -l 100
puts "Adding a quota based block rule for IP address: $src"
exec fw samp add -a d -l r -t $timer quota source cidr:$src/32 pkt-rate 0 service any flush true
                   }
#-----------------------------------------

#-----------------------------------------
dropquota
#-----------------------------------------
puts ""
puts "Finished FW Block Process"
#-----------------------------------------

