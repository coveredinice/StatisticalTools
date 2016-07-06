%% Latin Square Design tool

% Used to avoid the effects of two separate nuisance factors on the outcome
% of the experiment. 

size_tab = input('Data size (number of rows or columns)?  ');
alpha = input('Significance level (alpha)? ');

% Insert the data and the indexes separately. 
% Letters are matched to numbers: A = 1, B = 2, etc.
indexes = [3 4 1 2
        2 3 4 1
        1 2 3 4
        4 1 2 3];
    
data = [10 14 7 8
        7 18 11 8
        5 10 11 9
        10 10 12 14];
    
% Total mean
total = sum(sum(data)); 
mean_total = total / (size_tab * size_tab);

% SST
SST = 0;
for i=1:size_tab
    for k=1:size_tab
        for j=1:size_tab
            if indexes(i,k) == j
                SST = SST + (data(i,k) - mean_total)^2;
            end
        end
    end
end

% SSTreatments 
partial_letters = zeros(1,size_tab);
for letter=1:size_tab
    for i=1:size_tab
        for j=1:size_tab
            if indexes(i,j) == letter
                partial_letters(letter) = partial_letters(letter) + data(i,j);
            end
        end
    end
end
SSTreat = ((1/size_tab) * sum(partial_letters .^2)) - ((total^2)/(size_tab*size_tab));

% SSRows
partial_row = sum(data,2);
SSRows = ((1/size_tab) * sum(partial_row.^2)) - ((total^2)/(size_tab*size_tab));

% SSColumns
partial_column = sum(data,1);
SSCols = ((1/size_tab) * sum(partial_column.^2)) - ((total^2)/(size_tab*size_tab));

% SSE
SSE = SST - SSRows - SSCols - SSTreat;

% Mean squares
MSTreat = SSTreat / (size_tab-1);
MSE = SSE / ((size_tab-2)*(size_tab-1));

% Fstatistics
Fstat = MSTreat / MSE;

% Percentile
percentile = finv((1-alpha),(size_tab-1),((size_tab-2)*(size_tab-1)));

% Print the results
fprintf('---------------------- Results: SS -----------------------\n');
fprintf('SS:\n');
fprintf('     Total = %f\n', SST)
fprintf('     Treatment = %f\n', SSTreat)
fprintf('     Rows = %f\n', SSRows)
fprintf('     Columns = %f\n', SSCols)
fprintf('     Error = %f\n', SSE)
fprintf('------------------------------------------------------------\n');
fprintf('MS:\n');
fprintf('     Treatment = %f\n', MSTreat)
fprintf('     Error = %f\n\n', MSE)
fprintf('F-statistics = %f\n', Fstat);
fprintf('Degrees of Freedom (Treatment) = %f\n', (size_tab-1));
fprintf('Degrees of Freedom (Error) = %f\n', (size_tab-2)*(size_tab-1));
fprintf('Percentile= %f\n', abs(percentile));
if Fstat >= percentile
    fprintf('->Tabella:    H0 is REJECTED!\n');
else 
    fprintf('->Tabella:    H1 is REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');
fprintf('Use this tool to compute the p-value:\n http://epitools.ausvet.com.au/content.php?page=f_dist\n\n');
pvalue = input('Inserire p-value (da tool online):  ');
if alpha >= pvalue
    fprintf('->P-value:    H0 is REJECTED!!\n');
else 
    fprintf('->P-value:    H1 is REJECTED!!\n');
end
fprintf('------------------------------------------------------------\n');
