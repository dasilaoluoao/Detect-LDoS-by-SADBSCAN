function avg=getsvg(data,size)
len=length(data);
avg=zeros(1,len);
for i=1:len
    if mod(i,size)==1 
        avgi=mean(data(i:i+size-1,2));
    end
    avg(i)=avgi;  
end
end