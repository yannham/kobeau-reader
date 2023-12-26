# kobeau-reader

Simple, one-liner installer of [KOReader][koreader] on a Kobo device powered by [Nix][nix].

**Disclaimer**: I am not the original author of the install script packaged
here. It is taken from [A mobile read thread][forum-thread], where it's made
availabel without attribution nor licensing. I use it myself to deploy new
versions of KOReader to my Kobo Forma and I made it available as a flake,
without having to go to the forum thread and download things manually. Use at
your own risks.

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

### KOReader version

The URL for koreader is a hardcoded fixed-output derivation, because those URLs
seem to be impredictable. Thus, it might not be up to date. It should be easy to
get a more recent version: go on the [original thread][forum-thread] and spot
the latest URL for the OCP-koreader-kobo-vXXXX-XX. Find the corresponding URL in
[flake.nix](./flake.nix) (in the argument of `fetchurl`) and update it. The
first run should produce a hash mismatch error, since the hash should be updated
as well: copy the hash Nix is expecting from the error message, and replace it
in the argument of `fetchurl` (`sha256 = ...`). You should then use the latest
KOReader version available.

If you update successfully, consider upstreaming your change to this repository!

## Usage

The main pacakge of this flake downloads the install script and a archive of the
one-click install package for KOReader on Kobo and put them in the same
directory. Using `nix run` will start the script.

```console
$ nix run github:yannham/kobeau-reader
[...]
```

Simply follows the script's inscructions from there. After the update, **safely
eject your Kobo before unplugging**, watch it process and reboot.

[forum-thread]: https://www.mobileread.com/forums/showthread.php?t=314220
[koreader]: https://github.com/koreader/koreader
[nix]: https://nixos.org/
