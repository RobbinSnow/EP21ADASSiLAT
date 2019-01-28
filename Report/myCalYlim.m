function [myYlim,myTick]=myCalYlim(channels)
for i=1:size(channels,2)
    ymax(i)=max(channels((21:end),[i]));
    ymin(i)=min(channels((21:end),[i]));
end
allmax = double(max(ymax));
allmin = double(min(ymin));
allscale = [200,100,50,30,20,10,5,2,1,0.5,0.2,0.1,0.05];
Yrange = allmax-allmin;
if allmax==allmin
    myYlim=[allmin-1.1,allmax+1.1];
else
    Gap=Yrange*0.1;
    myYlim=[allmin-Gap,allmax+Gap];
end

Nscale = (Yrange*1.1)./[200,100,50,30,20,10,5,2,1,0.5,0.2,0.1,0.05];
Ntemp=abs(Nscale-4);
minNtemp = min(Ntemp);
index=min(find(Ntemp==minNtemp));
myscale=allscale(index);
myTick =(ceil(myYlim(1)/myscale)*myscale:myscale:ceil(myYlim(2)/myscale)*myscale);
