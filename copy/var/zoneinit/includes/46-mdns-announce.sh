#!/bin/bash
svcadm enable svc:/network/dns/multicast:default
svcadm enable svc:/custom/mdns-announce:smb
svcadm enable svc:/custom/mdns-announce:device-info
