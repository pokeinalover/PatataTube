#header pwsh powershell GlaDOS PotatOS uwu
$ver = "2.0.2"
Clear-Host
write-host "Patatatube Power $ver"
#header end

#check dependencies
write-host "Checking system..."
if(Get-Command "python3"){
    write-host "Python3 OK" -ForegroundColor Green
}
else{
    Write-Warning "Missing Python3"
    $continue = read-host "Install Python3? [install]"
    if($continue -eq "install"){
        apt update
        apt install python3
        write-host "Please re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "Python3 is required to continue"
        exit
    }
}



if(Get-Command "yt-dlp" -ErrorAction SilentlyContinue){ # CHECK CORE ################
    write-host "Youtube DL OK" -ForegroundColor Green
}
else{
    if(Get-Command "pip" -ErrorAction SilentlyContinue){
        Write-Warning "youtube-dl not found"
        $confirm = read-host "Download youtube-dl? [continue]"
        if($confirm -eq "continue"){
            write-host "Downloading engine Youtube-DL"
            apt update
            python3 -m pip install -U yt-dlp # CORE HERE ################################
            write-host "Re-startpatatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "youtube-dl is required to continue"
            exit
        }

    }
    else{
        Write-Warning "pip not found"
        $confirm = read-host "Download pip and youtube-dl? [continue]"
        if($confirm -eq "continue"){
            Write-host "Installing pip"
            apt update
            apt install pip
            write-host "Downloading engine Youtube-DL"
            python3 -m pip install -U yt-dlp # REDOWNLOAD CORE ################################
            write-host "Re-start patatatube" -ForegroundColor Cyan
            exit
        }
        else{
            Write-Warning "pip and verifying youtube-dl are required to continue"
            exit
        }
    }
}

if(Get-Command "ffmpeg" -ErrorAction SilentlyContinue){
    write-host "FFMPEG OK" -ForegroundColor Green
}
else{
    Write-Warning "Missing MMPEG"
    $continue = read-host "Install FFMPEG? [install]"
    if($continue -eq "install"){
        apt update
        apt install ffmpeg
        write-host "Re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "FFMPEG is required to continue"
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
        write-host "Re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "wget is required to continue"
        exit
    }

}
# End Check Dependencies

#check sdcard access
if(test-path -path /sdcard){
    write-host "Memory Access OK" -ForegroundColor Green
}
else{
    Write-Warning "Memory not assambled"
    write-host "Use [termux-setup-storage] to reassamble memory outside proot"
    exit
}

if(test-path -path /sdcard/patatatube){
    Write-Warning "Old version found"
    write-host "It is required to restablish the deprecated patatatube directories for patatatube to work correctly"
    write-host "WARNING: All the content in Patatatube de /root /Music y /Movies will be deleted" -ForegroundColor Red
    $proceder = read-host "Reestablish directories in patatatube? [continue]"
    if($proceder -eq "continue"){
        write-host "Deleting directory deprecated patatatube..."
        Remove-Item -Recurse -Force /sdcard/patatatube
        Remove-Item -Recurse -Force /sdcard/Movies/patatatube
        Remove-Item -Recurse -Force /sdcard/Music/patatatube
        write-host "Task completed" -ForegroundColor Green
        write-host "Re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "The new working directories are required to continue"
        exit
    }
}
elseif(test-path -path /sdcard/Music/patatatube){
    Write-Warning "Old version found"
    write-host "It is required to restablish the deprecated patatatube directories for patatatube to work correctly"
    write-host "WARNING: All the content in Patatatube de /root /Music y /Movies will be deleted" -ForegroundColor Red
    $proceder = read-host "Reestablish directories in patatatube? [continue]"
    if($proceder -eq "continue"){
        write-host "Deleting directory deprecated patatatube..."
        Remove-Item -Recurse -Force /sdcard/patatatube
        Remove-Item -Recurse -Force /sdcard/Movies/patatatube
        Remove-Item -Recurse -Force /sdcard/Music/patatatube
        write-host "Task completed" -ForegroundColor Green
        write-host "Re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "The new working directories are required to continue"
        exit
    }
}
elseif(test-path -path /sdcard/Movies/patatatube){
    Write-Warning "Old version found"
    write-host "It is required to restablish the deprecated patatatube directories for patatatube to work correctly"
    write-host "WARNING: All the content in Patatatube de /root /Music y /Movies will be deleted" -ForegroundColor Red
    $proceder = read-host "Reestablish directories in patatatube? [continue]"
    if($proceder -eq "continue"){
        write-host "Deleting directory deprecated patatatube..."
        Remove-Item -Recurse -Force /sdcard/patatatube
        Remove-Item -Recurse -Force /sdcard/Movies/patatatube
        Remove-Item -Recurse -Force /sdcard/Music/patatatube
        write-host "Task completed" -ForegroundColor Green
        write-host "Re-start patatatube" -ForegroundColor Cyan
        exit
    }
    else{
        Write-Warning "The new working directories are required to continue"
        exit
    }
}

if(-not(test-path -path /sdcard/Download/patatatube)){
    Write-Warning "Unable to find directory Download/patatatube"
    $continue = read-host "Create directory Download/patatatube? [continue]"
    if($continue -eq "continue"){
        mkdir /sdcard/Download/patatatube
        write-host "The directory was created successfully" -ForegroundColor Green
    }
    else{
        Write-Warning "The new working directories are required to continue"
        exit
    }
}
else{
    write-host "Download DIR OK" -ForegroundColor Green
}


write-host "All Check OK" -ForegroundColor Green
Start-Sleep -s 1
# function ###############################################################
function geturl{
    $script:url = read-host "Paste your URL here"
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
write-host "pokeinalover" -ForegroundColor Magenta -NoNewline
write-host "" -NoNewline
write-host " (Mostly by Contratop)" -ForegroundColor Green
write-host ""
if($url){
    write-host "URL: $url" -ForegroundColor DarkCyan
    $urltitle = Invoke-RestMethod "https://title.mihir.ch/$url"
    write-host "Titulo: $urltitle" -ForegroundColor Cyan
}
write-host ""
if($url){
    write-host "[url] Change URL"
}
else{
    write-host "[url] Establish URL"
}
Write-host "[1] Music" -ForegroundColor Magenta
Write-host "[2] Video" 
write-host "[3] Update" -ForegroundColor Magenta
write-host "[4] About"
write-host "[5] Quit" -ForegroundColor Magenta
write-host ""
write-host "[advanced] Customized download"
write-host "[more] Advanced options"
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
    write-host "Downloading MP3..." -ForegroundColor Cyan
    yt-dlp -o '/sdcard/Download/patatatube/%(title)s.%(ext)s' --extract-audio --audio-format mp3 $url
    write-host ""
    write-host "Download successfully finished" -ForegroundColor Cyan
    exit
}
elseif($menu -eq 2){
    if(-not($url)){
        geturl
    }
    clear-host
    write-host "URL: $url"
    write-host "Downloading your video in the best quality available" -ForegroundColor Cyan
    yt-dlp -S ext:mp4:m4a -o '/sdcard/Download/patatatube/%(title)s.%(ext)s' $url
    write-host "Download successfully finished" -ForegroundColor Green
    exit
}
elseif($menu -eq 3){
    write-host ""
    Write-host "Updating PatataTube..." -ForegroundColor Yellow
    write-host ""
    Remove-Item patatatube-power.ps1
    Invoke-WebRequest -uri "https://raw.githubusercontent.com/pokeinalover/PatataTube/main/patatatube-power.ps1" -OutFile patatatube-power.ps1
    write-host "Patatatube was successfully updated" -ForegroundColor Green
    exit
}
elseif($menu -eq 4){
    write-host ""
    write-host "About PatataTube $ver" -ForegroundColor Magenta
    write-host "Made by pokeinalover and with ContratopDev's help because i'm still learning"
    write-host "  (Mostly him but he's a great teacher)"
    write-host "Stay tuned for more content and stuff on my web page!" 
    write-host "pokeinalover.github.io" 
    Pause
}
elseif($menu -eq 5){
    clear-host
    write-host "Exiting patatatube..." -ForegroundColor Cyan
    exit
}
elseif($menu -eq "more"){
    Clear-Host
    Write-host "Advanced menu" -ForegroundColor Cyan
    write-host ""
    Write-host "[repair] Repair Patatatube Power"
    Write-host "[debugupdate] Update from github/contratop"
    Write-host "[downssh] Download the content and senc (local) to your SSH (UNESTABLE)"
    write-host "[AnyPrompt] Previous menu"
    $menu2 = read-host "Write your option"
    if($menu2 -eq "repair"){
        clear-host
        write-host "Hey there! You! ...Yeah you!" -ForegroundColor Magenta 
        write-host "If you're here it's because patatatube needs repairs" -ForegroundColor Magenta 
        write-host "Send your feedback to github.com/pokeinalover" -ForegroundColor Magenta 
        write-host ""
        Write-Warning "When repairing, patatatube and dependencies will be reinstalled"
        $continue = read-host "Continue the reapairs? [continue]"
        if($continue -eq "continue"){
            write-host "Repairing Patatatube..."
            write-host ""
            write-host "Reinstalling dependencies..."
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
            write-host "Repairs are completed" -ForegroundColor Green
            exit
        }
        else{
           write-host "Task cancelled" -ForegroundColor Yellow
           Start-Sleep -s 1
        }
    }
    #####################################################
    elseif($menu2 -eq "downssh"){
        Clear-Host
        Write-Warning "This function is still experimentall"
        Write-host "If you ended up here by accident, please get out with Control + C"
        Write-host "Only compatible with SSH Windows for the moment"
        ""
        Write-host "Only individual content, NO PLAYLIST" -ForegroundColor Yellow
        ""
        write-host "[1] Music"
        write-host "[2] Video"
        $optionsshdown = read-host "Pick an option"
        if($optionsshdown -eq 1){
            if(-not($url)){
                geturl
            }
            $userssh = read-host "SSH usser"
            $ipssh = read-host "IP direction of the destination for the content"
            $archivename = read-host "File name"
            clear-host
            write-host "URL: $url"
            write-host "Usser destination: $userssh"
            write-host "IP Destination: $ipssh"
            write-host "File name: $archivename.mp3" 
            write-host ""
            write-host "Downloading MP3..." -ForegroundColor Cyan
            yt-dlp -o "$archivename.%(ext)s" --extract-audio --audio-format mp3 $url
            write-host ""
            write-host "Downloaded successfully" -ForegroundColor Cyan
            ""
            write-host "Attempting to send file to destination..."
            scp "$archivename.mp3" $userssh@$ipssh':Desktop'
            Remove-Item "$archivename.mp3"
            write-host "Successfully delivered"
            exit
        }
        elseif($optionsshdown -eq 2){
            if(-not($url)){
                geturl
            }
            $userssh = read-host "SSH usser"
            $ipssh = read-host "IP direction of the destination for the content"
            $archivename = read-host "File name"
            clear-host
            write-host "URL: $url"
            write-host "Usser destination: $userssh"
            write-host "IP Destination: $ipssh"
            write-host "File name: $archivename.mp4" 
            write-host ""
            write-host "Downloading your video in the best quality available" -ForegroundColor Cyan
            yt-dlp -S ext:mp4:m4a -o "$archivename.%(ext)s" $url
            write-host ""
            write-host "Downloaded successfully" -ForegroundColor Cyan
            ""
            write-host "Attempting to send file to destination..."
            scp "$archivename.mp4" $userssh@$ipssh':Desktop'
            Remove-Item "$archivename.mp4"
            if(test-path entrega.m4a){
                Remove-Item "$archivename.m4a"
            }
            write-host "Successfully delivered"
            exit
        }
        else{
            Write-Warning "We apologizze, but this is not an option that's suported"
            exit
        }
    }
    ####################################################
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
    write-host "Obtaining format list..." -ForegroundColor Cyan
    yt-dlp -F $url
    write-host ""
    write-host "If you see any errors, please write [back]" -ForegroundColor Yellow
    write-host "You can also [best] for the best option available" -ForegroundColor Cyan
    $fcode = read-host "Select your format"
    if($fcode -eq "back"){
        write-host "Reversing changes..."
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
        write-host "Destination: /sdcard/Download/patatatube"
        write-host "Downloading content..." -ForegroundColor Cyan
        yt-dlp -o '/sdcard/Download/patatatube/%(title)s.%(ext)s' -f $fcode $url
        write-host ""
        write-host "Downloaded successfully" -ForegroundColor Cyan
        exit
    }
}
else{
    Write-Warning "Not a valid option"
    start-sleep -s 1
}

}


## CONTINUAR POR AQUI

