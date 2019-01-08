%% init
CCCFlag=0;%CCC=zeros(1);
ACCFlag=0;%ACC=zeros(1);
LKAFlag=0;%LKA=zeros(1);
%% change testcase like below
testcase='CCC={30-30,60-60,90-90,120-120};ACC={60-60,30-120,120-30};';
% to testcase Flags and Arrays, to determine the no of runs
testcaseCell=regexp(testcase,';','split');
for i=1:length(testcaseCell)
    testcaseString=testcaseCell{i};
    if ~isempty(regexp(testcaseString,'CCC', 'once'))
        CCCFlag=1;
        CCCArray=String2Number(testcaseString);
    else if ~isempty(regexp(testcaseString,'ACC', 'once'))
            ACCFlag=1;
            ACCArray=String2Number(testcaseString);
            else if ~isempty(regexp(testcaseString,'LKA', 'once'))
                LKAFlag=1;
                LKAArray=String2Number(testcaseString);
                end
        end
    end
end
% till now, we get the numarray of CCC ACC and LKA like below
% CCCFlag=1;CCCArray=[30,30,60,60,90,90,120,120]
% ACCFlag=1;ACCArray=[60,60,30,30,120,120]
% LKAFlag=0;LKAArray=[]
%% 











