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
drinks_binranges = 0:15 ;
drinks = data(:,2) ; % get column 2 data only
drinkbins = histc(drinks,drinks_binranges)
hist(drinkbins)
bar(drinkbins)
title('Self-reported number of drinks per week')
ylabel('Number of Patients');
xlabel('Drinks per week');


% sort data into arrays with/without cancer
ages_with_cancer = data(data(:,3) == 1,1) ;  % only grabs 1st column
% ages_with_cancer = data(data(:,3) == 1) ;  % also, only grabs 1st column
% data_with_cancer = data(data(:,3) == 1,:) ;  % grabs all columns
% data_with_cancer = data(data(:,3) == 1,2) ;  % grabs 2nd column
ages_without_cancer = data(data(:,3) == 0,1) ; % only grabs 1st column

figure
subplot(2,1,1)
xvalues = [15,25,35,45,55,65,75]; % set histogram bin intervals
% xvalues = [12.5,17.5,22.5,27.5,32.5,37.5,42.5,47.5,52.5,57.5,62.5,67.5]; % set histogram bin intervals
hist(ages_with_cancer,xvalues) ; % histogram of ages
title('Histogram of Ages with Cancer')

subplot(2,1,2)
hist(ages_without_cancer,xvalues)
title('Histogram of Ages without Cancer') 

h = findobj(gca,'Type','patch'); % use handle to change plot colors
set(h,'FaceColor',[0 .5 .5],'EdgeColor','w')

% use histc function (Histogram bin count)
% to analyze age distribution of groups

ages = data(:,1) ;
age_binranges = [15,25,35,45,55,65,75] ;
%age_binranges = [10,20,30,40,50,60,70] ;
%age_binranges = [12.5,17.5,22.5,27.5,32.5,37.5,42.5,47.5,52.5,57.5,62.5,67.5];
%age_binranges = [15,25,35,45,55,65] ;
%age_binranges = [10,30,50,70] ;

[agebins] = histc(ages,age_binranges)
figure
subplot(3,1,1)
bar(age_binranges,agebins,'histc')  % ages of all patients
title('Histogram of All Patient Ages')
ylabel('Number of Patients')
xlabel('Age')

[agecancerbins] = histc(ages_with_cancer,age_binranges)
subplot(3,1,2)
bar(age_binranges,agecancerbins,'histc')  % ages of cancer patients
title('Histogram of Cancer Patient Ages')
ylabel('Number of Patients')
xlabel('Age')

[agenocancerbins] = histc(ages_without_cancer,age_binranges)
subplot(3,1,3)
bar(age_binranges,agenocancerbins,'histc')  % ages of no cancer patients
title('Histogram of Patient Ages without Cancer')
ylabel('Number of Patients')
xlabel('Age')

% What percent of all patients who drink 
% more than 3 times per week have cancer?

ThreeDrinks = data(data(:,2) > 3,:) ; % patients 3 or more drinks
Patients_3D = size(ThreeDrinks,1) % counts number of patients 

Cancer3D = ThreeDrinks(ThreeDrinks(:,3) == 1,:) ; % with cancer
Patients_Cancer_3D = size(Cancer3D,1) % counts number of patients

Percent_Cancer_3D = Patients_Cancer_3D / Patients_3D

