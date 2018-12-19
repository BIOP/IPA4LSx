/** 
 * Working with Dimensions in Fiji
 * ----------------------------------------------
 * 
 * This short macro showcases how we can manipulate the slices and dimensions of images
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */


// First we clean up Fiji to avoid having strange behavior because or previouly opened images
run("Close All");

showMessage("First we open the dataset Mitosis (26MB)");

run("Mitosis (26MB, 5D stack)");

// We keep the ID so that when needed, we can go back to this image for furhter processing
id = getImageID();

// To get information on an image's dimensions
getDimensions(width, height, channels, slices, frames);
waitForUser("This image has "+channels+" Channels, "+slices+" Slices and "+frames+ " Frames\nAnd is "+width+"x"+height+" pixels in size\nInspect the code to see how to get these numbers.");


waitForUser("Please Open the Macro Recorder, then click OK");
waitForUser("Move the sliders below the image, and note how nothing gets recorded");

slice = getNumber("Choose a Slice between "+1+" and "+slices, 3);

Stack.setSlice(slice);
waitForUser("We have selected slice number "+slice+" using a macro");


// There are many methods to access different dimensions of the image. 
// See https://imagej.net/ij/developer/macro/functions.html#Stack

// Here we move to channel 2
Stack.setChannel(2);
Stack.setFrame(10);
Stack.setDisplayMode("color");
waitForUser("Here we moved to frame 10 and channel 2\nWe also set the image display to 'Color'");

// Duplicating Images
waitForUser("Duplicating images is one of the most important aspects when working in Fiji.\nWe can use 'Image>Duplicate...'. Feel free to try it out.");


waitForUser("We will now duplicate the image within a macro");
channel = getNumber("Choose a Channel", 1);
slice = 3;
frames = "11-31";
selectImage(id);
// We can duplicate subregions of hyperstacks easily
run("Duplicate...", "title=[Subregion C"+channel+" Z"+slice+" T"+frames+" ] duplicate channels="+channel+" slices="+slice+" frames="+frames);
waitForUser("Here we duplicated frames "+frames+" of channel "+channel+" and slice "+slice);


// We can duplicate ranges like this.
// We can do it for ranges, but these should be strings...
channel = 1;
slices = "1-3";
frames = "11-31";
selectImage(id);

// We can duplicate subregions of hyperstacks easily
run("Duplicate...", "title=[Subregion C"+channel+" Z"+slices+" T"+frames+" ] duplicate channels="+channel+" slices="+slices+" frames="+frames);
waitForUser("Here we duplicated frames "+frames+" of channel "+channel+" and slices "+slices);

// Show what happens of the image has a selection
selectImage(id)
waitForUser("Note that if you have a selection on your image, duplicate will copy only that selection, as a rectangle...");

// You will see ROIs in subsequent weeks. In the meantime look at 
// https://imagej.net/ij/developer/macro/functions.html#makeOval
makeOval(56, 56, 50, 50);
run("Duplicate...", "title=[Duplicated stack with region] duplicate");

run("Tile");

waitForUser("Look at the different images and how they were obtained using the Macro Language");