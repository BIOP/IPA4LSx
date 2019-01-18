n = nResults; // Get the current number of rows

large_area_threshold  = 500;
medium_area_threshold = 200;

for(i=0; i<n; i++) {
	current_area = getResult("Area", i);

	if( current_area >= large_area_threshold ) {
		setResult("Size", i, "Large");
	}
	
	if( current_area < large_area_threshold && current_area >= medium_area_threshold ) {
		setResult("Size", i, "Medium");
	}
	
	if( current_area < medium_area_threshold ) {
		setResult("Size", i, "Small");
	}
}