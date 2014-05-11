% Dynamical Modeling Methods for Systems Biology
% April 2014
% Assignment 1 Part 1
% Array computations for simple data analysis

format compact
data = imread('flash4.jpg','jpg') ;
figure
imagesc(data) ;
whos      

dataT = data' ; % transpose data
figure
imagesc(dataT)
whos
[rows,cols] = size(dataT) % determine size of data array

time=[1:cols]; % create x-axis

figure
hold on 
plot(time,dataT(150,:),'b') % plot a control (noflash) region (row 150)
plot(time,dataT(250,:),'r') % plot a flash region (row 250)
plot(time,abs(dataT(150,:) - dataT(250,:)),'g') 
% plot difference between control and flash rows


% Average over the region of the UV flash. 
% Store this in the variable flash. This should have dimensions 1 x 634.

flash_subsample = dataT(220:280,:) ; % flash region (rows 220-280)
figure
imagesc(flash_subsample)

flash = zeros(1,cols);  % create array for avg flash values
for i=1:cols
    flash(i) = mean(flash_subsample(:,i)) ;
end

[max_flash,index] = max(flash) % determine max value and location in vector


% Average over a control region that does not contain the flash. 
% Store this in the variable noflash

noflash_subsample = dataT(420:480,:) ; % control noflash region
figure
imagesc(noflash_subsample)

noflash = zeros(1,cols);  % create array for avg noflash values
for i=1:cols
    noflash(i) = mean(noflash_subsample(:,i)) ;
end

[max_noflash,index] = max(noflash) % determine max value and location in vector


figure
hold on
colors = repmat('krgbmc',1,300) ;
plot(time,flash,colors(2))  % plot avg flash
plot(time,noflash,colors(3)) % plot avg noflash

title('Average Fluorescence of Flash / NoFlash Regions')
ylabel('[Fluorescence] (Arbitrary Units)');
xlabel('[Time] (mS)');
figurelegend{1} = ['Flash']; % create legend in bottom right
figurelegend{2} = ['Noflash'];
legend(figurelegend,'Location','Southeast')

% Convert from raw fluorescence to units of F/F0 
% by normalizing flash and noflash to 
% the average fluorescence in a region with no activity 
% (Hint: between lines 70 and 100 is a good region).

noactivity_subsample = dataT(70:100,:) ; % grab 31 rows from noflash region
figure
imagesc(noactivity_subsample)

noactivity = zeros(1,cols);  % create array for avg noflash values
for i=1:cols
    noactivity(i) = mean(noactivity_subsample(:,i)) ;
end

figure
[max_noactivity,index] = max(noactivity) % determine max value and location in vector
plot(time,noactivity,colors(1)) 

% Convert to F/F0
normalized_flash = flash./noactivity;
normalized_noflash = noflash./noactivity;

figure
hold on
plot(time,normalized_flash,colors(4))  % plot normalized avg flash
plot(time,normalized_noflash,colors(5)) % plot normalized avg noflash

title('Normalized Raw Avg Fluorescence')
ylabel('[Fluorescence] (F/F0)');
xlabel('[Time] (mS)');
figurelegend{1} = ['Flash']; % create legend in bottom right
figurelegend{2} = ['Noflash'];
legend(figurelegend,'Location','Southeast')

% Convert from a ratio R (units of F/F0) to [Ca2+] in units of concentration
% assume baseline Ca2+=100nM and Kd=700nM, sample timing = 1.53ms

Time = 1.53*time; % scale x-axis with sampling time
Ca2base = 150
Kd = 1000

Flash = zeros(1,cols);  % Avg Flash values (Units of Concentration Ca2+)
for i=1:cols
    Flash(i) = (normalized_flash(i)*Kd) / (Kd/Ca2base - normalized_flash(i) + 1) ;
end

[max_Flash,index] = max(Flash) % determine max value and location in vector

NoFlash = zeros(1,cols);  % Avg Noflash values (Units of Concentration Ca2+)
for i=1:cols
    NoFlash(i) = (normalized_noflash(i)*Kd) / (Kd/Ca2base - normalized_noflash(i) + 1) ;
end

[max_NoFlash,index] = max(NoFlash) % determine max value and location in vector

figure
hold on
plot(Time,Flash,colors(4))  % plot normalized avg flash
plot(Time,NoFlash,colors(5)) % plot normalized avg noflash

title('Normalized Avg Fluorescence in Units Concentration')
ylabel('[Fluorescence] (Ca2+ nM)');
xlabel('[Time] (mS)');
figurelegend{1} = ['Flash']; % create legend in bottom right
figurelegend{2} = ['Noflash'];
legend(figurelegend,'Location','Southeast')
