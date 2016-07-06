%% Block Design Tool

% "Block design": a type of experiment to avoid the effects of a single 
% nuisance factor. 

a = input('Number of experiments?  ');
b = input('Numero of blocks?  ');
alpha = input('Significance level (alpha)?  ');

% Notice that each block corresponds to a column
data = [8 3 5 6 
    14 5 7 9
    15 16 9 3 
    17 9 2 6]';

% Total average
total_avg = sum(sum(data)) / (a*b);

% SST
SST = 0;
for i=1:a
    for j=1:b
        SST = SST + (data(i,j) - total_avg)^2;
    end
end

% SSBlocks
SSB = 0;
block_avg = sum(data,1) ./ a;
for j=1:b
    SSB = SSB + (block_avg(j) - total_avg)^2;
end
SSB = a * SSB;

% SSTreatments
SSTreat = 0;
exp_avg = sum(data,2) ./ b;
for i=1:a
    SSTreat = SSTreat + (exp_avg(i) - total_avg)^2;
end
SSTreat = SSTreat * b;

% SSE
SSE = SST - SSB - SSTreat;

% Mean squares e F-statistics
MSTreat = SSTreat / (a-1);
MSE = SSE / ((a-1)*(b-1));
Fstat = MSTreat / MSE;

% Percentile computation 
percentile = finv((1-alpha),(a-1),((a-1)*(b-1)));

% Results
fprintf('---------------------- Results: SS -----------------------\n');
fprintf('SS:\n');
fprintf('     Total = %f\n', SST)
fprintf('     Treatment = %f\n', SSTreat)
fprintf('     Blocks = %f\n', SSB)
fprintf('     Error = %f\n', SSE)
fprintf('------------------------------------------------------------\n');
fprintf('MS:\n');
fprintf('     Treatment = %f\n', MSTreat)
fprintf('     DOF (Treatment) = %f\n\n', (a-1));
fprintf('     Error = %f\n', MSE)
fprintf('     DOF (Error) = %f\n', (a-1)*(b-1));
fprintf('------------------------------------------------------------\n');
fprintf('F-statistic = %f\n', Fstat);
fprintf('Percentile = %f\n', abs(percentile));
fprintf('------------------------------------------------------------\n');
if Fstat > percentile
    fprintf('Table:    H0 is REJECTED!\n');
else 
    fprintf('Table:    H1 is REJECTED!\n');
end

fprintf('Compute the p-value using this tool:\nhttp://epitools.ausvet.com.au/content.php?page=f_dist\n\n');
pvalue = input('Insert p-value:  ');
if alpha >= pvalue
    fprintf('P-value:    H0 is REJECTED!\n');
else 
    fprintf('P-value:    H1 is REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');
