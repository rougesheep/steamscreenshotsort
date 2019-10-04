$config = @{
    screenshot_folder = Convert-Path .
    output_folder = $null
    steam_api = "https://api.steampowered.com/ISteamApps/GetAppList/v0002/"
    cache_file = "steam_games.json"
    custom_file = "custom_games.json"
}

if ( -not $config['output_folder'] ) {
    $config['output_folder'] = $config['screenshot_folder']
} else {
    if (-not (Test-Path $config['output_folder'])){
        New-Item -ItemType Directory -Path $config['output_folder']
    }
}

if (-not (Test-Path $config['cache_file'])) {
    Invoke-WebRequest -Uri $config['steam_api'] -OutFile $config['cache_file']
}

$catalog = Get-Content -Encoding UTF8 -Raw -Path $config['cache_file'] | ConvertFrom-Json

if (Test-Path $config['custom_file']) {
    $custom = Get-Content -Encoding UTF8 -Raw -Path $config['custom_file'] | ConvertFrom-Json
} else {
    $custom = (ConvertTo-Json @())
}

$files = Get-ChildItem -File $config['screenshot_folder'] | Where-Object Extension -in '.png', '.jpg' | Select-Object -ExpandProperty Name

ForEach($file in $files ){
    $appID = $file.Split('_')[0]
    if (($appName = $catalog.applist.apps | Where-Object {$_.appid -eq $appID} | Select-Object -ExpandProperty name) -is [string]) {

    } elseif (($appName = $custom.applist.apps | Where-Object {$_.appid -eq $appID} | Select-Object -ExpandProperty name) -is [string]) {
        
    } else {
        Write-Output "AppID $appid not found in database."
    }
    $appName = $appName -replace '\<|\>|:|"|/|\\|\||\?|\*', ''
    if ($appName -is [string]) {
        $copyOut = Join-Path $config['output_folder'] $appName
        if (-not (Test-Path $copyOut)){
            New-Item -ItemType Directory -Path $copyOut
        }
        Move-Item -Path "$($config['screenshot_folder'])\$file" -Destination "$($config['output_folder'])\$appName"
    }
}