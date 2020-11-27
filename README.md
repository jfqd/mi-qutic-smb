# mi-qutic-smb

This repository is based on [Joyent mibe](https://github.com/joyent/mibe). Please note this repository should be build with the [mi-qutic-base](https://github.com/jfqd/mi-qutic-base) mibe image.

## description

Minimal mibe image for a [Samba Server](https://www.samba.org/). You need to create your users and shares after the install.

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

## services

- `137/udp`: smb server
- `445/tcp`: smb server
