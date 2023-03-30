function xvisioSdkViewerWindowSlamData = loadXvisioSdkViewerWindowSlamData(filePath)
%UNTITLED2 此处提供此函数的摘要
%   此处提供详细说明

TAG = 'loadXvisioSdkViewerWindowSlamData';

[folderPath,name,~] = fileparts(filePath);
loadedXvisioSdkViewerWindowSlamDataFileName = strcat(name,'.mat');
loadedXvisioSdkViewerWindowSlamDataFilePath = fullfile(folderPath,loadedXvisioSdkViewerWindowSlamDataFileName);

if exist(loadedXvisioSdkViewerWindowSlamDataFilePath,'file')
    loadedXvisioSdkViewerWindowSlamEdgeDataStructure = load(loadedXvisioSdkViewerWindowSlamDataFilePath);
    xvisioSdkViewerWindowSlamData = loadedXvisioSdkViewerWindowSlamEdgeDataStructure.xvisioSdkViewerWindowSlamData;
else
    xvisioSdkViewerWindowSlamData = readmatrix(filePath);
    xvisioSdkViewerWindowSlamData(:,2) = xvisioSdkViewerWindowSlamData(:,2) / 1e6;
    save(loadedXvisioSdkViewerWindowSlamDataFilePath,'xvisioSdkViewerWindowSlamData');
end

dataSize = size(xvisioSdkViewerWindowSlamData,1);
logHeadTime = xvisioSdkViewerWindowSlamData(1,2);
logHeadTimeDateStr = logHeadTime;
logTailTime = xvisioSdkViewerWindowSlamData(dataSize,2);
logTailTimeDateStr = logTailTime;
duration = logTailTime - logHeadTime;
logMsg = sprintf('Xvisio slam data from %.0f to %.0f, duration %.3f s',logHeadTimeDateStr,logTailTimeDateStr,duration);
log2terminal('I',TAG,logMsg);

dataEdgeSampleTimeInterval = xvisioSdkViewerWindowSlamData(2:dataSize,2) - xvisioSdkViewerWindowSlamData(1:(dataSize-1),2);
dataEdgeMeanSampleTimeInterval = mean(dataEdgeSampleTimeInterval);
dataEdgeMaxSampleTimeInterval = max(dataEdgeSampleTimeInterval);
dataEdgeMinSampleTimeInterval = min(dataEdgeSampleTimeInterval);
dataEdgeSampleRate = 1 / dataEdgeMeanSampleTimeInterval;
logMsg = sprintf('Xvisio slam data sample interval mean %.3f s, min %.3f s, max %.3f s, estimated sample rate %.0f Hz', dataEdgeMeanSampleTimeInterval,dataEdgeMinSampleTimeInterval,dataEdgeMaxSampleTimeInterval,dataEdgeSampleRate);
log2terminal('I',TAG,logMsg);

figure;
timeReferenceSubPlotRows = 4;
timeReferenceSubPlotColumns = 1;
% https://waldyrious.net/viridis-palette-generator/
ViridisColerPalette03 = ["#fde725" "#21918c" "#440154"];
ViridisColerPalette04 = ["#fde725" "#35b779" "#31688e" "#440154"];
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,1);
pHostAlignedTimestamp = xvisioSdkViewerWindowSlamData(:,1) - xvisioSdkViewerWindowSlamData(1,1);
pEdgeAlignedTimestamp = xvisioSdkViewerWindowSlamData(:,2) - xvisioSdkViewerWindowSlamData(1,2);
hold on;
plot(pHostAlignedTimestamp,'Color',ViridisColerPalette03(1),'DisplayName','Host');
plot(pEdgeAlignedTimestamp,'Color',ViridisColerPalette03(3),'DisplayName','Edge');
xlabel('Sample');
ylabel('Timestamp (s)');
title('Sample time (aligned to 0)');
legend;
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,2);
pTimeAxis = pEdgeAlignedTimestamp;
hold on;
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,3),'Color',ViridisColerPalette03(1),'DisplayName','x');
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,4),'Color',ViridisColerPalette03(2),'DisplayName','y');
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,5),'Color',ViridisColerPalette03(3),'DisplayName','z');
xlabel('Sample (s)');
ylabel('Position (m)');
title('Pose position');
legend;
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,3);
hold on;
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,6),'Color',ViridisColerPalette04(1),'DisplayName','qx');
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,7),'Color',ViridisColerPalette04(2),'DisplayName','qy');
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,8),'Color',ViridisColerPalette04(3),'DisplayName','qz');
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,9),'Color',ViridisColerPalette04(4),'DisplayName','qw');
xlabel('Sample (s)');
ylabel('Quaternion');
legend;
title('Pose quaternion');
hold off;
subplot(timeReferenceSubPlotRows,timeReferenceSubPlotColumns,4);
plot(pTimeAxis,xvisioSdkViewerWindowSlamData(:,10),'Color',ViridisColerPalette03(3));
xlabel('Sample (s)');
ylabel('Confidence');
title('Pose confidence');



end