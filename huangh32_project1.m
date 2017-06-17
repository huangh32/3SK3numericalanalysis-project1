clc;
clear;
close all;

A=imread('la_la_land.jpg');%%read an image from computer to workspace
I=rgb2gray(A);%change rgb to gray scale
I=im2double(A);%%change data type of the image

grey=rgb2gray(I);%change to grey
figure;
imshow(grey);
title('IMAGE');%original image


[R,C]=size(grey);%define row & column
%%pick the first element for row and column
pick_row_1=grey(1:R,1);

%A+B
for row = 1:R
    row1 = grey(row,1);%%row1=the first element for that row
    for column = 2:C
        if column == 2
            Row_S(row,column) = row1 + grey(row,column);
        else
            Row_S(row,column) = Row_S(row,column-1)+grey(row,column);
        end
    end
end


%A+C
pick_column_1=grey(1,1:C);

for column=1:C
    column1=grey(1,column);
    for row=2:R
        if row==2
            Col_S(row,column)=column1+grey(row,column);
        else 
            Col_S(row,column)=grey(row,column)+Col_S(row-1,column);
        end
    end
end

%%get sum
table=zeros(R,C);
table(1:R,1)=Col_S(1:R,1);
table(1,1:C)=Row_S(1,1:C);

for row = 2:R
    for column = 2:C
        table(row,column)=grey(row,column)+table(row-1,column-1)+Row_S(row,column-1)+Col_S(row-1,column);%%bot right+top left+top right+bot left
    end
end

get1 = [50,50,333,333];
%[Sample_SR,Sample_SC,N_Columns,N_Rows] = get1;
%%find an area in R=(50,70),C=(70,100)
Value = round(get1);
Sample_SR = Value(2);%start of row
Sample_SC = Value(1);%start of col
N_Rows = Value(4);
N_Columns = Value(3);%%round(rand()*150,1);
Sample_ER = Sample_SR+N_Rows;%%sample row end
Sample_EC = Sample_SC+N_Columns;%%sample col end

Sum1 = table(Sample_ER,Sample_EC)-table(Sample_ER,Sample_SC)-table(Sample_SR,Sample_EC)+table(Sample_SR,Sample_SC);

Sample_Avg = Sum1/(N_Rows*N_Columns);
figure;
imshow(grey(Sample_SR:Sample_ER,Sample_SC:Sample_EC));
title('sample image');


%%match part


for i=1:R-N_Rows
    for j=1:C-N_Columns
        V1 = table(i,j)+table(i+N_Rows,j+N_Columns)-table(i,j+N_Columns)-table(i+N_Rows,j);
        Match_Avg = V1/(N_Rows*N_Columns);
        if ( abs(Match_Avg - Sample_Avg) < 0.000000002 )
            figure;
            imshow(grey(i:i+N_Rows,j:j+N_Columns));
            title('macth image');
        end
    end
end


     
        
        


