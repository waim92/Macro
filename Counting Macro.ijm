	//Debut
	Dialog.create("Quel process voulez vous lancer?");
	Dialog.addMessage("process 1, modification sequentielle des images	");
	Dialog.addMessage("process 2, analyses des images					");
	Dialog.addMessage("process 1bis, modification multithread			");
	Choix = newArray("Process 1: Counting", "Process 2: Co-staning","Batching");
	Dialog.addChoice("Choix:",Choix);
	Dialog.show();
	rep=Dialog.getChoice();

	// PROCESS 1
	if(rep == "Process 1: Counting")
	{
		//Calcul de l'echelle
		Dialog.create("Calculate scale?");
		Dialog.addMessage("	1 = YES, 0 = NO			");
		Choix = newArray("Non", "yes");
		Dialog.addChoice("Choix:",Choix);
		Dialog.show();
		rep=Dialog.getChoice();
		if(rep == "Oui"){runMacro("echelle.ijm");}

		//range
		Dialog.create("Enter size range");
		Dialog.addMessage("	1 = YES, 0 = NO			");
		Choix = newArray("Oui", "Non");
		Dialog.addChoice("Choix:",Choix);
		Dialog.show();
		rep=Dialog.getChoice();
		if(rep == "Oui"){
			Dialog.create("Size?");
			Dialog.addMessage("Minimum/Maximum:");
			Dialog.addNumber("Minimum:", 400);				// modifier ici les valeurs par defauts du seuil de size
			Dialog.addNumber("Maximum:", 4000);				//
			Dialog.addNumber("Pixel (1=YES, 0=NO):", 1);
			Dialog.addMessage("Circularity?");
			Dialog.addNumber("Minimum:", 0);
			Dialog.addNumber("Maximum:", 1);
			Dialog.show();
			Min=Dialog.getNumber();
			Max=Dialog.getNumber();
			Pix=Dialog.getNumber();
			CirMin=Dialog.getNumber();
			CirMax=Dialog.getNumber();
			}

		path2=getDirectory("destination folder");
		myFolder=getDirectory("Origin folder");

		// Debut traitement
		Dialog.create("Start");
		Dialog.addMessage("How many image?");
		Dialog.addNumber("Number:", 2);
		Dialog.show();
		Ans=Dialog.getNumber();
		for(i=0;i<Ans;i++){						//Boucle de traitement
			open("");
			name=getTitle();
			run("Brightness/Contrast...");
			waitForUser("Select brightness/Contrast");

			run("Apply LUT");
			setAutoThreshold("Intermodes dark");	//mode de threshold
			run("Threshold...");
			waitForUser("Select threshold");
			setOption("BlackBackground", true);
			run("Convert to Mask");

			Mini=Min;							//Buffer size
			Maxi=Max;
			CirMini=CirMin;
			CirMaxi=CirMax;

			//range
			Dialog.create("Change previous settings?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				Dialog.create("size");
				Dialog.addMessage("Minimum/Maximum:			");
				Dialog.addNumber("Minimum:", 200);
				Dialog.addNumber("Maximum:", 3000);
				Dialog.addNumber("Pixel (1=YES, 0=NO):", 1);
				Dialog.addMessage("Circularity?");
				Dialog.addNumber("Minimum:", 0);
				Dialog.addNumber("Maximum:", 1);
				Dialog.show();
				Min=Dialog.getNumber();
				Max=Dialog.getNumber();
				Pix=Dialog.getNumber();
				CirMin=Dialog.getNumber();
				CirMax=Dialog.getNumber();

				}

			//Fill holes
			Dialog.create("Fill holes?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Oui", "Non");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){run("Fill Holes");}

			//Advanced treatment
			Dialog.create("complexe?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				run("Dilate");
				run("Fill Holes");
				run("Erode");
				}

			//Watershed
			Dialog.create("Watershed?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){run("Watershed");}

			//Creation de mask
			Dialog.create("Mask?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				setTool("freehand");
				waitForUser("Selection ROI");
				setBackgroundColor(0,0,0);
				run("Clear Outside");
				run("Create Mask");
				saveAs("tiff", path2+"mask");
				close();
				}

			//Apply a mask
			Dialog.create("Apply a mask?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				open("");
				t1=getTitle;
				imageCalculator("AND create",t1,name);
				}

		saveAs("tiff", path2+name);

		//analyze particles, parametres
		if(Pix==1)
		{run("Analyze Particles...", "size=&Min-&Max pixel circularity=&CirMin-&CirMax display include add");}
		if(Pix==0)
		{run("Analyze Particles...", "size=&Min-&Max circularity=&CirMin-&CirMax display include add");}

		Min=Mini;
		Max=Maxi;
		CirMin=CirMini;
		CirMax=CirMaxi;

		selectWindow("Results");
		//saveAs("results", path2+name+" Results");				// a mettre en comm pour enlever la sav des resultats
		waitForUser("Click to next step");

		run("Close All");
		roiManager("Save", path2+name+" ROI Manager.zip");		// a mettre en comm pour enlever la sav du ROI data
		roiManager("Delete");
		run("Clear Results");

	}
	Dialog.create("Analysis over");
	Dialog.addMessage("Il n'y a plus d'image :) ");
	Dialog.show();

			}
		// batching

		if(rep == "Batching")
		{

			//Calcul de l'echelle
			Dialog.create("Calculer l'echelle?");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Non", "Oui");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){runMacro("echelle.ijm");}

			//range
			Dialog.create("Enter your size range");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Oui", "Non");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				Dialog.create("Calculer l'echelle?");
				Dialog.addMessage("Minimum/Maximum:");
				Dialog.addNumber("Minimum:", 100);
				Dialog.addNumber("Maximum:", 3000);
				Dialog.addNumber("Pixel (1=YES, 0=NO):", 1);
				Dialog.addMessage("Circularity?");
				Dialog.addNumber("Minimum:", 0);
				Dialog.addNumber("Maximum:", 1);
				Dialog.show();
				Min=Dialog.getNumber();
				Max=Dialog.getNumber();
				Pix=Dialog.getNumber();
				CirMin=Dialog.getNumber();
				CirMax=Dialog.getNumber();
				}
			path2=getDirectory("Destination folder");
			myFolder=getDirectory("Origin folder");


			Dialog.create("Debut");
			Dialog.addMessage("How many image?");
			Dialog.addNumber("nbr:", 0);
			Dialog.show();
			Ans=Dialog.getNumber();
			for(i=0;i<Ans;i++){
				open("");
				name=getTitle();
				run("Brightness/Contrast...");
				waitForUser("Select brightness/Contrast");

				run("Apply LUT");
				setAutoThreshold("Intermodes dark");
				run("Threshold...");
				waitForUser("Select threshold");
				setOption("BlackBackground", true);
				run("Convert to Mask");

				Mini=Min;
				Maxi=Max;
				CirMini=CirMin;
				CirMaxi=CirMax;

					rows = 6;
					columns = 1;
					n = rows*columns;
					labels = newArray(n);
					labels[0] = "range			";
					labels[1] = "Fill holes			";
					labels[2] = "Advanced treatment	";
					labels[3] = "Watershed			";
					labels[4] = "Creation de mask		";
					labels[5] = "Apply a mask	";

					defaults = newArray(n);
					defaults[0] = false;
					defaults[1] = false;
					defaults[2] = false;
					defaults[3] = false;
					defaults[4] = false;
					defaults[5] = false;

					bufferTab = newArray(n);
					bufferTab[0] = false;
					bufferTab[1] = false;
					bufferTab[2] = false;
					bufferTab[3] = false;
					bufferTab[4] = false;
					bufferTab[5] = false;

					Dialog.create("Check your analyse details");
					Dialog.addCheckboxGroup(rows,columns,labels,defaults);
					Dialog.show();

					bufferTab[0]=Dialog.getCheckbox();
					bufferTab[1]=Dialog.getCheckbox();
					bufferTab[2]=Dialog.getCheckbox();
					bufferTab[3]=Dialog.getCheckbox();
					bufferTab[4]=Dialog.getCheckbox();
					bufferTab[5]=Dialog.getCheckbox();

					for(j=0;j<6;j++)
					{
						if(j == 0 && bufferTab[0]== true) {Dialog.create("size?");
							Dialog.addMessage("Minimum/Maximum:");
							Dialog.addNumber("Minimum:", 10);
							Dialog.addNumber("Maximum:", 100);
							Dialog.addNumber("Pixel (1=YES, 0=NO):", 1);
							Dialog.addMessage("Circularity?");
							Dialog.addNumber("Minimum:", 0.4);
							Dialog.addNumber("Maximum:", 1);
							Dialog.show();
							Min=Dialog.getNumber();
							Max=Dialog.getNumber();
							Pix=Dialog.getNumber();
							CirMin=Dialog.getNumber();
							CirMax=Dialog.getNumber();
							}
						if(j == 1 && bufferTab[1]== true) {run("Fill Holes");}
						if(j == 2 && bufferTab[2]== true) {run("Dilate");
							run("Fill Holes");
							run("Erode");}
						if(j == 3 && bufferTab[3]== true) {run("Watershed");}
						if(j == 4 && bufferTab[4]== true) {setTool("freehand");
							waitForUser("Selection ROI");
							setBackgroundColor(0,0,0);
							run("Clear Outside");
							run("Create Mask");
							saveAs("tiff", path2+"mask");
							close();
							waitForUser("ok");}
						if(j == 5 && bufferTab[5] == true) {
							waitForUser("ca marche pas");
							open("");
							t1=getTitle;
							imageCalculator("AND create",t1,name);}
					}


		saveAs("tiff", path2+name);

		//analyze particles
		if(Pix==1)
		{run("Analyze Particles...", "size=&Min-&Max pixel circularity=&CirMin-&CirMax display include add");}
		if(Pix==0)
		{run("Analyze Particles...", "size=&Min-&Max circularity=&CirMin-&CirMax display include add");}

		Min=Mini;
		Max=Maxi;
		CirMin=CirMini;
		CirMax=CirMaxi;

		selectWindow("Results");
		//saveAs("results", path2+name+" Results");			// a mettre en comm pour enlever la sav des resultats
		waitForUser("Click to next step");

		run("Close All");
		roiManager("Save", path2+name+" ROI Manager.zip"); // a mettre en comm pour enlever la sav des resultats
		roiManager("Delete");
		run("Clear Results");

		}
	Dialog.create("Analysis over");
	Dialog.addMessage("Il n'y a plus d'image :) ");
	Dialog.show();
		}

		// PROCESS 2
		if(rep == "Process 2: Co-staning")
		{
			Dialog.create("Enter your size range");
			Dialog.addMessage("	1 = YES, 0 = NO			");
			Choix = newArray("Oui", "Non");
			Dialog.addChoice("Choix:",Choix);
			Dialog.show();
			rep=Dialog.getChoice();
			if(rep == "Oui"){
				Dialog.create("range?");
				Dialog.addMessage("Minimum/Maximum:");
				Dialog.addNumber("Minimum:", 200);
				Dialog.addNumber("Maximum:", 2000);
				Dialog.addNumber("Pixel (1=YES, 0=NO):", 1);
				Dialog.addMessage("Circularity?");
				Dialog.addNumber("Minimum:", 0);
				Dialog.addNumber("Maximum:", 1);
				Dialog.show();
				Min=Dialog.getNumber();
				Max=Dialog.getNumber();
				Pix=Dialog.getNumber();
				CirMin=Dialog.getNumber();
				CirMax=Dialog.getNumber();
				}

			path3=getDirectory("Destination folder");
			Dialog.create("Analysis");

			Dialog.addMessage("How many image?");
			Dialog.addNumber("nbr:", 2);
			Dialog.show();
			repp=Dialog.getNumber();
			for(j=1;j<repp;j++){
				open("");
				title1=getTitle;
				dotIndex=indexOf(title1, ".");
				img1 = substring(title1, 0, dotIndex);
				open("");
				title2=getTitle;
				dotIndex=indexOf(title2, ".");
				img2 = substring(title2, 0, dotIndex);

				//imagecalculator
				imageCalculator("AND create",title1,title2);
				//saveAs("results", path2+name+" Results");
				saveAs("tiff", path3+img1+" AND "+img2);
				//saveAs("tiff"): pour juste enregistrer et demander un nom a l'utilisateur
				//open("");
				waitForUser("Calcul...");

				//analyze particles
				if(Pix==1)
				{run("Analyze Particles...", "size=&Min-&Max pixel circularity=&CirMin-&CirMax display include add");}
				if(Pix==0)
				{run("Analyze Particles...", "size=&Min-&Max circularity=&CirMin-&CirMax display include add");}

				//verification
				Dialog.create("verif?");
				Dialog.addMessage("	1 = YES, 0 = NO			");
				Choix = newArray("Oui", "Non");
				Dialog.addChoice("Choix:",Choix);
				Dialog.show();
				rep=Dialog.getChoice();
				if(rep == "Oui"){
					Dialog.createNonBlocking("Calcul...")
					run("Merge Channels...", "c1=&title1 c2=&title2 create keep");
					roiManager("Show All");
					waitForUser("verification");
					}

				selectWindow("Results");
				//saveAs("results", path3+img1+" AND "+img2+" Results"); // a mettre en comm pour enlever la sav des resultats
				waitForUser("Click to next step");
				run("Close All");
				roiManager("Delete");
				run("Clear Results");
			}
			Dialog.create("Analysis over");
			Dialog.addMessage("Click OK to finish");
			Dialog.show();
		}

