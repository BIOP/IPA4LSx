/*
 * Simple example to normalize a stack based on each slice's
 * min and max intensities or mean intensity
 * 
 * Example data: Worm-Bad-Immumination.tif
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

run("Close All");
waitForUser("Please open the file Worm-Bad-Illumination.tif\nThen press OK");

// Getting the imasge title helps us rename the image neatly later on in the code
imageName = getTitle();

newMean = getNumber("Provide the new mean value that will be given to each slice of the stack", 10000);

// Get the siye of the stack through getDimensions()
getDimensions(x,y,c,z,t);

// Before performing any operation, we duplicate the image in order to avoid losing the original
// We also rename it, so we know what was done to it
run("Duplicate...", "duplicate title=["+imageName+"-Corrected]");

// Conversion to 32-bits is very important when performing mathematical operations
run("32-bit");

// We will now go through each timepoint and
for(i=1; i<t+1;i++) {

	// For each frame
	Stack.setFrame(i);
	
	// We get information on the mean, min and max intensities using getStatistics()
	getStatistics(area, mean, min, max);

	// This print to the log window is not necessary, but shows the user something is happening
	print(area, mean, min, max);
	
	// Formula: each pixel has a new value 
	// newVal = (val - min) / (max - min) * newMean
	
	run("Subtract...", "value="+min+" slice");
	run("Divide...", "value="+(max-min)+" slice");
	run("Multiply...", "value="+newMean+" slice");
}

// we ensure that the image is viewable
setMinAndMax(0, newMean*2);

// Second Method using only the mean of each slice
selectImage(imageName);
// We also rename it, so we know what was done to it
run("Duplicate...", "duplicate title=["+imageName+"-Corrected v2]");

// Conversion to 32-bits is very important when performing mathematical operations
run("32-bit");

// We will now go through each timepoint and
for(i=1; i<t+1;i++) {

	
	Stack.setFrame(i);
	
	getStatistics(area, mean, min, max);

	// This print to the log window is not necessary, but shows the user something is happening
	print(area, mean, min, max);
	
	// Formula: each pixel has a new value 
	// newVal = Val / mean * newMean
	
	run("Divide...", "value="+(mean)+" slice");
	run("Multiply...", "value="+newMean+" slice");
}
setMinAndMax(0, newMean*2);
run("Tile");

waitForUser("Observe the original and modified images and interpret what you see");