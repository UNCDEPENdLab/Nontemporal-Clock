load('colorWheelLocations1.mat')
load('colorWheelLocations2.mat')

offset = 500;

colorWheelLocations1 = colorWheelLocations1 + offset;
colorWheelLocations2 = colorWheelLocations2 + offset;

save('colorWheelLocations1.mat','colorWheelLocations1');
save('colorWheelLocations2.mat','colorWheelLocations2');