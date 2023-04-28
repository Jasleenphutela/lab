clc
clear all
% input parameters as done previous in simplex and all
Var={'x_ 1','x_ 2','s_ 1','s_ 2','sol'};
cost=[-3 -5 0 0 0];
a=[1 3 1 0 ; 1 1 0 1 ];
b=[3;2];
A=[a b];
bv=[3 4];
zjcj=cost(bv)*A-cost;
simplex_table=[zjcj; A];
array2table(simplex_table,'VariableNames',Var)
%while loop ka aapko pta hi h kyu lagta h
%after that in dual simplex u have to firstle find the leaving variable
%.....woh kaise karege agar sol wale col. m koi entry -ve hai
% ....toh phir hum uska min find karge ...wahi hamra leaving variable aur  pvt row hogi 
Run=true;
while Run
sol=A(:,end);
if any(sol<0)
     fprintf(' The current BFS is not feasible \n');
      [leaving_val, pvt_row]= min(sol);
% ab ratio find find karna... check theory.... wahi kiya h same theory
% according ratio find karke min lena h
        for i=1:size(A,2)-1
            if A(pvt_row,i)<0
            ratio(i)=abs(zjcj(i)/A(pvt_row,i));
            else
            ratio(i)=inf;
            end
        end
     [entering_value,pvt_col]=min(ratio);  
% ab pvt col row dono pta hi h...toh next table ki entries karaoge woh same simplex jaisa hi process h 
 bv(pvt_row)=pvt_col;
 pvt_key=A(pvt_row, pvt_col);
 A(pvt_row,:)=A (pvt_row,:)./pvt_key;
 % row operation 
for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A (i, pvt_col).*A(pvt_row,:);
 end
end
 zjcj=cost(bv)*A-cost;
 next_table=[zjcj; A];
array2table(next_table,'VariableNames',Var)
else
    Run=false;
    fprintf('The table is feasible \n');

  fprintf('The final optimal value is % f \n',  zjcj(end));
    
end
end