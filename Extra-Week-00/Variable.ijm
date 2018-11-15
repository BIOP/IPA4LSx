/** 
 * Variable
 * ----------------------------------------------
 * 
 * This short macro showcases different ways to use variable (string and number)
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
// and Clear the log window.
print("\\Clear");

// Let's open "blobs.gif" 
run("Blobs (25K)");
// and get its ID (so we can re-select this image when needed)
blobs_id = getImageID();
// a comment in a dialog window.
waitForUser("We'll change the LookUp Table of the image to Red");

// make sure to select the image
selectImage(blobs_id);
// and change the LUT to Red.
run("Red");
// a comment in a dialog window.
waitForUser("Now the image is 'Red'.\nLet's change it to another color");

// make sure to select the image
selectImage(blobs_id);
// and change the LUT to Blue.
run("Blue");
//  a comment in a dialog window.
waitForUser("Now the image is 'Blue'");

// Here, we define a variable named 'color' equal to the string "Red"
color = "Red";
// and change the LUT to the 'color'.
run(color);
// a comment in a dialog window.
waitForUser("Here, we've used the variable 'color' to change the LUT.\nLet's change the value  of the variabele if we change the value of the variable 'color'.");

// Here, we change the value of thevariable named 'color' equal to the string "Green"
color = "Green";
// and change the LUT to the 'color'.
run(color);
// a comment in a dialog window.
waitForUser("Variables are not only strings, they can also be numbers.\nLet's add some value to the pixels");

// make sure to select the image and get the Histogram
selectImage(blobs_id);
run("Histogram");
// a comment in a dialog window.
waitForUser("To highligth the effect, we'll have a look to the histogram");

// when using the histogram, we have to remove the extension from the image title
// select the image
selectImage(blobs_id);
// store it title in a variable
blobs_title = getTitle();
print("Original title : "+blobs_title);

// and we remove the extension .gif from blobs_title
// to do so we use the functions substring(str, startIndex,endIndex) and lengthOf(str)
blobs_titleNoExt = substring(blobs_title, 0, (lengthOf(blobs_title)-4) ) 
// normally we could use File.nameWithoutExtension but doesn't work here :(;
print("Modified title : "+blobs_titleNoExt);

// Here we add the value 20 to all the pixels
run("Add...", "value=20");
// and rename the image accordingly so we can identify the histogram
rename(blobs_titleNoExt + "_add20");
// before running the function Histogram
run("Histogram");


// Here, is a new variable 'offset', with a defined value
offset = -25
// we select the image
selectImage(blobs_id);
// we run the command Add with the value = offset
// note : here the value is negative, so we could also use Substract the opposite of offset
run("Add...", "value="+offset);
// rename the image accordingly so we can identify the histogram 
rename(blobs_titleNoExt + "_add"+offset);
// before running the function Histogram
run("Histogram");

// reorganize images on  screen
run("Tile");