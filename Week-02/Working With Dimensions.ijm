showMessage("First we open the dataset Mitosis (26MB)");

id = getImageID();

// To get information on an image's dimensions
getDimensions(width, height, channels, slices, frames);
showMessage("This image has "+channels+" Channels, "+slices+" Slices and "+frames+ " Frames\nAnd is "+width+"x"+height+" pixels in size\nInspect the code to see how to get these numbers.");

waitForUser("Please Open the Macro Recorder, then click OK");
waitForUser("Move the sliders around, and note how nothing gets recorded");

slice = getNumber("Choose a Slice between "+1+" and "+slices, 3);

Stack.setSlice(slice);
showMessage("We have selected slice number "+slice+" using a macro");

// There are many methods to access different dimensions of the image. 
// See https://imagej.net/ij/developer/macro/functions.html#Stack

// Here we move to channel 2
Stack.setChannel(2);
Stack.setFrame(10);
Stack.setDisplayMode("color");
showMessage("Here we moved to frame 10 and channel 2\nWe also set the image display to 'Color'");

channel = 1;
slice = 3;
frames = "11-31";
// We can duplicate subregions of hyperstacks easily
run("Duplicate...", "title=[Subregion C"+channel+" Z"+slice+" T"+frames+" ] duplicate channels="+channel+" slices="+slice+" frames="+frames);
showMessage("Here we duplicated frames "+frames+" of channel "+channel+" and slice "+slice);

// We can do it for ranges, but these should be strings...
channel = 1;
slices = "1-3";
frames = "11-31";
selectImage(id);

// We can duplicate subregions of hyperstacks easily
run("Duplicate...", "title=[Subregion C"+channel+" Z"+slices+" T"+frames+" ] duplicate channels="+channel+" slices="+slices+" frames="+frames);
showMessage("Here we duplicated frames "+frames+" of channel "+channel+" and slices "+slices);

run("Tile");