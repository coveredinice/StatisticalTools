%% 1-way ANOVA Tool
%
% Given a factor with 'a' levels, ANOVA studies the influence of each level
% on the response variable. Useful to compare the following hypotheses:
%   - H0, null hypothesis: no difference between levels
%   - H1, alternative hypothesis: actual difference between levels

% Data and initialization 
obs = input('Number of observations?   ');
alpha = input('Insert the significance level (alpha):   ');
data = [9 12 10 8 15
        20 21 23 17 30
        6 5 8 16 7];
lev = size(data,2);

% 1-way ANOVA and percentile from the F-distribution table
[p, tbl, stats] = anova1(data);
percentile = finv((1-alpha),(lev-1),stats.df);

% Print results:
Fstat = input('F-statistics (read from ANOVA table):   ');
fprintf('------------------------ Results -------------------------\n');
fprintf('F-statistic analysis: \n', p);
fprintf('      F-statistic = %f\n', Fstat);
fprintf('      Percentile = %.3f\n', percentile);
if abs(Fstat) >= abs(percentile)
    fprintf('      Null hypothesis REJECTED!\n');
else
    fprintf('      Alternative hypothesis REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');
fprintf('P-value analysis: \n', p);
fprintf('      P-value = %.10f\n', p);
fprintf('      Significance level (alpha) = %.3f\n', alpha);
if alpha >= p
    fprintf('      Null hypothesis REJECTED!\n');
else
    fprintf('      Alternative hypothesis REJECTED!\n');
end
fprintf('------------------------------------------------------------\n');
