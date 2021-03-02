function [GE,ID]=getMetric(alpha,p,q)
n=length(p);
sumpi=0;
for i=1:n
    sumpi=sumpi+p(i)^alpha;
end
GE=(1/(1-alpha))*log2(sumpi);
sumpiqi=0;
for i=1:n
    sumpiqi=sumpiqi+(p(i)^alpha)*(q(i)^(1-alpha));
end
ID=(1/(1-alpha))*log2(sumpiqi);
end