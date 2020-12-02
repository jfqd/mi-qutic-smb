# mi-qutic-smb

This repository is based on [Joyent mibe](https://github.com/joyent/mibe). Please note this repository should be build with the [mi-qutic-base](https://github.com/jfqd/mi-qutic-base) mibe image.

## description

Minimal mibe image for a [Samba Server](https://www.samba.org/). You need to create your users and shares after the install.

## setup

Create datasets for timemachine and home:

```
zfs create zones/datasets
zfs set compression=lz4 zones/datasets
zfs create zones/datasets/timemachine
zfs create zones/datasets/home
```

Create the machine:

```
IMAGE_UUID=$(imgadm list | grep 'qutic-smb' | tail -1 | awk '{ print $1 }')
vmadm create << EOF
{
  "brand":      "joyent",
  "image_uuid": "$IMAGE_UUID",
  "alias":      "smb",
  "hostname":   "smb.example.com",
  "dns_domain": "example.com",
  "resolvers": [
    "46.182.19.48",
    "194.150.168.168"
  ],
  "nics": [
    {
      "interface":   "net0",
      "nic_tag":     "admin",
      "ip":          "10.10.10.10",
      "gateway":     "10.10.10.1",
      "netmask":     "255.255.255.0",
      "dhcp_server": "1"
    }
  ],
  "filesystems": [
    {
      "source": "/zones/datasets/timemachine",
      "target": "/data",
      "type": "lofs",
      "options": [ "rw" ]
    },
    {
      "source": "/zones/datasets/home",
      "target": "/home",
      "type": "lofs",
      "options": [ "rw" ]
    }
    
  ],
  "max_physical_memory": 1024,
  "quota":                 10,
  "cpu_cap":              100,
  "customer_metadata": {
    "mail_smarthost": "mail.example.com",
    "mail_auth_user": "mail@example.com",
    "mail_auth_pass": "secure-pwd",
    "mail_adminaddr": "mail@example.com",
    "zabbix_server":  "zabbix.example.com",
    "zabbix_pski":    "PSKI",
    "zabbix_psk":     "long-pre-shared-key"
  }
}
EOF
```

## smb

Add existing system user to smb:

```
smbpasswd -a admin
```

Create a new system user and add her to smb:

```
useradd -m -s /usr/bin/bash -d /home/joe -u 1100 -g staff joe
chmod 0700 /home/joe
passwd joe
smbpasswd -a joe
```

For timemachine create a user folder too:

```
mkdir -m 700 /data/joe
chown jerry:staff /data/joe
```

On a Mac add the timemachine destination like:

```
sudo tmutil setdestination 'smb://joe:smbpasswd@smb.example.com/timemachine'
```

## services

- `137/udp`: smb server
- `445/tcp`: smb server
