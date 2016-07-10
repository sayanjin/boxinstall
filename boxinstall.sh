#!/bin/bash
# boxinstall.sh - postinstall d'openbox
# pour un environnement fonctionnel
#version 07
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
	
#function boxy (){
#	get xorg
#	get openbox
#	mkdir /etc/skel/.config
#	cp -rf /etc/xdg/openbox /etc/skel/.config/openbox
#	mkdir /root/.config
#	cp -rf /etc/xdg/openbox /root/.config/openbox

function boxy (){
	get xorg
	get openbox
	wget https://raw.githubusercontent.com/sayanjin/boxinstall/master/menu.xml --no-check-certificate
	cp -rf menu.xml /etc/xdg/openbox/
	mkdir /etc/skel/.config
	cp -rf /etc/xdg/openbox /etc/skel/.config/
	mkdir /root/.config
	cp -rf /etc/xdg/openbox /root/.config/
	get obconf
	get alsa-utils
	
}

  # Install lxdm
  function lxdm (){
    get lxdm
    sed -i "s/id:3:initdefault:/id:4:initdefault:/1" /etc/inittab*
  }
  
  
  ## Install startx
  #function stax (){
    echo openbox-session > ~/.xinitrc
    cp ~/.xinitrc /etc/skel
  #}
  
  # Install Autostartx
  function star (){
    wget https://raw.githubusercontent.com/sayanjin/boxinstall/devel/profile
    cd /etc/skel/
    mv .profile .profile-backup
    mv /root/profile /etc/skel/.profile
  }
  
  # Install Autologin + Autostartx
  function auto (){
    # Autologin
    wget https://raw.githubusercontent.com/sayanjin/boxinstall/devel/autologin
    #cd $BROOT/sbin/
    sed -e "s/user/$USER/g" autologin > autologin.tmp && mv autologin.tmp autologin
    chmod +x autologin
    mv autologin /usr/sbin/
    cd /etc/
    cp inittab inittab-backup
    sed -e "s:38400 tty1:-n -l /usr/sbin/autologin 38400 tty1:g" inittab > inittab.tmp && mv inittab.tmp inittab
    # Autostartx
    stax # function
  }
  
   # Install Thunar
  function thun (){
	get tango-icon-theme
    get tango-icon-theme-extras
    get gnome-icon-theme
    get thunar 
    get thunar-volman
    get thunar-archive-plugin
    get gvfs 
   # possibilte d'ajouter les liens dns le menu d'openbox 
   # et de modifier le theme selon
  }
  
  #install pcmanfm 
   function pcfm (){
      get pcmanfm
      get gvfs 
}

  #wbar
  function wbar (){
	  get wbar
	  sed -i '$a\\ wbar &' /etc/skel/.config/openbox/autostart
      sed -i '$a\\ wbar &' /root/.config/openbox/autostart
}
  #obmenu
  function menu (){
	  get obmenu
	  get python-gtk
}

  #numlockx
  function numl (){
	  get numlockx
	  sed -i '$a\\ numlockx &' /etc/skel/.config/openbox/autostart
      sed -i '$a\\ numlockx &' /root/.config/openbox/autostart
	  
}

  #conky
  function conk (){
	  get conky
	  sed -i '$a\\ conky &' /etc/skel/.config/openbox/autostart
      sed -i '$a\\ conky &' /root/.config/openbox/autostart
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

  #filezilla
  function filz (){
	  get filezilla
}

#transmission
  function trsm (){
	  get transmission
}

#pidgin
  function pidg (){
	  get pidgin
}

  #htop
  function htop () {
	  get htop
}

  #gimp
  function gimp (){
	  get gimp
}

  #tint2
  function tint (){
	  get tint2
	  sed -i '$a\\ tint2 &' /etc/skel/.config/openbox/autostart
          sed -i '$a\\ tint2 &' /root/.config/openbox/autostart
}

#lxde-panel
  function lxdp (){
	  get lxde-panel
	  sed -i '$a\\ lxpanel &' /etc/skel/.config/openbox/autostart
          sed -i '$a\\ lxpanel &' /root/.config/openbox/autostart
}

#avidemux
  function avid () {
	  get avidemux
}

#avidemux
  function hnbk () {
	  get handbrake
}

#rhythmbox
  function rtbx () {
	  get rhythmbox
}

  #mplayer
  function mpla () {
	  get mplayer
}

  #vlcl
  function vlcl () {
	  get vlc
}

#user
  function user () {
	  nu
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
  --ok-label "Valider" --cancel-label "Passer" \
  --radiolist "Veuillez choisir le mode de connexion à votre session.\nSélection avec la barre d'espace." 20 70 3 \
  "lxdm" "lxdm, gestionnaire de connexion graphique" on \
  "auto" "autologin sans user ni mdp" off \
  "star" "Auto startx après un login texte sur le TTY1" off \
  "stax" "startx lance openbox apres login" off 2> "${INPUT}"
  
CONNEXION=$(<"${INPUT}")
  
  case $CONNEXION in
  lxdm) lxdm ;;
  auto) auto;;
  satr) star;;
  stax) stax ;;
  esac
  
  CONNEXION=$(<"${INPUT}")
  
  # Install File Manager
  dialog --backtitle "postconfiguration openbox" --title "Gestionnaire de fichiers" \
  --ok-label "Valider" --cancel-label "Passer" \
  --radiolist "Installation de votre gestionnaire de fichiers préféré.\nSélection avec la barre d'espace." 20 70 2 \
  "thun" "Thunar, avec theme tango"  on \
  "pcfm" "pcmanfm en test" off 2> "${INPUT}" 
  
  FILEMANAGER=$(<"${INPUT}")
  
  case $FILEMANAGER in
  thun) thun ;;
  pcfm) pcfm ;;
  esac
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "tools et menu bureau" \
  --ok-label "Valider" --cancel-label "Passer" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "wbar" "barre d'applications (seulement en 32bits)" off \
  "numl" "numlockx permet d'activer en auto le padlock grandement recommandé sur pc fixe" on \
  "menu" "obmenu gui pour gerer le menu openbox" on \
  "tint" "tint2 barre de tache" on \
  "lxdp" "lxde panel" off\
  "conk" "conky moniteur system" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "wbar") wbar ;;
  "numl") numl ;; 
  "menu") menu ;;
  "tint") tint ;;
  "lxdp") lxdp ;;
  "conk") conk ;;
  esac
  done
 
  # Install utilitaire de conf
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "Choix log internet" \
  --ok-label "Valider" --cancel-label "Passer" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "fire" "firefox naviguateur net" off \
  "chro" "chromium nav internet" off \
  "mido" "midori nav internet" off \
  "pidg" "pidgin messagerie multiprotocol" off \
  "trsm" "transmission client torrent" off \
  "filz" "filezilla client FTP" off 2> "${INPUT}"
    
  # traitement de la réponse
  for i in $(<"${INPUT}")
  do
  case $i in
  "fire") fire ;;
  "chro") chro ;;
  "mido") mido ;;
  "pidg") pidg ;;
  "filz") filz ;;
  "trsm") trsm ;;
  esac
  done
  
  # --checklist texte hauteur largeur hauteur-de-liste [ marqueur1 item1 état] ...
  dialog --backtitle "postconfiguration openbox" --title "Choix des applications" \
  --ok-label "Valider" --cancel-label "Passer" \
  --checklist "Cochez vos applications préférées avec la barre d'espace." 20 70 15 \
  "leaf" "Leafpad, éditeur de texte " off \
  "gean" "geany editeur de txte " on \
  "abiw" "abiword editeur " on \
  "gnum" "gnumeric tableur " off \
  "xpdf" "Xpdf, suite d'outils pour PDF " off \
  "gimp" "editeur dessin" off \
  "htop" "gestionnaire de taches" on \
  "avid" "avidemux logiciel de video (qt-gui)" off\
  "hnbk" "handbrake logiciel de video (qt-gui)" off\
  "rtbx" "rhytmbox player de music " off\
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
  "gimp") gimp ;;
  "htop") htop ;;
  "avid") avid ;;
  "hnbk") hnbk ;;
  "rtbx") rtbx ;;
  "mpla") mpla ;;
  "vlcl") vlcl ;;
  esac
  done
  
  # Install new user
  dialog --backtitle "postconfiguration openbox" --title "nouvel utilisateur" \
  --ok-label "Valider" --cancel-label "Passer" \
  --radiolist "creer un nouvel user.\nSélection avec la barre d'espace." 20 70 2 \
  "user" "creer un utilisateur non root"  on \
  "Exit" "quitter l'installation" off 2> "${INPUT}" 
  
  NEWUSER=$(<"${INPUT}")
  
  case $NEWUSER in
  user) user ; echo "Fin de la configuration"; break ;;
  Exit) echo "Bye"; break;;
  esac
  done
 
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
