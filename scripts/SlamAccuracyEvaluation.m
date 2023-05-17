clearvars;
close all;
dbstop error;
% clc;
addpath(genpath(pwd));

TAG = 'SlamAccuracyEvaluation';

cXvisioDatasetRootFolderPath = 'C:\Users\QIAN LONG\Downloads';
% cXvisioDatasetRootFolderPath = 'E:\DoctorRelated\20230328诠视科技XvisionSeerSenseDS80Module研究\1_试验\Datasets';
cXvisioDatasetFolderName = '2023-05-09T14-56-57';
cXvisioDatasetEdgeDataFileName = 'edge.csv';
cXvisioDatasetHostDataFileName = 'host.csv';

% cXvisioDatasetEdgeDataFilePath = fullfile(cXvisioDatasetFolderPath,cXvisioDatasetEdgeDataFileName);
% cXvisioDatasetEdgeData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetEdgeDataFilePath);

cXvisioDatasetHostDataFilePath = fullfile(cXvisioDatasetRootFolderPath,cXvisioDatasetFolderName,cXvisioDatasetHostDataFileName);
cXvisioDatasetHostData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetHostDataFilePath);

plotSEBracket3Pose(cXvisioDatasetHostData);

cXvisioDatasetHostDataSize = size(cXvisioDatasetHostData,1);
deltaPosition = cXvisioDatasetHostData(2:cXvisioDatasetHostDataSize,3:5) - cXvisioDatasetHostData(1:(cXvisioDatasetHostDataSize-1),3:5);
distance = sum(sqrt(sum(deltaPosition.^2,2)));

deltaHeadTailPosition = cXvisioDatasetHostData(cXvisioDatasetHostDataSize,3:5) - cXvisioDatasetHostData(1,3:5);
closingError = sum(sqrt(sum(deltaHeadTailPosition.^2,2)));
closingErrorRelative = closingError / distance * 100;

logMsg = sprintf('Xvisio slam data track length %.3f m, closing error %.3f m, relative %.3f %%',distance,closingError,closingErrorRelative);
log2terminal('I',TAG,logMsg);

confidenceSection = zeros(cXvisioDatasetHostDataSize-1,8);
confidenceSection(:,1) = cXvisioDatasetHostData(1:(cXvisioDatasetHostDataSize-1),1);
confidenceSection(:,2) = cXvisioDatasetHostData(1:(cXvisioDatasetHostDataSize-1),10);
confidenceSection(:,3) = cXvisioDatasetHostData(2:cXvisioDatasetHostDataSize,1);
confidenceSection(:,4) = cXvisioDatasetHostData(2:cXvisioDatasetHostDataSize,10);
confidenceSection(:,5) = confidenceSection(:,3) - confidenceSection(:,1);
confidenceSection(:,6) = confidenceSection(:,2) == 1 & confidenceSection(:,4) == 1;
confidenceSection(:,7) = (confidenceSection(:,2) + confidenceSection(:,4)) * 0.5;
confidenceSection(:,8) = confidenceSection(:,5) .* confidenceSection(:,7);

confidenceLessThan1Duration = sum(confidenceSection(confidenceSection(:,6)==1,5));
confidenceTotalDuration = sum(confidenceSection(:,5));
confidenceDurationPercentage = confidenceLessThan1Duration / confidenceTotalDuration;
logMsg = sprintf('Xvisio slam data sample time confidence < 1 %.3f %%',(1-confidenceDurationPercentage)*100);
log2terminal('I',TAG,logMsg);

confidenceWeightedDuration = sum(confidenceSection(:,8));
confidenceWeightedDurationPercentage = confidenceWeightedDuration / confidenceTotalDuration;
logMsg = sprintf('Xvisio slam data sample time confidence < 1 %.3f %%',(1-confidenceWeightedDurationPercentage)*100);
log2terminal('I',TAG,logMsg);

