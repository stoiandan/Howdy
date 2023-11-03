# Howdy

Howdy helps you discover all your local LAN machines, including macOS, Windows and Linux.
It's able to tell your their _mDNS_ names, along with IP addresses.

## How?

Howdy makes use of Apple's `Bonjour`, a zero-configuration netwoork service, via `Network.framework`.

## Why?

While macOS's `Finder` does a good job in listing computers, soemtimes their simply not listed (probably because of OS policies) and
not enough info is available (for example the IP Address). 
`Howdy` allows you to retireve all that, without lowering security, it also gives you more info.

Plans are to also allow file transfer via `Howdy` this is a good alternative to file sharing, as you don't have to start a share and turn it off, for sercutity,
if all you want is to transfer.
