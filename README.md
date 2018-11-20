## Steam Screenshot Sorter

Sort Steam screenshots into folders based on game names written in Powershell. It's probably awful. Uses the Steam api to get game names. Sort of works now. Probably bugs.

## Requirements

Set up Steam to save screenshots elsewhere.
```
Steam > Settings > In-Game > Screenshot Folder
```

## Set  up a shortcut

You can make a shortcut to make this easier to run:

* Right click `steam_screenshot_sort.ps1` > Send To > Desktop
* At the start of Target add `powershell.exe -ExecutionPolicy Bypass -File `
* Set Start In to wherever your screenshots are (eg. `%USERPROFILE%/Pictures/Steam`)
* Move the shortcut to wherever

## New Games

This uses a local cache of Steams game catalog. When a new game comes out you need to delete the cache file `steam_games.json`.

## Config

There's a config hash at the top of the script. You can change the paths there if you want.