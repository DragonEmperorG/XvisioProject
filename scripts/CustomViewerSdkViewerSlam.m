clearvars;
close all;
dbstop error;
% clc;
addpath(genpath(pwd));

TAG = 'CustomViewerSdkViewerSlam';

cXvisioDatasetFolderPath = 'E:\GitHubRepositories\XvisioProject\datas\2023-03-30T11-22-52';
cXvisioDatasetEdgeDataFileName = 'edge.csv';
cXvisioDatasetHostDataFileName = 'host.csv';

% cXvisioDatasetEdgeDataFilePath = fullfile(cXvisioDatasetFolderPath,cXvisioDatasetEdgeDataFileName);
% cXvisioDatasetEdgeData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetEdgeDataFilePath);

cXvisioDatasetHostDataFilePath = fullfile(cXvisioDatasetFolderPath,cXvisioDatasetHostDataFileName);
cXvisioDatasetHostData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetHostDataFilePath);

pIndex = 1:500*20;
pPose = cXvisioDatasetHostData(pIndex,:);
plotSEBracket3Pose(pPose);

