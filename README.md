# readme
en cours de redaction: 

posinstall openbox pour nutyx
tres inspiré du script bee ( http://bee.saverne.info/ )
permet d'installer xorg avec openbox

copie les fichiers de config dans /etc/skel pour les futurs creation de nouvel user afin de ne pas toucher aux fichiers
de bases se trouvant dans /etc/xdg/openbox

permet de choisir entre le demarrage de la session openbox
  soit par l'installation de lxdm (initab doit etre modifié selon)
  soit par un startx apres le login (ne concerne pour l'instant que l'user ou vous lancer le bash)
  
choix de logiciel de base supplementaire a installer:

gestionnaire de fichiers, tel 
  thunar avec le theme d'icone deja preconfiguré (Tango) , volman et gvfs
  pcmanfm
  
barre de tach tint2 en autostart
  
choix d'autre log de base a installer

Installation:
(apres l'install de base de nutyx, en restant en root, NE CRRER PAS DE NEW USER AVANT LE SCRIPT)

get wget

wget https://raw.githubusercontent.com/sayanjin/boxinstall/master/boxinstall.sh --no-check-certificate

. boxinstall.sh


