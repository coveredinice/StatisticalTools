%% Regression tool
% AKA performs regression and evaluates it

alpha = input('Significance level?  ');
k = input('Number of independent variables (x)?  ');

% Data. Important: last column is always the response (y). Each observation
% corresponds to a column

data = [193 1.6 851
        230 15.5 816
        172 22.0 1058
        91 43.0 1201
        113 33.0 1357
        125 40.0 1115];

% Produce a suitable table specifying which are the observation columns
% and which is the response column

table = table(data(:,2),data(:,3), data(:,1),'VariableNames',{'x1','x2','y'});
mdl = fitlm(table);
n = size(data,1);
%% CASE 1: MODEL EVALUATION

% Mean squares, F-statistic and percentile
MSR = mdl.SSR / k;
MSE = mdl.SSE / (n-k-1);
Fstat = MSR / MSE;
percentile = finv((1-alpha),k,(n-k-1));

% Print results:
fprintf('---------------------- Risultati -----------------------\n');
fprintf('SS:\n');
fprintf('     Total (T) = %f\n', mdl.SST)
fprintf('     Regression (R) = %f\n', mdl.SSR)
fprintf('     Error (E) = %f\n', mdl.SSE)
fprintf('------------------------------------------------------------\n');
fprintf('R^2 normal and adjusted:\n');
display(mdl.Rsquared);
fprintf('------------------------------------------------------------\n');
fprintf('Estimation of sigma^2 = %f\n', (mdl.SSR / (n-k)));
fprintf('------------------------------------------------------------\n');
fprintf('MS:\n');
fprintf('     Regression (R) = %f\n', MSR)
fprintf('     Error (E) = %f\n', MSE)
fprintf('     Degrees of freedom Regression (R) = %f\n', k)
fprintf('     Degrees of freedom Error (R) = %f\n', (n-k-1))
fprintf('------------------------------------------------------------\n');
fprintf('Statistics:\n');
fprintf('     F-statistic = %f\n', Fstat)
fprintf('     Critical region limit = %f\n', percentile)
if Fstat >= percentile
    fprintf('Table:\n      Null hypothesis is REJECTED!\n')
else 
    fprintf('Table:\n      Null hypothesis is REJECTED!\n')
end
fprintf('\n\n------------------------------------------------------------\n');
mdl
pval = input('Insert p-value (from the model):  ');
if alpha >= pval
    fprintf('P-value (model):\n      Null hypothesis is REJECTED!.\n')
else 
    fprintf('P-value (model):\n      Null hypothesis is REJECTED!.\n')
end
fprintf('------------------------------------------------------------\n');

%% CASE 2: evaluation of a single Beta coefficient

icoef = input('Index of the coefficient to test:  ');
tab = mdl.Coefficients;
tstat = tab{icoef,3};
pvalue = tab{icoef,4};
percentile = tinv(alpha/2, (n-k-1));

fprintf('-------------------- Results -----------------------\n');
if abs(tstat) > abs(percentile)
    fprintf('->Table:   Coefficient is necessary (null hypothesis rejected)\nPercentile = %f\n', percentile);
else
    fprintf('->Table:   Coefficient is useless (alternative hypothesis rigettata)\nPercentile = %f\n', percentile);
end
if alpha >= pvalue
    fprintf('->P-value (coeff.):   Coefficient is necessary (null hypothesis rejected)\nPercentile = %f\n', percentile);
else
    fprintf('->P-value (coeff.):    Coefficient is useless (alternative hypothesis rigettata)\nPercentile = %f\n', percentile);
end
fprintf('-------------------------------------------------------------\n');

%% SPECIAL CASE: 1 independent and 1 dependent variables. 
% Data must be inserted in this section of the code!

alpha = input('Significance level:  ');
k = input('Number of independent variables (x):   ');

% DATI. As before, the last column corresponds to the response 
data = [193 851
        230 816
        172 1058
        91 1201
        113 1357
        125 1115];

sum1 = 0;
meanX = mean(data(:,1));
meanY = mean(data(:,2));
for i=1:size(data,1)
    sum1 = sum1 + ((data(i,1) - meanX) * (data(i,2) - meanY));
end
den = 0;
for i=1:size(data,1)
    den = den + (data(i,1) - meanX)^2;
end
beta1 = sum1 / den;
beta0 = meanY - (beta1 * meanX);

% Results:
fprintf('---------------------- Results -----------------------\n');
fprintf('Values:\n');
fprintf('     Mean X = %f\n', meanX)
fprintf('     Mean Y = %f\n', meanY)
fprintf('     Numerator (beta1) = %f\n', sum1)
fprintf('     Demp,omatpr (beta1) = %f\n', den)
fprintf('     Beta1 = %f\n', beta1)
fprintf('     Beta0 = %f\n', beta0)
fprintf('     Variance (sigma^2) = = %f\n', beta1)
fprintf('------------------------------------------------------------\n');
fprintf('To obtain additional information, digit "mdl" now: \n');
table = table(data(:,1), data(:,2),'VariableNames',{'x1','y'});
mdl = fitlm(table);