/** 
 * MultiChannel Image
 * ----------------------------------------------
 * 
 * This short macro showcases different ways to open an image
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

run("HeLa Cells (1.3M, 48-bit RGB)");
openedID = getImageID();
openedImageName = getTitle();
waitForUser("We opened a composite image.\nWe'll now duplicate it and change the LUTs of each channel.");

// be sure to select the image and duplicate it with a new title
selectImage(openedID);
newImageName = "changeLUTs"; 
// for the "duplicate" command the [] are not mandotary, 
// but the function will "fail" if the title contains blank space
run("Duplicate...", "title=["+newImageName+"] duplicate");
newImageID = getImageID();

// change LUT for each channel
Stack.setChannel(1);
run("Cyan");
Stack.setChannel(2);
run("Magenta");
Stack.setChannel(3);
run("Yellow");

// Tile the images on the screen
run("Tile");
waitForUser("Now, let's convert this image to RGB");

selectImage(newImageID);
run("RGB Color");
rgbImageID = getImageID();
rgbImageName = getTitle();
run("Tile");
waitForUser("Now, let's convert it back to a composite and re-apply Reg, Green, Blue LUTs");
selectImage(rgbImageID);
run("Make Composite");
rgbImageID = getImageID(); //update ID after composite conversion

// Change LUTs back to Red, Green, Blue & resetMinMax display
Stack.setChannel(1);
run("Red");
resetMinAndMax();
Stack.setChannel(2);
run("Green");
resetMinAndMax();
Stack.setChannel(3);
run("Blue");
resetMinAndMax();
waitForUser("Maybe you do not notice any 'major' changes, so let's compare the 3 images in grayscale mode ");


// Move to Grayscale display mode for all images.
selectImage(openedID);
Stack.setChannel(1);
Stack.setDisplayMode("grayscale");

selectImage(newImageID);
Stack.setDisplayMode("grayscale");
Stack.setChannel(1);

selectImage(rgbImageID);
Stack.setDisplayMode("grayscale");
Stack.setChannel(1);

run("Synchronize Windows");

run("Tile");
selectWindow("Synchronize Windows");
waitForUser("Using the 'Synchronize the Windows', you can select the different images\n and go from one channel to another using the slider.\nYou might notice some changes in the images.");