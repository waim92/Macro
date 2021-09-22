************************************************************************************
-Les fichiers sont a placer dans le repertoire "macros" de Fiji.
-Il est posible de creer un raccourcie clavier pour excecuter la macro. Dans 
Fiji Macros> Install Macros puis dans le fichier txt "StartupMacros.fiji" ajouter
		macro "process1 [F2]" {
			runMacro("process1");
		}
avec a la place de F2 la touche choisie pour le raccourcie.
-Toute les valeurs par defaut peuvent etre modifier directement dans la macro (macro>edit) en modifiant les valeurs
ou en mettant en commentaire une ligne (grace a // devant la ligne) pour pouvoir la reactiver plus tard.
-La performance de l'analyse depend tout d'abord de la qualité de l'acquisition de l'image, ensuite la précision 
du l'etape Contrast/Brightness et Threshold et pour terminer la finesse des fourchettes de tailles.
Developpe par William BITTON
**************************************************************************************
Prérequis: les photos doivent etre divisé en canaux en 8-bit (Image>Type), 
si l'image de base est en stack Image>Stacks>Stack to Image.
Je recommande de faire des dossiers distincts par batch de photos pour mieux s'organiser 
et ne pas perdre les photos originales (toujours travailler sur des copies). 


La premiere fenetre permet de choisir quel type de traitement la macro va lancer.
Process 1: 	Modification des images, necessaire pour les utiliser pour le traitement 2
		Modifications sequentielles, les unes apres les autres
Process 2: 	Analyse des images et creation des fusions d'images
Batch: 	Meme modification que Process1 mais le traitement ce fait en simultané
		en 1 tableau d'options

Contrast/Brightness et Threshold:
	Permet de regler les parametre de couleurs pour permettre une analyse la plus fine possible
	Au mieux: diminuer le bruit et faire ressortir les zones d'interets
	Etape tres importantes car tout le reste sera basé sur cette etape.

Calcul d'echelle:
	Permet de calculer un ratio unité/pixel grace a une ligne d'echelle sur la photo 
	(defaut:FALSE)

Fourchette:
	Permet d'entrer le minimum et le maximum de taille de l'analyse generale
	Possible de choisir en pixel ou en unité par defaut
	(defaut: 100-3000)

Input folder:
	Dossier d'origine qui s'ouvrira lors du choix des photos

Destination folder:
	Dossier ou les photos modifier et les resultats seront sauvegarder automatiquement

Actualisation de la fourchette:
	Permet d'actualiser la fourchette uniquement pour la photo en cours de traitement,
	utile pour les petits objects d'interets 
	(defaut: 10-100)

Fill holes:
	Permet de remplir les formes creuses, la trou doit etre etouré de pixel de meme valeurs 
	(defaut:TRUE)

Advanced traitment:
	Lance une analyse complexe composé de dilatation > fill holes > erode, permet d'affiner des amas de cellule
	(defaut:FALSE)

Watershed:
	Creer des separations dans certains amas, peut etre utilisé seul ou apres le traitement avancé pour affiner
	le traitement 
	(defaut: FALSE)

Creation de masque:
	Permet de delimiter une zone d'interet. le tracé a main levé est donné par defaut mais possibilité de selectionner
	d'autre outils (polygon tres utilisé pour des formes geometriques)
	le mask cree sera sauvegarder et utiliser directement sur la photo en cours de traitement
	(defaut:FALSE)

Appliquer un masque:
	Selectionner un mask prealablement creer (juste avant dans le meme dossier ou plusieurs semaine avant dans un dossier 
	different) et l'applique a la photo en cours de traitement
	(defaut: FALSE)

L'analyse particles s'effectue ensuite, prenant comme parametres (taille et unité) rentré au prealable pour le user
la circularité est par defaut a 0.05-1.00 et peut etre modifier directement dans la macro

La fenetre resultats est enregistré ainsi que le ROI manager data et la photo modifier. Il est posible d'annuler la sav
de l'un ou plusieurs en mettant les commentaires les lignes indiqué dans la macro. 


Process 2:

Fourchette:
	Permet d'entrer le minimum et le maximum de taille de l'analyse 
	possible de choisir en pixel ou en unité par defaut
	(defaut: 10-100)

Nombre de photos: 
	Pour les multimarquage, 1 canal = 1 photo donc si vous avez 4 canaux par photos il faudra multiplier le nombre
	de photos par 4

Image calculator:
	Permet de calculer les pixel etant présent sur la photo 1 ET la photo 2, recreant une photo resultante des points communs
	la photo sera par defaut enregistrer comme: NomPhoto1 AND NomPhoto2
	possibilité d'neregistrer avec un nom perso en modifiant la ligne adéquat dans la macro

L'analyse particles s'effectue ensuite, prenant comme parametres (taille et unité) rentré au prealable pour le user
la circularité est par defaut a 0.05-1.00 et peut etre modifier directement dans la macro

La fenetre resultats est enregistré ainsi que le ROI manager data et la photo modifier. Il est posible d'annuler la sav
de l'un ou plusieurs en mettant les commentaires les lignes indiqué dans la macro. 

Verification:
	Creer un merge des 2 photos utilisé au dessus et indique en couleurs les zones qui ont été compté dans l'analyse
	permet de verifier a l'oeil si les parametres sont bons
	(defaut:FALSE)
