#!/bin/bash
# boxinstall.sh - postinstall d'openbox
# pour un environnement fonctionnel
#version 03
DIALOG={DIALOG=dialog}
INPUT=/tmp/menu.sh.$$
 
# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$
 

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM
 
#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function display_output(){
	local h=${1-10}			# box height default 10
	local w=${2-41} 		# box width default 41
	local t=${3-Output} 	# box title 
	dialog --backtitle "postconfiguration openbox" --title "${t}" --clear --msgbox "$(<$OUTPUT)" ${h} ${w}
}
#
# Purpose - display current system date & time
#
	
function boxy (){
	get xorg
	get openbox
	mkdir /etc/skel/.config
	cp -rf /etc/xdg/openbox /etc/skel/.config/openbox
	mkdir /root/.config
	cp -rf /root/.config/openbox
	
}

  # Install lxdm
  function lxdm (){
    get lxdm
    sed -i "s/id:3:initdefault:/id:4:initdefault:/1" /etc/inittab*
  }
  
  
  ## Install startx
  #function stax (){
    echo openbox > ~/.xinitrc
    cp ~/.xinitrc /etc/skel
  #}
  
   # Install Thunar
  function thun (){
	get tango-icon-theme
    get tango-icon-theme-extras
    get thunar 
    get thunar-volman 
    get gvfs 
   # possibilte d'ajouter les liens dns le menu d'openbox 
   # et de modifier le theme selon
  }
  
  # Install PCMan File Manager
  function pcma (){
    get pcmanfm
   # possibilte d'ajouter les liens dns le menu d'openbox 
   # et de modifier le theme selon
  }
  
  #leafpad
  function leaf (){
	  get leafpad
}

  #geany
  function gean (){
	  get geany
}

  #abiword
  function abiw () {
	  get abiword
}

  #gnumeric
  function gnum () {
	  get gnumeric
}

  #xpdf
  function xpdf () {
	  get xpdf
}

  #firefox
  function fire (){
	  get firefox
}

  #chromium
  function chro (){
	  get chromium
}

  #midori
  function mido (){
	  get midori
}

  #rox-filer
  function roxf (){
	  get rox-filer
}

  #tint2
  function tint (){
	  get tint2
	  echo tint2 & >> /etc/skel/.config/openbox/autostart
          echo tint2 & >> /root/.config/openbox/autostart
}

  #conky
  function conk (){
	  get conky
}

  #mplayer
  function mpla () {
	  get mplayer
}

  #vlcl
  function vlcl () {
	  get vlc
}



#
# set infinite loop
#
while true
do
 
### display main menu ###
###ßûæ omg l'anti slash collé au commentaire fait bugguer le truc###
dialog --clear  --help-button --backtitle "postconfiguration openbox" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
instal "xorg openbox +startx" \
Exit "Exit to the shell" 2>"${INPUT}"
 
menuitem=$(<"${INPUT}")
 
 
# make decsion 
case $menuitem in
	instal) boxy;;
	Exit) echo "Bye"; break;;
esac
 
 # Install Login
  dialog --backtitle "postconfiguration openbox" --title "Session" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --radiolist "Veuillez choisir le mode de connexion à votre session.\nSélection avec la barre d'espace." 20 70 3 \
  "lxdm" "lxdm, gestionnaire de connexion graphique" on \
  "stax" "startx lance openbox apres login" off 2> "${INPUT}"
  
CONNEXION=$(<"${INPUT}")
  
  case $CONNEXION in
  lxdm) lxdm ;;
  stax) stax ;;
  esac
  
  CONNEXION=$(<"${INPUT}")
  
  # Install File Manager
  dialog --backtitle "postconfiguration openbox" --title "Gestionnaire de fichiers" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --radiolist "Installation de votre gestionnaire de fichiers préféré.\nSélection avec la barre d'espace." 20 70 2 \
  "thun" "Thunar, avec theme tango" on \
  "pcma" "PCman FM, navigateur de fichiers avec onglets" off 2> "${INPUT}"
  
  FILEMANAGER=$(<"${INPUT}")
  
  case $FILEMANAGER in
  thun) thun ;;
  pcma) pcma ;;
  esac
 
  # Install Apps
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "Choix des applications" \
  --ok-label "Valider" --cancel-label "Quitter" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "leaf" "Leafpad, éditeur de texte " off \
  "gean" "geany editeur de txte " on \
  "abiw" "abiword editeur " on \
  "gnum" "gnumeric tableur " off \
  "xpdf" "Xpdf, suite d'outils pour PDF " off \
  "fire" "firefox naviguateur net" off \
  "chro" "chromium nav internet" off \
  "mido" "midori nav internet" off \
  "roxf" "rox-filler pour les archives" on \
  "tint" "tint2 barre de tache" on \
  "conk" "conky moniteur system" on \
  "mpla" "GNOME MPlayer, lecteur multimédia " on \
  "vlcl" "VLC, lecteur multimédia" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "leaf") leaf ;;
  "gean") gean ;;
  "abiw") abiw ;;
  "gnum") gnum ;;
  "xpdf") xpdf ;;
  "fire") fire ;;
  "chro") chro ;;
  "mido") mido ;;
  "roxf") roxf ;;
  "tint") tint ;;
  "conk") conk ;;
  "mpla") mpla ;;
  "vlcl") vlcl ;;
  esac
  done
  
done
 
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
