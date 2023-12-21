# Howdy

Howdy helps you discover all your local LAN machines, including macOS, Windows and Linux.
It's able to tell your their _mDNS_ names.

## How?

Howdy makes use of Apple's `Bonjour`, a zero-configuration netwoork service, via `Network.framework`.

It uses its very own protocol called `zero`, build on top of `TCP/IP`. It's a simple protocol, really.
It contains a fixed sized header of `8 bytes` that represents an `UInt`, declering the size of future `json` encoded `hostname` (for Unicode support 😃):

<img width="636" alt="image" src="https://github.com/stoiandan/Howdy/assets/10388612/56be2126-cdf6-4066-b536-1deb3b31c03c">

So, every time a app instance starts, it publishes it's service on mDNS (Bonjour) and browse over other avlaible service on the local netowrk.
If it finds one, it sends it's hostname via the Howdy (zero) protocol.

Here's and example of a Howdy instnace listing other three machines on the network:

<img width="1012" alt="image" src="https://github.com/stoiandan/Howdy/assets/10388612/6312fbca-d2ec-463f-834e-2723d5c00472">

To simulate these machines. I've used the `dns-sd` UNIX command to search for Bojour services and resolve the port.
I've then used netcat (`nc`) combined with echo to send an 8 byte `UInt` header via `UDP` and a plain-text string (for demo purposes):

```zsh
echo -n -e '\x09\x00\x00\x00\x00\x00\x00\x00bar.local' | nc -u localhost 65172
```

## Why?

While macOS's `Finder` does a good job in listing computers, soemtimes their simply not listed (probably because of OS policies) and
not enough info is available (for example the IP Address). 
`Howdy` allows you to retireve all that, without lowering security, it also gives you more info.

Plans are to also allow file transfer via `Howdy` this is a good alternative to file sharing, as you don't have to start a share and turn it off, for sercutity,
if all you want is to transfer.
