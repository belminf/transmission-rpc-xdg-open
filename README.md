# transmission-rpc-xdg-open 

Add a magnet link to your remote Transmission daemon via RPC. Shares response from the Transmission daemon via `notify-send`.

## Install

First, create a desktop file so that `xdg-open` could interact with it. View [script](magnet-open.sh) for environment variables needed.

```bash
$ cp magnet-open.desktop.example ~/.local/share/applications/magnet-open.desktop
$ vim ~/.local/share/applications/magnet-open.desktop
```
Finally, make the desktop file the default open action for magnet URLs:

```bash
$ xdg-mime default magnet-open.desktop x-scheme-handler/magnet
```
