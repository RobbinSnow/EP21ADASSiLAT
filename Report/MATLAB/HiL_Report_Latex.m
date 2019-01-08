% This is the main function of EP21 ADAS report m file
% with little change, this can also be used on other conditions
% for autonomous report generation

cd('C:\Users\CaoXing\Desktop\report_latex');
%%% This gives the Path where the .m file is stored

fname=mfilename();% m funtion name
completepath=mfilename('fullpath');% fullpath of mfile with mfilename
mpath=completepath(1:end-numel(fname));% fullpath of mfile without mfilename

doktitle='EP21 ADAS HIL Report';
dokauthor='Caoxing';

%% the idea is: new a .tex file, then add LaTex Commands to it
% first new a .tex file
texfile='C:\Users\CaoXing\Desktop\report_latex\EP21_ADAS_HIL_Report.tex';
%%%%%%%%%%%%%  HEADER
glossaryentries={...
                '% Glossary Entries'
                '\newglossaryentry{potato}{name={potato},plural={potatoes},';...
                'description={starchy tuber}}';...
                '\newglossaryentry{cabbage}{name={cabbage},';...
                'description={vegetable with thick green or purple leaves}}';...
                '\newglossaryentry{turnip}{name={turnip},';...
                'description={round pale root vegetable}}';...
                '\newglossaryentry{carrot}{name={carrot},';...
                'description={orange root}}';...
                '% and Acronyms'
                '\newacronym{MS}{MS}{Microsoft}';...
                '\newacronym{CD}{CD}{Compact Disc}';...
                '\newacronym{PC}{PC}{Personal Computer}';...
                };
% in the subfunction below to set the paper setup
R2L_writeheader(texfile,doktitle,dokauthor,glossaryentries)

%%%%%%%%%
R2L_Append2TexOutput(texfile,{...
                            '\centerline{\Large{\textbf{Result List}}}';...
                            '\begin{CJK}{GBK}{kai}';...
                            '\begin{tabbing}';...
                            '\hspace*{30bp}\=blank\hspace*{30bp}\=testcasename\hspace*{200bp} \=result\kill';})
%% Read Data From Excel

%% write all Testrusults
resultFilePath='C:\Users\CaoXing\Desktop\report_latex\Data\';
resultFileName='TestResult.xlsx';
[~,~,resultDatacell]=xlsread(strcat(resultFilePath,resultFileName));
for i=1:length(resultDatacell)
    R2L_Append2TexOutput(texfile,{...
        strcat([ ],'\>\textit{\underline{\ref{w',string(i),'}}} \>',resultDatacell{i,1},  '\>',resultDatacell{i,2},'\\')});
end
% remmenber endding tabbing
R2L_Append2TexOutput(texfile,{'\end{tabbing}'});
R2L_Append2TexOutput(texfile,{'\end{CJK}'});
%% This is for the while loop to display the TestResult
for i=1:length(resultDatacell)
    R2L_Append2TexOutput(texfile,{'\newpage'});
    R2L_Append2TexOutput(texfile,{strcat('\section{',resultDatacell{i,1},'}')});
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
    %%plot figure and save them in temp file
    %get data from .csv file
    csvFileName=resultDatacell{i,1};
    csvFileFullPath=strcat(resultFilePath,csvFileName,'.csv');
    data=csvread(csvFileFullPath,1,0);
    [row,col]=size(data);
    fid=fopen(csvFileFullPath);
    csvtitle = textscan(fid, '%s',col,'delimiter', ',');
    fclose(fid);
    csvstructdata=struct();
    for j=1:col
        csvstructdata=setfield(csvstructdata,char(csvtitle{1}(j)),data(:,j));
    end
%%
        x=csvstructdata.T_Stamp;
        Vx=csvstructdata.Vx;
        SetSpd=csvstructdata.SetSpd;
        OnSw=csvstructdata.OnSw;
        SetSw=csvstructdata.SetSw;
        SpdDecSw=csvstructdata.SpdDecSw;
        SpdIncSw=csvstructdata.SpdIncSw;
        ACCSysSt=csvstructdata.ACCSysSt;
        Ax=csvstructdata.Ax;
        ACCReqVa=csvstructdata.ACCReqVa;
        hplo=figure(10001);
        plot(x,Vx,x,SetSpd,'linewidth',3);
        xlabel('Time/s','fontsize',36);
        ylabel('V/(km/h)','fontsize',36);
        legend('Vx','SetSpd');
        grid on;
        set(hplo,'Position',[200 100 800 250])
        set(hplo,'PaperSize',[19 7.5])
        set(hplo,'PaperPosition',[-0.5 0.5 20 6])
        title('Vehicle Speed','fontsize',36);
        print(hplo,'-dpdf','C:\Users\CaoXing\Desktop\report_latex\R2Lfigures\fig10001.pdf','')
        close(figure(10001));
        
        hplo=figure(10002);
        plot(x,Vx,x,SetSpd);
        xlabel('Time/s');
        ylabel('V/(km/h)');
        legend('Vx','SetSpd');
        grid on;
        set(hplo,'Position',[200 100 800 250])
        set(hplo,'PaperSize',[19 7.5])
        set(hplo,'PaperPosition',[-0.5 0.5 20 6])
        title('Vehicle Speed');
        print(hplo,'-dpdf','C:\Users\CaoXing\Desktop\report_latex\R2Lfigures\fig10002.pdf','')
        close(figure(10002));
        
        hplo=figure(10003);
        plot(x,Vx,x,SetSpd);
        xlabel('Time/s');
        ylabel('V/(km/h)');
        legend('Vx','SetSpd');
        grid on;
        set(hplo,'Position',[200 100 800 250])
        set(hplo,'PaperSize',[19 7.5])
        set(hplo,'PaperPosition',[-0.5 0.5 20 6])
        title('Vehicle Speed');
        print(hplo,'-dpdf','C:\Users\CaoXing\Desktop\report_latex\R2Lfigures\fig10003.pdf','')
        close(figure(10003));
        
        hplo=figure(10004);
        plot(x,Vx,x,SetSpd);
        xlabel('Time/s');
        ylabel('V/(km/h)');
        legend('Vx','SetSpd');
        grid on;
        set(hplo,'Position',[200 100 800 250])
        set(hplo,'PaperSize',[19 7.5])
        set(hplo,'PaperPosition',[-0.5 0.5 20 6])
        title('Vehicle Speed');
        print(hplo,'-dpdf','C:\Users\CaoXing\Desktop\report_latex\R2Lfigures\fig10004.pdf','')
        close(figure(10004));

%%        
    newcell={...
    strcat('\label{w',string(i),'}');...
    '\begin{figure}[h!] ';...
    '\centering ';...
    '\subfigure{\includegraphics[width=120mm]{R2Lfigures/fig10001.pdf}} ';...
    '\subfigure{\includegraphics[width=120mm]{R2Lfigures/fig10002.pdf}} ';...
    '\subfigure{\includegraphics[width=120mm]{R2Lfigures/fig10003.pdf}} ';...
    '\subfigure{\includegraphics[width=120mm]{R2Lfigures/fig10004.pdf}} ';...
    '\end{figure}  ';...
    };
R2L_Append2TexOutput(texfile,newcell);
end


%% 
R2L_Append2TexOutput(texfile,{'\end{document}'});
