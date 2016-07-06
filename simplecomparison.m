%% Simple comparative analysis
%
% Given two samples, compare the following hypotheses:
%   - H0, null hypothesis (no differences between the means of the samples)
%   - H1, alternative hypothesis (differences between the means of the samples)

% DATA
% Insert the data column-wise. Example: 
%
%   Type 1     Type 2                 A = [65
%  ---------------------                   82
%    65         64                         81  
%    82         56                         ...  
%    81         71                         70];  
%    67         69
%    57         83         ->         B = [64
%    59         74                         56
%    66         59                         71  
%    75         82                         ...  
%    82         65                         79];
%    70         79

A = [16.03
    16.04
    16.05
    16.05
    16.02
    16.01
    15.96
    15.98
    16.02
    15.99];

B = [16.02
    15.97
    15.96
    16.01
    15.99
    16.03
    16.04
    16.02
    16.01
    16.00];

% Significance level 
alpha = input('Significance level (alpha)?   ');
sizeA = size(A,1);
sizeB = size(B,1);

%% CASE 1: variances are assumed identical 

Sp = sqrt((((sizeA-1)*var(A)) + ((sizeB-1)*var(B))) / (sizeA + sizeB - 2));
tstat = (mean(A) - mean(B)) / (Sp * sqrt(1/sizeA + 1/sizeB));
percentile = tinv(alpha/2, (sizeA+sizeB-2));

% Print results:
fprintf('------------------------ Results -------------------------\n');
fprintf('Data:\n');
fprintf('     Sp = %f\n', Sp);
fprintf('     Average population A = %f\n', mean(A));
fprintf('     Average population B = %f\n', mean(B));
fprintf('     S_1^2 = %f\n', var(A));
fprintf('     S_2^2 = %f\n', var(B));
fprintf('     t-statistic = %f\n', tstat);
fprintf('     n1 + n2 - 2 (DOF) = %f\n', (sizeA+sizeB-2));
fprintf('     Percentile (two-tail) = %f\n', abs(percentile));
fprintf('------------------------------------------------------------\n');
fprintf('Use this tool to compute the p-value:\n epitools.ausvet.com.au/content.php?page=t_dist\n');
pval = input('Insert p-value:   ');
fprintf('------------------------------------------------------------\n');
if alpha >= pval
    fprintf('P-value:   Null hypothesis is REJECTED!\n');
else
    fprintf('P-value:   Alternative hypothesis is REJECTED!\n');
end
if abs(tstat) > abs(percentile)
    fprintf('Table:   Null hypothesis is REJECTED!\n');
else
    fprintf('Table   Alternative hypothesis is REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');


%% CASE 2: variances are known and given

var1 = input('Variance population 1?   ')^2;
var2 = input('Variance population 2?   ')^2;
tstat = (mean(A) - mean(B)) / sqrt(var1/sizeA + var2/sizeB);
percentile = norminv(alpha/2);

% Print results:
fprintf('------------------------ Results -------------------------\n');
fprintf('Data:\n');
fprintf('     Variance population 1 = %f\n', var1);
fprintf('     Variance population 2 = %f\n', var2);
fprintf('     Z-statistic = %f\n', tstat);
fprintf('     Percentile (two-tail) = %f\n', abs(percentile));
fprintf('------------------------------------------------------------\n');
fprintf('Use this tool to compute the p-value:\n http://epitools.ausvet.com.au/content.php?page=n_dist\n');
pval = input('Insert p-value:   ');
if alpha >= pval
    fprintf('P-value:   Null hypothesis is REJECTED!\n');
else
    fprintf('P-value:   Alternative hypothesis is REJECTED!\n');
end
if abs(tstat) > abs(percentile)
    fprintf('Table:   Null hypothesis is REJECTED!\n');
else
    fprintf('Table   Alternative hypothesis is REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');

%% CASE 3: variances are different but need to be computed 

var1 = var(A);
var2 = var(B);
tstat = (mean(A) - mean(B)) / sqrt(var1/sizeA + var2/sizeB);
deg = (var1/sizeA + var2/sizeB)^2 / (((var1/sizeA)^2 / sizeA-1) + ((var2/sizeB)^2 / sizeB-1));
percentile = tinv(alpha/2, deg);

% Print the results:
fprintf('------------------------ Results -------------------------\n');
fprintf('Dati:\n');
fprintf('     Variance population 1 = %f\n', var1);
fprintf('     Varianza population 2= %f\n', var2);
fprintf('     t-statistic = %f\n', tstat);
fprintf('     DOF approximated = %f\n', deg);
fprintf('     Percentile (two-tail) = %f\n', abs(percentile));
fprintf('------------------------------------------------------------\n');
fprintf('Use this tool to compute the p-value: epitools.ausvet.com.au/content.php?page=t_dist\n');
pval = input('Insert p-value:   ');
fprintf('------------------------------------------------------------\n');
if alpha >= pval
    fprintf('P-value:   Null hypothesis is REJECTED!\n');
else
    fprintf('P-value:   Alternative hypothesis is REJECTED\n');
end
if abs(tstat) > abs(percentile)
    fprintf('Tabella:   Null hypothesis is REJECTED\n');
else
    fprintf('Tabella   Alternative hypothesis is REJECTED\n');
end
fprintf('------------------------------------------------------------\n');
