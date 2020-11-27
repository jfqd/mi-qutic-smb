# enable samba server
mkdir -p /data/timemachine || true
svcadm enable svc:/pkgsrc/samba:nmbd
svcadm enable svc:/pkgsrc/samba:smbd
