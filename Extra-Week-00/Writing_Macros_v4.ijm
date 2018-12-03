/** 
 * Writing Macros
 * ----------------------------------------------
 * 
 * This short macro showcases different ways to use variable (string and number), arrays, for loop, functions
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// getInfo about the image
imageTitle = getTitle();
getDimensions(imageWidth, imageHeight, imageChannels, imageSlices, imageFrames);

// set Parameters 
luts     = getList("LUTs"); //here we retrieve the list of LUT
min_vals = newArray(0, 0, 0);
max_vals = newArray(170, 130, 255);

// change LUT and BC for rach channels
for(i=0; i < imageChannels; i++) {
	setLUTandBC(i+1 , luts[i+5] , min_vals[i] , max_vals[i] );
}
// show all the channels at once
run("Make Composite");

// here a function that set the channel, the LUT 
// and the min and Max values for BrightnessContrast
function setLUTandBC( ch ,lut, min, Max){
	// so we use Stack.setChannel(), instead of setSlice()  (to avoid issue with z-stack).
	Stack.setChannel( ch );
	run( lut );
	setMinAndMax( min, Max);
}
