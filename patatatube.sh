#Limpiar la pantalla
clear
#Comprobar si existe la carpeta STORAGE, sino, se cofigura solo el Termux
    if [ -d "$HOME/storage" ] 
    then
    clear
    sleep 1
    else
    clear
    echo "Termux didn't find a way to your internal storage (╥﹏╥)"
    echo "Please give Termux access to your internal storage so that you can download content (✿◠‿◠) "
    sleep 2
    termux-setup-storage
    fi
    
    
#Escribe algo de presentacion
    figlet patatatube
    echo ""
    echo "Patatatube, content downloader"
    echo "Version 0.9"
    echo "Made by a patata"
    echo "and with a little help-"
    sleep 1
# haz un menu rikolino
echo ""
echo "What are you going to do today?"
	PS3='Please enter your choice: '
options=("Download" "Update" "About" "Quit")
select opt in "${options[@]}"
do
    case $opt in






        "Download")



#Manda al usuario a su carpeta de Downloads
    cd storage/downloads
# Solicita la URL
    clear
    read -p "Please enter the URL so that we can start downloading your content （っ＾▿＾）: " url
    clear
	    PS3='Please choose your format: '
    options=("Music" "Another" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in

        "Music")
        echo "We are downloading your content"
        sleep 1
        youtube-dl -o '%(title)s.%(ext)s' --extract-audio --audio-format mp3 $url
        clear
        echo "Done! Enjoy your new song!(or that audio you downloaded for a prank or animatic xd)"
		exit
				
              ;;


           "Another")
           clear
           echo "Please choose your format (owo)"
           youtube-dl -F $url
           echo ""
           read -p "You may now write the format code: " fcode
           clear
           echo "We are now downloading your content"
           youtube-dl -o '%(title)s.%(ext)s' -f $fcode $url
           clear
           echo "Done! Enjoy your content! uwu"
           echo ""
           exit
            ;;

          "Quit")
	    	clear
              exit
              ;;
         *) echo "invalid option $REPLY";;
        esac
    done
################################

		
				
            ;;


          "Update")
    while true; do
    read -p "Do you want to update Patatatube? (y/n)" yn
    case $yn in
        [Yy]* ) 
        echo "We are working on the update, please wait ~(*-*)~"
        sleep 1
       cd $HOME
       pkg upgrade
       pkg install python3
       pkg install ffmpeg
       pip install youtube-dl
       apt install figlet toilet

       rm -f -r PatataTube
       git clone https://github.com/pokeinalover/PatataTube
       clear
       echo "Updated! You can keep downloading your content now! (✿◠‿◠) "
       echo ""
       exit

        
        ;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done






         ;;


        "About")
        echo "Made by pokeinalover and with ContratopDev's help because im still learning"
        echo "Stay tuned for more content and stuff on my web page!" 
        echo "pokeinalover.github.io"       
        read -n 1 -s -r -p "Press anything to go back xd"
        ;;
        "Quit")
		clear
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done






    
