function normal_data=normal(data,new_max,new_min)
[m n]=size(data);
for i=1:n
    max_=max(data(:,i));
    min_=min(data(:,i));
    if max_==0
        for j=1:m
            normal_data(j,i)=0;
        end
    else
        for j=1:m
            normal_data(j,i)=((data(j,i)-min_)/(max_-min_))*(new_max-new_min)+new_min;
        end
    end
end
end