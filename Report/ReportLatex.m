% This is the m file used to generate test report automatically
% using LaTeX to do the arrange
% written by CX

%% plot all the figure and save them
% code from jun
% read the relevant mat and excel file to draw pics and save them into eps
% format file, get prepared for the later pdf generation.
% mat file: named by testcondition, struct data
% testresult excel file: all the test name and the result.
Plot_Main;


%% general infomation
fname = mfilename();% m funtion name
completepath = mfilename('fullpath');% fullpath of mfile with mfilename
mpath = completepath(1:end-numel(fname));% fullpath of mfile without mfilename

doktitle = 'EP21 ADAS Test Report';
dokauthor = 'Robbin Snow';

%% the idea is: new a .tex file, then add LaTex Commands to it
% first new a .tex file

texfile = strcat(mpath,'\EP21_ADAS_Test_Report.tex');
%%%%%%%%%%%%%  HEADER
glossaryentries = '';

R2L_writeheader(texfile,doktitle,dokauthor,glossaryentries);
%% Write Title Page
R2L_Append2TexOutput(texfile,{...                         
                            '\begin{titlepage}';...
                            '\begin{figure}[h]';...
                            '\includegraphics[height=2cm]{SAICLogo}\hfill';...
                            '\includegraphics[height=2cm]{RMGLogo}\\';...
                            '\vskip 3cm';...
                            '\centering\Huge{EP21 ADAS Test Report}\\';...
                            '\vskip 0.5cm';...
                            '\centering\Huge{\today}';...
                            '\vskip 4cm';...
                            '\includegraphics[width=0.55\linewidth]{CHLogo}';...
                            '\end{figure}';...
                            '\end{titlepage}';})
                        
%%
R2L_Append2TexOutput(texfile,{...   %Result List label 9999                         
                            '\centerline{\Large{\textbf{Result List}}}';...
                            '\begin{CJK}{GBK}{kai}';...
                            '\begin{tabbing}';...
                            '\hspace*{30bp}\=blank\hspace*{30bp}\=testcasename\hspace*{250bp} \=result\kill';})
%% write the reference page
CaseCounter = 0;%init CaseCounter for case reference
resultFilePath = strcat(mpath,'Data\');
resultFileName = 'TestResult.xlsx';
    [~,~,resultDatacell] = xlsread(strcat(resultFilePath,resultFileName));
    for i = 1:length(resultDatacell)
        if(strcmpi(resultDatacell{i,2},'pass'))%if testresult pass, no sensitive to Caps
            R2L_Append2TexOutput(texfile,{...
            strcat([ ],'\>\textit{\underline{\ref{w',num2str(i),'}}} \>',resultDatacell{i,1},  '\>',resultDatacell{i,2},'\\')});
        else if(strcmpi(resultDatacell{i,2},'fail'))%if testresult pass, no sensitive to Caps
            R2L_Append2TexOutput(texfile,{...
            strcat([ ],'\>\textit{\underline{\ref{w',num2str(i),'}}} \>',resultDatacell{i,1},  '\>\textcolor[rgb]{1,0,0}{',resultDatacell{i,2},'}\\')});
            else
                R2L_Append2TexOutput(texfile,{...
                strcat([ ],'\>\textit{\underline{\ref{w',num2str(i),'}}} \>',resultDatacell{i,1},  '\>\textcolor[rgb]{1,1,0}{',resultDatacell{i,2},'}\\')});
            end
        end
    end
    % remmenber endding tabbing
R2L_Append2TexOutput(texfile,{'\end{tabbing}'});
R2L_Append2TexOutput(texfile,{'\end{CJK}'});   
%% This is for the while loop to display the TestResult
Path = strcat(pwd,'\Data');    %CX               % 设置数据存放的文件夹路径
Folder =dir(fullfile(Path));
FolderNames ={Folder.name}';                                %获得全部子文件夹名
for k=3:length(FolderNames)-1 %ACC AEB LKA  
    Path = strcat(pwd,'\Data');    %CX               % 设置数据存放的文件夹路径
    str = char(FolderNames(k)); % do it one by one
    R2L_Append2TexOutput(texfile,{strcat('\chapter{',str,'}')}); %New function, new capter
%     FilePath = strcat(Path,'\',char(FolderNames(k)));   
    resultFileName = 'TestResult.xlsx';
    [~,~,resultDatacell] = xlsread(strcat(Path,'\',resultFileName),str);
%     [~,sheet] = xlsfinfo(strcat(Path,'\',resultFileName));% get all the sheet name in excel
%     temp='';
%     for i =1:length(sheet)
%         
%         if isempty(resultDatacell)
%             if isempty(temp)
%                 temp = resultDatacell;
%             else
%                 temp = [temp;resultDatacell];
%             end
%         end
%     end
        
%     [~,~,resultDatacell] = xlsread(strcat(Path,'\',resultFileName));
    if length(resultDatacell)~=1
        for i = 1:length(resultDatacell)
            CaseCounter = CaseCounter + 1;
            R2L_Append2TexOutput(texfile,{'\newpage'});
            R2L_Append2TexOutput(texfile,{'%\begin{center}'});
            R2L_Append2TexOutput(texfile,{strcat('\section{','\label{w',num2str(CaseCounter),'}',resultDatacell{i,1},'}')});
            R2L_Append2TexOutput(texfile,{'%\end{center}'});
            % add text
            R2L_Append2TexOutput(texfile,{'\begin{CJK}{GBK}{kai}';...
                                    '\begin{tabbing}';...
                                    '\hspace*{40bp}\=blank\hspace*{80bp}\=Contents\kill';...
                                    strcat(32,'\>TestcaseName:\>',resultDatacell{i,1},'\\');...
                                    strcat(32,'\>Result:\>',resultDatacell{i,2},'\\');...
                                    strcat(32,'\>Vehicle:\>','EP21 2018','\\');...
                                    strcat(32,'\>Engineer:\>','Author','\\');...
                                    strcat(32,'\>Date:\>',date,'\\');...
                                    '\end{tabbing}';...
                                    '\end{CJK}';...
                                    });%add text         
        %% add figure       
            newcell = {...
            '\begin{figure}[ht] ';...
            '\centering';...
             strcat('\begin{subfigure}{\includegraphics[width=0.95\linewidth]{',str,'fig',num2str(10000+i),'.eps}','}');...
            '\end{subfigure}';...
            '\end{figure}';...
            };
        R2L_Append2TexOutput(texfile,newcell);
        end
    end

end  
%% 
R2L_Append2TexOutput(texfile,{'\end{document}'});


%% Auto PDF  Print
command = 'pdflatex EP21_ADAS_Test_Report.tex';
system(command)
