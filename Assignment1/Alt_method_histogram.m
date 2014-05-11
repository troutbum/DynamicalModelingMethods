% Dynamical Modeling Methods for Systems Biology
% April 2014
% Assignment 1 Part 2
% Visualization of data for statistical classification

load sampledata2  % test data

% Column 1	patients' ages
% Column 2	self-reported number of drinks per week
% Column 3	clinical status: 1 = cancer, 0 = no cancer

% number of patients with cancer
total_cancer = sum(data(:,3))

% histogram of Column 2 - number of drinks
hist(data(:,2))

% use histc function (Histogram bin count)
% to analyze drinks per week
drinks_binranges = [0:15] ;
drinks = data(:,2) ; % get column 2 data only
[drinkbins] = histc(drinks,drinks_binranges)

figure
bar(drinks_binranges,drinkbins,'histc')
title('Self-reported number of drinks per week')
ylabel('Number of Patients');
xlabel('Drinks per week');






% What percent of all patients who drink 
% more than 3 times per week have cancer?





