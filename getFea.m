function data_fea=getFea(data,data_unit)
%测试数据集
data_len=length(data);
unit_num=data_len/data_unit;
data_fea=zeros(unit_num,4);
for i=1:unit_num
    tcp_unit=data((i-1)*data_unit+1:i*data_unit,2);
    udp_unit=data((i-1)*data_unit+1:i*data_unit,3);
    %方差 平均差
    %tcp
    m=mean(tcp_unit);
    data_fea(i,1)=var(tcp_unit);
    sum=0;
    for j=1:data_unit
        sum=sum+abs(tcp_unit(j)-m);
    end
    data_fea(i,2)=sum/data_unit;
    %udp
    m=mean(udp_unit);
    data_fea(i,3)=var(udp_unit);
    sum=0;
    for j=1:data_unit
        sum=sum+abs(udp_unit(j)-m);
    end
    data_fea(i,4)=sum/data_unit;
end
%0-1标准化
%data_fea=normal(data_fea);
end