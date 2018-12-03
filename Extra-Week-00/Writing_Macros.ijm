luts     = newArray("Cyan", "Green", "Magenta");
min_vals = newArray(0, 0, 0);
max_vals = newArray(170, 130, 255);

for(i=0; i<3; i++) {
	setSlice(i+1);
	run(luts[i]);
	//run("Brightness/Contrast...");
	setMinAndMax(min_vals[i], max_vals[i]);
}
run("Make Composite");