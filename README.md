## Steam Screenshot Sorter

Sort Steam screenshots into folders based on game names written in Powershell. It's probably awful. Uses the Steam api to get game names. Sort of works now. Probably bugs.

I wrote this in PowerShell because in theory anyone could run it with no extra installs.

Please back up your screenshots before running this.

## Requirements

Set up Steam to save screenshots elsewhere.
```
Steam > Settings > In-Game > Screenshot Folder
```
You *could* copy screenshots from the Steam folder, it should work with `.jpg` images, but it doesn't go into sub-folders.

I wouldn't put anything other than Steam screenshots in the folder this runs on.

## Set  up a shortcut

You can make a shortcut to make this easier to run:

* Right click `steam_screenshot_sort.ps1` > Send To > Desktop
* At the start of Target add `powershell.exe -ExecutionPolicy Bypass -File `
* Set Start In to wherever your screenshots are (eg. `%USERPROFILE%/Pictures/Steam`)
* Move the shortcut to wherever

## New Games

This uses a local cache of Steams game catalog. When a new game comes out you need to delete the cache file `steam_games.json` and it will download again.

## Config

There's a config hash at the top of the script. You can change the paths there if you want. It defaults to the folder it's run from (or where you set Start In to on the shortcut)

## Custom Games

Non-Steam games obviously don't exist in Steam's game database. To categorise them create a `custom_games.json` file. Should look something like this:

```
{"applist":{"apps":[{"appid":13719640941063569408,"name":"Clone Hero"}]}}
```

## To-Do

* Test bad file names
* Expire the cache file if it's old