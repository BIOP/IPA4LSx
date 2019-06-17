/** 
 * Array
 * ----------------------------------------------
 * 
 * This short macro showcases how to use arrays in ImageJ macro language
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// We start by closing all the images
run("Close All");
// and by clearing the log window.
print("\\Clear");

// We define a new array, with elements (here, possible LookUpTable names) separated by commas.
color_array = newArray( "Red", "Green", "Blue", "Gray", "Fire" );

// Opens "blobs.gif" 
run("Blobs (25K)");
// and get its ID (so we can re-select this image when needed)
blobs_id = getImageID();
// a comment in a dialog window.
print ("color_array : ");
// Prints the content of an array
Array.print(color_array);
// Select the log window
selectWindow("Log");
// Notifying user
waitForUser("We'll change the LookUp Table of the image to Red,\nusing the variables stored in the 'color_array'\n(you can have a look to the Log window)");

// Change the LUT
//
// make sure to select the image
selectImage(blobs_id);
// To Take the FIRST element , we use the index 0 
run(color_array[0]);

waitForUser("Now, we'll change the LookUp Table of the image to the last element of the 'color_array'");
// make sure to select the image
selectImage(blobs_id);
// To Take the Last element , we use the lengthOf(color_array)-1 (because indexes start at 0)
run(color_array[lengthOf(color_array)-1]);

// reorganize images on  screen
run("Tile");

print ("============================");
waitForUser("Next, we'll create a line on the image,\nand measure pixel values along that line");
//Here, we make the line to between defines coordinates makeLine(x1,y1,x2,y2)
makeLine(120, 30, 160, 85);
// store the measurements in an array variable, called 'lineProfile_array' 
lineProfile_array = getProfile();
// Print the content of this array to the Log window
print ("Intensity profile: ");
Array.print(lineProfile_array);
selectWindow("Log");

// You may have notice by now that to print array we can not use function print(...) 
// but we have to use Array.print(array) instead.
// There are other functions that you can use with the array (cf. https://imagej.net/ij/macros/functions), like the one used below

Array.getStatistics(lineProfile_array, min, max, mean, stdDev);
print ("min value of 'lineProfile_array' :"+ min);
print ("max value of 'lineProfile_array' :"+ max);

// You can find on imagej.net an example script 
// that uses several array functions
// https://imagej.net/ij/macros/examples/ArrayFunctions.txt
