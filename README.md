# mi-qutic-smb

This repository is based on [Joyent mibe](https://github.com/joyent/mibe). Please note this repository should be build with the [mi-qutic-base](https://github.com/jfqd/mi-qutic-base) mibe image.

## description

Minimal mibe image for a [Samba Server](https://www.samba.org/). You need to create your users and shares after the install.

## services

- `137/udp`: smb server
- `445/tcp`: smb server
