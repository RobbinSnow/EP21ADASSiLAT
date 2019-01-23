% main m file to read data and plot
% clc;clear;
ACCCounter = 0;
AEBCounter = 0;
LKACounter = 0;

Path = strcat(pwd,'\Data');    %get the relative path of Data             
Folder =dir(fullfile(Path));
FolderNames ={Folder.name}';                                %get all the subfolders name
for i=3:length(FolderNames)
    str = char(FolderNames(i));
    FilePath = strcat(Path,'\',char(FolderNames(i)));       
    File = dir(fullfile(FilePath,'*.mat'));  % get all the file name with .mat
    FileNames = {File.name}';
    for j=1:length(FileNames)  
        TestResult=load(strcat(FilePath,'\',char(FileNames(j))),'-mat');
        if strcmp(str,'ACC')==1
%             ACCPrtPath = strcat(FilePath,'\ACC');
%             [Accflag] = myAccPlot(TestResult,j,ACCPrtPath);% in case
%             later using relative image path
            [Accflag] = myAccPlot(TestResult,j,str);
            ACCCounter = ACCCounter+1;
        elseif strcmp(str,'AEB')==1
            [AEBflag] = myAccPlot(TestResult,j,str);
            AEBCounter = AEBCounter+1;
        elseif strcmp(str,'LKA')==1
            [LKAflag] = myAccPlot(TestResult,j,str);
            LKACounter = LKACounter+1;
        else
            break;
        end
    end
    
end


