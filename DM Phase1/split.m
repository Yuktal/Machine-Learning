function x = split(record)

intervalData = load("Data\Annotation\" + record(2) + ".txt");
emgData = load("Data\EMG\" + record(2) + "_EMG.txt");
imuData = load("Data\IMU\" + record(2) + "_IMU.txt");
frameRate = record(5);
totalFrames = record(3);

startTimeStamp = emgData(end, 1) - ((totalFrames/frameRate)* 1000);

startPoints = intervalData(:,1);
endPoints = intervalData(:,2);
    fid = fopen("Data\eating\" + record(2) + ".csv", 'w+');
    fnid = fopen("Data\nonEating\" + record(2) + ".csv", 'w+');
for ind = 1:size(startPoints,1)
    
%Eating Data
    currentStart = startTimeStamp + ((startPoints(ind)/frameRate) * 1000);
    currentEnd = startTimeStamp + ((endPoints(ind)/frameRate) * 1000);
    
    %ACC, GYRO, ORT
    eatingData = imuData(imuData(:,1) > currentStart & imuData(:,1) < currentEnd, 2:end);
    eatingNames = ["Eating Action " + ind + " Ort x", "Eating Action " + ind + " Ort y", "Eating Action " + ind + " Ort z", "Eating Action " + ind + " Ort w", "Eating Action " + ind + " Acc x", "Eating Action " + ind + " Acc y", "Eating Action " + ind + " Acc z", "Eating Action " + ind + " gyro x", "Eating Action " + ind + " gyro y", "Eating Action " + ind + " gyro z"]';
    eatingData = [eatingNames eatingData'];
    for ii = 1:size(eatingData, 1)
        fprintf(fid, '%s,', eatingData(ii,1));
        fprintf(fid, '%g,', eatingData(ii,2:end));
        fprintf(fid, '\n');
    end 
    %EMG Data
    eatingData = emgData(emgData(:,1) > currentStart & emgData(:,1) < currentEnd, 2:end);
    eatingNames = ["Eating Action " + ind + " Emg 1", "Eating Action " + ind + " Emg 2", "Eating Action " + ind + " Emg 3", "Eating Action " + ind + " Emg 4", "Eating Action " + ind + " Emg 5", "Eating Action " + ind + " Emg 6", "Eating Action " + ind + " Emg 7", "Eating Action " + ind + " Emg 8"]';
    eatingData = [eatingNames eatingData'];
    for ii = 1:size(eatingData, 1)
        fprintf(fid, '%s,', eatingData(ii,1));
        fprintf(fid, '%g,', eatingData(ii,2:end));
        fprintf(fid, '\n');
    end
    
%Non Eating Data
    if ind < size(startPoints,1)
        nextStart = startTimeStamp + ((startPoints(ind+1)/frameRate) * 1000);
        %ACC, GYRO, ORT
        nonEatingData = imuData(imuData(:,1) > currentEnd & imuData(:,1) < nextStart, 2:end);
        nonEatingNames = ["Non Eating Action " + ind + " Ort x", "Non Eating Action " + ind + " Ort y", "Non Eating Action " + ind + " Ort z", "Non Eating Action " + ind + " Ort w", "Non Eating Action " + ind + " Acc x", "Non Eating Action " + ind + " Acc y", "Non Eating Action " + ind + " Acc z", "Non Eating Action " + ind + " Gyro x", "Non Eating Action " + ind + " Gyro y", "Non Eating Action " + ind + " Gyro z"]';
        nonEatingData = [nonEatingNames nonEatingData'];
        for ii = 1:size(nonEatingData, 1)
            fprintf(fnid, '%s,', nonEatingData(ii,1));
            fprintf(fnid, '%g,', nonEatingData(ii,2:end));
            fprintf(fnid, '\n');
        end
        
        %EMG Data
        nonEatingData = emgData(emgData(:,1) > currentEnd & emgData(:,1) < nextStart, 2:end);
        nonEatingNames = ["Non Eating Action " + ind + " Emg 1", "Non Eating Action " + ind + " Emg 2", "Non Eating Action " + ind + " Emg 3", "Non Eating Action " + ind + " Emg 4", "Non Eating Action " + ind + " Emg 5", "Non Eating Action " + ind + " Emg 6", "Non Eating Action " + ind + " Emg 7", "Non Eating Action " + ind + " Emg 8"]';
        nonEatingData = [nonEatingNames nonEatingData'];
        for ii = 1:size(nonEatingData, 1)
            fprintf(fnid, '%s,', nonEatingData(ii,1));
            fprintf(fnid, '%g,', nonEatingData(ii,2:end));
            fprintf(fnid, '\n');
        end   
    end
end
    fclose(fid);
    fclose(fnid);
end