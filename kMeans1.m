clear; clc; close all;

% 1) READ DATA
disp("Loading data...");
data = readtable("kMeans.csv"); %  Transfers the CSV file to MATLAB as a table into the `data` variable.

% Variables we will use
cities  = data.Sehir; % Assign the city column in the data variable to the cities variable.
studentCounts = [data.Grup1, data.Grup2, data.Grup3];   % Creates a matrix by writing the columns side by side.


% 2) NORMALIZE DATA
disp(" Normalizing data..."); 
normalizedData = normalize(studentCounts, "range"); % It normalizes the matrix values ​​by shifting them to the 0-1 range.


% 3) ELBOW METHOD the process of finding the optimal number of sets
disp(" Calculating Elbow method...");

maxK = 10; % For each k value between 1 and 10
errorValues = zeros(maxK,1); % an empty array to store each calculated WCSS value  

% k means calculation for each k value between 1 and 10.
for k = 1:maxK
    [~, ~, sumd] = kmeans(normalizedData, k); % Calculates SUMD-WCSS values ​​for each cluster. 
    errorValues(k) = sum(sumd); % Assign the sum of each calculated value to the array.  
end

figure; % grafik penceresi
plot(1:maxK, errorValues, "-o", "LineWidth", 1.3); % 2D Graph
title("Elbow Method - Best k"); % Table Name
xlabel("Number of clusters (k)"); % value of X-axis
ylabel("Error (WCSS)"); % value of Y-axis
grid on; % Make graph visible

disp(" Choose k at the 'elbow' point of the graph.");


% 4) APPLY K-MEANS (STABLE & REPEATABLE RESULT)
k = input(" How many clusters do you want to use? k = "); % User assign the K value

% Settings for stable result
opts = statset('Display','final'); %  The screen only shows the final result.

% k means is calculated based on the k value we choose.
% clusterlabel-which cluster each city is in / clustercenter-cluster centers
[clusterLabels, clusterCenters] = kmeans(normalizedData, k, ...
    'Replicates', 20, ...      % Try 20 times and choose the best result.
    'Start', 'plus', ...       % K-means++ (make smart clusters)
    'Options', opts); 

data.Cluster = clusterLabels; % Which cluster do the cities belong to

disp(" K-Means clustering completed (stable result).");


% 5) 3D CLUSTER PLOT
figure; % Draw a 3D graph where each shape represents a group, and show the shapes in each group in a different color.
scatter3(normalizedData(:,1), normalizedData(:,2), normalizedData(:,3), ...
    70, clusterLabels, "filled");

title("3D K-Means Results");
xlabel("Group1");
ylabel("Group2");
zlabel("Group3");
grid on;
view(45,20); % angle of view 

% 6) MAP OF TURKEY
disp("Drawing Turkey map...");

% Get axis data from the dataset.
latitudes  = data.Lat;
longitudes = data.Lon;

figure; 
% The process of displaying clusters on a map.
geoscatter(latitudes, longitudes, 80, clusterLabels, "filled");
geobasemap streets;
title("K-Means Cluster Results on Turkey Map");


% 7) CLUSTER SUMMARIES
disp(" Cluster summaries:");

for i = 1:k % It works as many times as there are sets.
    fprintf("\n--- CLUSTER %d ---\n", i);

    disp(cities(clusterLabels == i)); % It filters which cities are in that cluster and retrieves their names using the word "cities".

    fprintf("Average (Group1, Group2, Group3): ");
    disp(mean(studentCounts(clusterLabels == i, :))); %  average of the cities in the cluster
end