# kobeau-reader

Simple, one-liner installer of KOReader on a Kobo device powered by Nix.

**Disclaimer**: I am not the original author of the script. It is taken from [A
mobile read thread](https://www.mobileread.com/forums/showthread.php?t=314220),
without attribution nor licensing. I use it myself to deploy new versions of
KOReader to my Kobo Forma and made it available as a flake, without having to go
to the forum thread and do things manually.

## Caveats

(taken from the original message thread):

> The script relies on a decently recent Linux distribution.
>
> - They'll only behave properly with a *single* Kobo plugged to the computer.
>   Running 'em with *no* Kobo plugged in is safe, running 'em with multiple
>   Kobos may lead to unexpected behavior: it may be handled sanely, but it
>   might not.
> - Every OS allows you to eject an USB device safely, without having to unplug
>   it. Always do that. Only unplug it as a last resort.
> - Don't download the packages onto the device itself, that's unnecessary, and
>   may actually complicate matters on Linux.
>
> With that out of the way, here's what this is supposed to automate: figuring
> out where the Kobo is mounted, asking you to confirm what you want to install,
> and properly unpacking the right archive. This will also automatically prevent
> Nickel from scanning *nix hidden folders on FW 4.17+.
>
> NOTE: Pertaining to that particular bit of trickery, I would **strongly**
> recommend that you do all this right after a clean, full reboot of your
> device; and to connect the device *straight from the Home screen*, without
> touching any documents first!
>
> Note that, in addition to the packages in the first post, the scripts also
> handle KFMon's standalone install package, to quickly restore functionality
> after a FW update, for instance.

## Usage

TODO.
