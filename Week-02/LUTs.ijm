/** 
 * Lookup Tables (LUTs)
 * ----------------------------------------------
 * 
 * This short macro showcases different way to use the Lookup Tables, the while loop, the window dialog getBoolean() 
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */


run("Close All");
print ("\\Clear");

run("Display LUTs");
waitForUser("The function 'Display LUTs' open an image with all the LUT installed");
selectImage(nImages);
close();

run("Blobs (25K)");
waitForUser("Now we open 'Blobs' and we'll go though LUTs to change the display of the Image.");
blod_id = getImageID();
listLUT = getList("LUTs");

// we'll go though the array 'listLUT'  to change the display of the Image
i = 0;
showNextLUT = true ;
while ( showNextLUT ) {
	// we chekc that the index is ine the range of the array
	if (i < lengthOf(listLUT) ) {
		// we make sure to select the right image
		selectImage(blod_id);
		// and change the LUT
		run(listLUT[i]);
		
		// Ask the user if we show the next LUT, with a Dialog Window
		// Yes or No (and Cancel)
		showNextLUT = getBoolean("The current LUT is : "+listLUT[i]+".\n Do you want to show the next Lookup Table ? ");
		// if the user clic on Yes, we increment the index i
		if ( showNextLUT ) i++;
		// if the user clic on No, we print the LUT selected
		else print ("Selected LUT is "+listLUT[i] );
		
	} else {
		// exit
		showNextLUT = false
	}
}
selectWindow("Log");