clc
clear all
format short
Cost=[2 10 4 5;6 12 8 11;3 9 5 7];
A=[12 25 20];
B=[25 10 15 5];
if sum(A)==sum(B)
    fprintf('Balanced \n');
else
   fprintf('Unbalanced \n'); 
   if sum(A)<sum(B)
       Cost(end+1,:)=zeros(1,size(B,2));
       A(end+1)=sum(B)-sum(A);
   elseif sum(B)<sum(A)
   Cost(:,end+1)=zeros(1,size(A,2));
       B(end+1)=sum(A)-sum(B);
   end
end
ICost=Cost;
X=zeros(size(Cost));  
[m,n]=size(Cost);  
BFS=m+n-1;   
for i=1:size(Cost,1)
    for j=1:size(Cost,2)
hh=min(Cost(:));   
[Row_index, Col_index]=find(hh==Cost); 
x11=min(A(Row_index),B(Col_index));
[Value,index]=max(x11);            
ii=Row_index(index);     
jj=Col_index(index);      
y11=min(A(ii),B(jj));        
X(ii,jj)=y11;
A(ii)=A(ii)-y11;
B(jj)=B(jj)-y11;
Cost(ii,jj)=Inf;
    end
end

fprintf('Initial BFS =\n');
IBFS=array2table(X);
disp(IBFS);
TotalBFS=length(nonzeros(X));
if TotalBFS==BFS
    fprintf('Initial BFS is Non-Degenerate \n');
else
    fprintf('Initial BFS is Degenerate \n');
end
InitialCost=sum(sum(ICost.*X));
fprintf('Initial BFS Cost is = %d \n',InitialCost);