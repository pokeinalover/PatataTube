#header pwsh 
$ver = "1.4.2 Development Preview"
Clear-Host
write-host "Patatatube Power $ver"
#header end

#check dependencies
write-host "Checking system..."
if(Get-Command "python3"){
    write-host "Python3 OK" -ForegroundColor Green
}
else{
    Write-Warning "Falta Python3"
    $continue = read-host "Instalar Python3? [install]"
    if($continue -eq "install"){
        apt update
        apt install python3
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "Python3 es necesario para continuar"
        exit
    }
}



if(Get-Command "yt-dlp" -ErrorAction SilentlyContinue){ # CHECK CORE ################
    write-host "Youtube DL OK" -ForegroundColor Green
}
else{
    if(Get-Command "pip" -ErrorAction SilentlyContinue){
        Write-Warning "youtube-dl no detectado"
        $confirm = read-host "descargar youtube-dl? [continue]"
        if($confirm -eq "continue"){
            write-host "Descargando engine Youtube-DL"
            apt update
            python3 -m pip install -U yt-dlp # CORE HERE ################################
            write-host "Reinicie patatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "No puede continuar sin youtube-dl"
            exit
        }

    }
    else{
        Write-Warning "pip no detectado"
        $confirm = read-host "descargar pip y youtube-dl? [continue]"
        if($confirm -eq "continue"){
            Write-host "Instalando pip"
            apt update
            apt install pip
            write-host "Descargando engine Youtube-DL"
            python3 -m pip install -U yt-dlp # REDOWNLOAD CORE ################################
            write-host "Reinicie patatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "No se puede continuar sin pip y sin verificar youtube-dl"
            exit
        }
    }
}

if(Get-Command "ffmpeg" -ErrorAction SilentlyContinue){
    write-host "FFMPEG OK" -ForegroundColor Green
}
else{
    Write-Warning "Falta MMPEG"
    $continue = read-host "Instalar FFMPEG? [install]"
    if($continue -eq "install"){
        apt update
        apt install ffmpeg
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "FFMPEG es necesario para continuar"
        exit
    }

}

if(Get-Command "wget" -ErrorAction SilentlyContinue){
    write-host "wget OK" -ForegroundColor Green
}
else{
    Write-Warning "Falta wget"
    $continue = read-host "Instalar wget? [install]"
    if($continue -eq "install"){
        apt update
        apt install wget
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "wget es necesario para continuar"
        exit
    }

}
# End Check Dependencies

#check sdcard access
if(test-path -path /sdcard){
    write-host "Memory Access OK" -ForegroundColor Green
}
else{
    Write-Warning "Memoria no montada"
    write-host "Monta fuera de proot la memoria con el comando [termux-setup-storage]"
    exit
}

if(test-path -path /sdcard/patatatube){
    Write-Warning "Version anterior detectada"
    write-host "para el correcto funcionamiento hay que restablecer el directorio patatatube"
    write-host "ATENCION: se va a borrar todo el contenido de /sdcard/patatatube" -ForegroundColor Red
    $proceder = read-host "Reestablecer directorios patatatube? [continue]"
    if($proceder -eq "continue"){
        write-host "Eliminando directorio patatatube..."
        Remove-Item -Recurse -Force /sdcard/patatatube
        write-host "Construyendo nuevos directorios..."
        mkdir /sdcard/Movies/patatatube
        mkdir /sdcard/Music/patatatube
        mkdir /sdcard/Download/patatatube
        write-host "Directorios nuevos construidos" -ForegroundColor Green
        write-host "Reinicie patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "Se requieren los nuevos directorios de trabajo para continuar"
        exit
    }
}

if(-not(test-path -path /sdcard/Movies/patatatube)){
    Write-Warning "Directorio Movies no detectado"
    $continue = read-host "Contruir ahora directorio Movie? [continue]"
    if($continue -eq "continue"){
        mkdir /sdcard/Movies/patatatube
        write-host "Directorio construido" -ForegroundColor Green
    }
    else{
        Write-Warning "Se requieren los nuevos directorios de trabajo para continuar"
        exit
    }
}
else{
    write-host "Movie DIR OK"
}

if(-not(test-path -path /sdcard/Music/patatatube)){
    Write-Warning "Directorio Music no detectado"
    $continue = read-host "Contruir ahora directorio Music? [continue]"
    if($continue -eq "continue"){
        mkdir /sdcard/Music/patatatube
        write-host "Directorio construido" -ForegroundColor Green
    }
    else{
        Write-Warning "Se requieren los nuevos directorios de trabajo para continuar"
        exit
    }
}
else{
    write-host "Music DIR OK"
}

if(-not(test-path -path /sdcard/Download/patatatube)){
    Write-Warning "Directorio Download/patatatube no detectado"
    $continue = read-host "Contruir ahora directorio Download/patatatube? [continue]"
    if($continue -eq "continue"){
        mkdir /sdcard/Download/patatatube
        write-host "Directorio construido" -ForegroundColor Green
    }
    else{
        Write-Warning "Se requieren los nuevos directorios de trabajo para continuar"
        exit
    }
}
else{
    write-host "Download DIR OK"
}


write-host "All Check OK" -ForegroundColor Green
Start-Sleep -s 1
# function ###############################################################
function geturl{
    $script:url = read-host "Pega la URL aqui"
}
write-host ""
write-host ""

# MenuInvoke ###############################################################
$exitmode = $true
while($exitmode){
    clear-host
write-host "Patatatube Content Downloader $ver" -ForegroundColor Cyan
write-host "By " -NoNewline
write-host "Contratop" -ForegroundColor Cyan -NoNewline
write-host " & " -NoNewline
write-host "pokeinalover" -ForegroundColor Magenta
write-host ""
if($url){
    write-host "URL: $url" -ForegroundColor Cyan
}
write-host ""
if($url){
    write-host "[url] Cambiar URL"
}
else{
    write-host "[url] Establecer URL"
}
Write-host "[1] Music"
Write-host "[2] Video"
write-host "[3] Update"
write-host "[4] About"
write-host "[5] Quit"
write-host ""
write-host "[advanced] Descarga Personalizada"
write-host "[more] Opciones avanzadas"
$menu = read-host "Select number"
if($menu -eq "url"){
    write-host ""
    geturl
}
elseif($menu -eq 1){
    if(-not($url)){
        geturl
    }
    clear-host
    write-host "URL: $url"
    write-host ""
    write-host "Descargando MP3..." -ForegroundColor Cyan
    yt-dlp -o '/sdcard/Music/patatatube/%(title)s.%(ext)s' --extract-audio --audio-format mp3 $url
    write-host ""
    write-host "Descarga finalizada" -ForegroundColor Cyan
    exit
}
elseif($menu -eq 2){
    if(-not($url)){
        geturl
    }
    clear-host
    write-host "URL: $url"
    write-host "Descargando la mejor version del video" -ForegroundColor Cyan
    yt-dlp -S ext:mp4:m4a -o '/sdcard/Movies/patatatube/%(title)s.%(ext)s' $url
    write-host "Descarga finalizada" -ForegroundColor Green
    exit
}
elseif($menu -eq 3){
    write-host ""
    Write-host "Actualizando PatataTube..." -ForegroundColor Yellow
    write-host ""
    Remove-Item patatatube-power.ps1
    Invoke-WebRequest -uri "https://raw.githubusercontent.com/pokeinalover/PatataTube/main/patatatube-power.ps1" -OutFile patatatube-power.ps1
    write-host "Actualizacion finalizada" -ForegroundColor Green
    exit
}
elseif($menu -eq 4){
    write-host ""
    write-host "About PatataTube $ver" -ForegroundColor Magenta
    write-host "Made by pokeinalover and with ContratopDev's help because im still learning"
    write-host "Stay tuned for more content and stuff on my web page!" 
    write-host "pokeinalover.github.io" 
    Pause
}
elseif($menu -eq 5){
    clear-host
    write-host "Saliendo de patatatube..." -ForegroundColor Cyan
    exit
}
elseif($menu -eq "more"){
    Clear-Host
    Write-host "Menu avanzado" -ForegroundColor Cyan
    write-host ""
    Write-host "[repair] Reparar Patatatube Power"
    Write-host "[debugupdate] Actualiza desde github/contratop"
    write-host "[AnyPrompt] Menu anterior"
    $menu2 = read-host "Escribe opcion"
    if($menu2 -eq "repair"){
        clear-host
        write-host "Hey tu, si tu"
        write-host "Si estas intentando reparar patatatube es por que pasa algo"
        write-host "Escribe tu feedback en github.com/pokeinalover"
        write-host ""
        Write-Warning "Al reparar, se reinstalara patatatube y sus dependencias"
        $continue = read-host "Continuar reparacion? [continue]"
        if($continue -eq "continue"){
            write-host "Reparando Patatatube..."
            write-host ""
            write-host "Reinstalando dependencias..."
            apt update
            apt upgrade -y
            apt install python -y
            apt install python3 -y
            apt install pip -y
            apt install ffmpeg
            apt install wget
            pip instal youtube-dl
            python3 -m pip install -U yt-dlp
            Invoke-WebRequest -uri "https://raw.githubusercontent.com/pokeinalover/PatataTube/main/patatatube-power.ps1" -OutFile patatatube-power.ps1
            write-host ""
            write-host "Reparacion completada" -ForegroundColor Green
            exit
        }
        else{
           write-host "Operacion cancelada" -ForegroundColor Yellow
           Start-Sleep -s 1
        }
    }
    elseif($menu2 -eq "debugupdate"){
        Write-Warning "Debug Updater"
        write-host "Only for developers" -ForegroundColor Yellow
        Write-Warning "Debug Updater disabled"
        Write-host "Merged to pokeinalover/patatatube"
        write-host "Use internal updater"
        exit
    }
}
elseif ($menu -eq "advanced"){
    if(-not($url)){
        geturl
    }
    Clear-Host
    write-host "URL: $url"
    write-host "Obteniendo lista de formatos..." -ForegroundColor Cyan
    yt-dlp -F $url
    write-host ""
    write-host "Si hay algun error. escribe [back]" -ForegroundColor Yellow
    write-host "Tambien puedes [best] para la mejor opcion" -ForegroundColor Cyan
    $fcode = read-host "Selecciona un formato"
    if($fcode -eq "back"){
        write-host "Revirtiendo cambios..."
        Start-Sleep -s 2
    }
    else{
        clear-host
        write-host "URL: $url"
        if($fcode -eq "best"){
            write-host "Format Code: $fcode (Automatic Max Quality)" -ForegroundColor Cyan
        }
        else{
            write-host "Format Code: $fcode (Manual)"
        }
        write-host ""
        write-host "Destino: /sdcard/Download/patatatube"
        write-host "Descargando el contenido..." -ForegroundColor Cyan
        yt-dlp -o '/sdcard/Download/patatatube/%(title)s.%(ext)s' -f $fcode $url
        write-host ""
        write-host "Descarga finalizada" -ForegroundColor Cyan
        exit
    }
}
else{
    Write-Warning "opcion no valida"
    start-sleep -s 1
}

}


## CONTINUAR POR AQUI

