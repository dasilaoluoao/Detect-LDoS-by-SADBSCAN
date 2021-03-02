function data_fea=getFea(data,data_unit)
%�������ݼ�
data_len=length(data);
unit_num=data_len/data_unit;
data_fea=zeros(unit_num,4);
for i=1:unit_num
    tcp_unit=data((i-1)*data_unit+1:i*data_unit,2);
    udp_unit=data((i-1)*data_unit+1:i*data_unit,3);
    %���� ƽ����
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
%0-1��׼��
%data_fea=normal(data_fea);
end