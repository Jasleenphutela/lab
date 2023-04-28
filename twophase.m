 clc 
clear all
cost=[0 0 0 0 -1 -1 0];
a=[1 3 -1 0 1 0 ; 1 1 0 -1 0 1];
b=[3 ; 2];
A=[a b];
bv=[5 6];
zjcj=(cost(bv)*A-cost)
simplex=[A ; zjcj];
var={'x1','x2','s1','s2','a1','a2','sol'}
array2table(simplex,'variablenames',var)
run=true;
while run
    if any(zjcj(1:end-1)<0)
        fprintf('bfs is not optimal')
        z=zjcj(1:end-1)
        [ent_val,pvt_col]=min(z)
        column=A(:,pvt_col)
        if all(column<=0)
            error('unbounded sol')
        else
            sol=A(:,end)
            for i=1:size(A,1)
                if column(i)>0
                    ratio(i)=sol(i)./column(i)
                else
                    ratio(i)=inf
                end
            end
            [leav_var,pvt_row]=min(ratio)
        end
        bv(pvt_row)=pvt_col
        pvt_key=A(pvt_row,pvt_col)
       A(pvt_row,:)=A(pvt_row,:)/pvt_key
        for i=1:2
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:)
            end
        end
        zjcj=(cost(bv)*A)-cost
        new_table=[A;zjcj]
        array2table(new_table,'variablenames',var)
    else
        run=false
        fprintf('optimal sol is %f',zjcj(end))
    end
end

%2nd phase

AV=[5 6]
A(:,AV)=[]
cost1=[-3 -5 0 0 0];
bv=[2 1];
zjcj=(cost1(bv)*A-cost1)
simplex=[A ; zjcj];
var={'x1','x2','s1','s2','sol'}
array2table(simplex,'variablenames',var)
run=true;
while run
    if any(zjcj(1:end-1)<0)
        fprintf('bfs is not optimal')
        z=zjcj(1:end-1)
        [ent_val,pvt_col]=min(z)
        column=A(:,pvt_col)
        if all(column<=0)
            error('unbounded sol')
        else
            sol=A(:,end)
            for i=1:size(A,1)
                if column(i)>0
                    ratio(i)=sol(i)./column(i)
                else
                    ratio(i)=inf
                end
            end
            [leav_var,pvt_row]=min(ratio)
        end
        bv(pvt_row)=pvt_col
        pvt_key=A(pvt_row,pvt_col)
       A(pvt_row,:)=A(pvt_row,:)/pvt_key
        for i=1:2
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:)
            end
        end
        zjcj=(cost1(bv)*A)-cost1
        new_table=[A;zjcj]
        array2table(new_table,'variablenames',var)
    else
        run=false
        fprintf('optimal sol is %f',zjcj(end))
    end
end

