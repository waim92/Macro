run("Open...");
setTool("line");
waitForUser("Tracer la ligne");
run("Measure");
Dialog.create("calcul");
Dialog.addMessage("Nombre sur la photo?");
Dialog.addNumber("nbr:", 0);
Dialog.addMessage("Nombre mesure?");
Dialog.addNumber("nbr:", 0);
Dialog.show();
Echelle=Dialog.getNumber();
Measure=Dialog.getNumber();
//print("Echelle="+Echelle);
//print("Measure="+Measure);
Rep = Echelle/Measure;
//Rep = parseFloat(Rep);
Dialog.create("calcul");
Dialog.addMessage("1 pixel =" +Rep+ "unite");
Dialog.show();
//print(Rep);
	//calcul de la taille relatie de l'objet
//Dialog.create("Taille de l'objet");
Dialog.addMessage("Quelle est la taille de l'objet d'interet?");
Dialog.addNumber("Taille:", 0);
Dialog.show();
Taille=Dialog.getNumber();
NewTaille=Taille/Rep;
print("taille"+Taille);
print("new"+NewTaille);
Dialog.addMessage("L'objet mesure" +NewTaille+ "Pixel");
Dialog.show();

waitForUser("r");
