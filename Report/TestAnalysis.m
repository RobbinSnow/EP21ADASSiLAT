ResultList = {'Fail','unknown','Pass'};

Path = strcat(pwd,'\Data');    %get the relative path of Data             
Folder = dir(fullfile(Path));
FolderNames ={Folder.name}';%get all the subfolders name

ResultFile = strcat(Path,'\TestResult.xlsx');

for i=3:length(FolderNames)-1
    str = char(FolderNames(i));%ACC AEB LKA
    FilePath = strcat(Path,'\',char(FolderNames(i))); 
    File = dir(fullfile(FilePath,'*.mat'));  % get all the file name 
    FileNames = {File.name}';
    for j=1:length(FileNames)          
%         readdata;
%         analysis;
%         result;
        [~,name,~] = fileparts(FileNames{j});
        result = ResultList{rem(j,3)+1};
        Array = {name,result};
        Sheet = str;
        
        xlswrite(ResultFile,Array,Sheet,strcat('A',num2str(j)));
    end
end
    