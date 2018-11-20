$config = @{
    screenshot_folder = Convert-Path .
    output_folder = $screenshot_folder
    steam_api = "https://api.steampowered.com/ISteamApps/GetAppList/v0002/"
    cache_file = "steam_games.json"
}

if (-not (Test-Path $config['cache_file'])) {
    Invoke-WebRequest -Uri $config['steam_api'] -OutFile $config['cache_file']
}

if (-not (Test-Path $config['output_folder'])){
    New-Item -ItemType Directory -Path $config['output_folder']
}

$catalog = Get-Content -Encoding UTF8 -Raw -Path $config['cache_file'] | ConvertFrom-Json

$files = Get-ChildItem $config['screenshot_folder'] -Filter *.png | Select-Object -ExpandProperty Name

ForEach($file in $files ){
    $appID = $file.Split('_')[0]
    $appName = $catalog.applist.apps | Where-Object {$_.appid -eq $appID} | Select-Object -ExpandProperty name
    $appName = $appName -replace '\<|\>|:|"|/|\\|\||\?|\*', ''
    $copyOut = Join-Path $config['output_folder'] $appName
    if (-not (Test-Path $copyOut)){
        New-Item -ItemType Directory -Path $copyOut
    }
    Move-Item -Path "$($config.screenshot_folder)\$file" -Destination "$($config.output_folder)\$appName"
}