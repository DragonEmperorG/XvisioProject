function hiTargetLixelX1Data = loadHiTargetLixelX1Data(folderPath)
%UNTITLED2 此处提供此函数的摘要
%   此处提供详细说明

TAG = 'loadHiTargetLixelXiData';

cHiTargetDatasetProjectDataFolderName = 'project_data';
cHiTargetDatasetProjectDataFolderAlgorithmFolderName = 'algorithm';
cHiTargetDatasetProjectDataFolderAlgorithmFolderPath = fullfile(folderPath,cHiTargetDatasetProjectDataFolderName,cHiTargetDatasetProjectDataFolderAlgorithmFolderName);
cHiTargetDatasetProjectDataFolderAlgorithmFolderPosesFileName = 'poses';
cPosesCsvFileName = strcat(cHiTargetDatasetProjectDataFolderAlgorithmFolderPosesFileName,'.csv');
cPosesMatFileName = strcat(cHiTargetDatasetProjectDataFolderAlgorithmFolderPosesFileName,'.mat');

cPosesMatFilePath = fullfile(cHiTargetDatasetProjectDataFolderAlgorithmFolderPath,cPosesMatFileName);
if exist(cPosesMatFilePath,'file')
    loadedPosesDataStructure = load(cPosesMatFilePath);
    hiTargetLixelX1Data = loadedPosesDataStructure.hiTargetLixelX1Data;
else
    cPosesCsvFilePath = fullfile(cHiTargetDatasetProjectDataFolderAlgorithmFolderPath,cPosesCsvFileName);
    hiTargetLixelX1Data = readmatrix(cPosesCsvFilePath);
    save(cPosesMatFileName,'hiTargetLixelX1Data');
end

dataSize = size(hiTargetLixelX1Data,1);
logHeadTime = hiTargetLixelX1Data(1,1);
logHeadTimeDateStr = logHeadTime;
logTailTime = hiTargetLixelX1Data(dataSize,1);
logTailTimeDateStr = logTailTime;
duration = logTailTime - logHeadTime;
logMsg = sprintf('Lixel X1 pose data from %.0f to %.0f, duration %.3f s',logHeadTimeDateStr,logTailTimeDateStr,duration);
log2terminal('I',TAG,logMsg);

dataSampleTimeInterval = hiTargetLixelX1Data(2:dataSize,1) - hiTargetLixelX1Data(1:(dataSize-1),1);
dataMeanSampleTimeInterval = mean(dataSampleTimeInterval);
dataMaxSampleTimeInterval = max(dataSampleTimeInterval);
dataMinSampleTimeInterval = min(dataSampleTimeInterval);
dataSampleRate = 1 / dataMeanSampleTimeInterval;
logMsg = sprintf('Lixel X1 pose data sample interval mean %.3f s, min %.3f s, max %.3f s, estimated sample rate %.0f Hz', dataMeanSampleTimeInterval,dataMinSampleTimeInterval,dataMaxSampleTimeInterval,dataSampleRate);
log2terminal('I',TAG,logMsg);

figure;
timeReferenceSubPlotRows = 4;
timeReferenceSubPlotColumns = 1;
% https://waldyrious.net/viridis-palette-generator/
ViridisColerPalette03 = ["#fde725" "#21918c" "#440154"];
ViridisColerPalette04 = ["#fde725" "#35b779" "#31688e" "#440154"];
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,1);
pAlignedTimestamp = hiTargetLixelX1Data(:,1) - hiTargetLixelX1Data(1,1);
hold on;
plot(pAlignedTimestamp,'Color',ViridisColerPalette03(1));
xlabel('Sample');
ylabel('Timestamp (s)');
title('Sample time (aligned to 0)');
legend;
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,2);
pTimeAxis = pAlignedTimestamp;
hold on;
plot(pTimeAxis,hiTargetLixelX1Data(:,2),'Color',ViridisColerPalette03(1),'DisplayName','x');
plot(pTimeAxis,hiTargetLixelX1Data(:,3),'Color',ViridisColerPalette03(2),'DisplayName','y');
plot(pTimeAxis,hiTargetLixelX1Data(:,4),'Color',ViridisColerPalette03(3),'DisplayName','z');
xlabel('Sample (s)');
ylabel('Position (m)');
title('Pose position');
legend;
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,3);
hold on;
plot(pTimeAxis,hiTargetLixelX1Data(:,5),'Color',ViridisColerPalette04(1),'DisplayName','qw');
plot(pTimeAxis,hiTargetLixelX1Data(:,6),'Color',ViridisColerPalette04(2),'DisplayName','qx');
plot(pTimeAxis,hiTargetLixelX1Data(:,7),'Color',ViridisColerPalette04(3),'DisplayName','qy');
plot(pTimeAxis,hiTargetLixelX1Data(:,8),'Color',ViridisColerPalette04(4),'DisplayName','qz');
% plot(pTimeAxis,sum(hiTargetLixelX1Data(:,5:8).^2,2),'Color','r','DisplayName','test');
xlabel('Sample (s)');
ylabel('Quaternion');
legend;
title('Pose quaternion');
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,4);
hold on;
plot(pTimeAxis,hiTargetLixelX1Data(:,9),'Color',ViridisColerPalette04(2),'DisplayName','qx');
plot(pTimeAxis,hiTargetLixelX1Data(:,10),'Color',ViridisColerPalette04(3),'DisplayName','qy');
plot(pTimeAxis,hiTargetLixelX1Data(:,11),'Color',ViridisColerPalette04(4),'DisplayName','qz');
hold off;
xlabel('Sample (s)');
ylabel('Unknow');
title('Unknow');


end