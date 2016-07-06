%% 2-way ANOVA or Factorial Design tool

% Insert number of replications and significance level
repl = input('Number of replications?  ');
alpha = input('Significance level (alpha)?  ');

% Data 
% Please notice: all data must be ordered column-wise. Example: 
%
%   y111    y112                 y111
%   y113    y114    becomes      y112
%                                y113
%                                y114 -> which means repl = 4
data = [74 79 82 99
        64 68 88 104
        60 73 92 96
        92 98 99 104
        86 104 108 110
        88 88 95 99
        99 104 108 114
        98 99 110 111
        102 95 99 107];
    
% Apply ANOVA
[p,tbl,stats] = anova2(data, repl);

% Values for the degrees of freedom
a = size(data,2);
b = (size(data,1)/repl);
n = repl;

% Compute the various percentiles 
percCols = finv((1-alpha),(a-1),(a*b*(n-1)));
percRows = finv((1-alpha),(b-1),(a*b*(n-1)));
percInter = finv((1-alpha),((a-1)*(b-1)),(a*b*(n-1)));

% Print the results:
fprintf('------------------------------------------------------------\n');
fprintf('Percentiles:\n', percRows);
fprintf('     Percentile (Columns) = %f\n', percCols);
fprintf('     DOF (Rows, b-1) = %f\n\n', (a-1));
fprintf('     Percentile (Rows) = %f\n', percRows);
fprintf('     DOF (Columns, a-1) = %f\n\n', (b-1));
fprintf('     Percentile (Interaction) = %f\n', percInter);
fprintf('     DOF (Interaction, (a-1)(b-1)) = %f\n\n', ((a-1)*(b-1)));
fprintf('------------------------ Results -------------------------\n');
FstatCOL = input('F-statistics COLUMNS (read from ANOVA table):   ');
if abs(FstatCOL) > abs(percCols)
    fprintf('\n->Table:   Null hypothesis on columns REJECTED!\n');
else
    fprintf('\n->Table   Alternative hypothesis on columns REJECTED!\n');
end

FstatROW = input('F-statistics ROWS (read from ANOVA table):   ');
if abs(FstatROW) > abs(percRows)
    fprintf('\n->Table:   Null hypothesis on rows REJECTED!\n');
else
    fprintf('\n->Table:   Alternative hypothesis on rows REJECTED!\n');
end

FstatINT= input('F-statistics interaction (read from ANOVA table):   ');
if abs(FstatINT) > abs(percInter)
    fprintf('\n->Table:   Null hypothesis on interaction REJECTED!\n');
else
    fprintf('\n->Table:   Alternative hypothesis on interaction REJECTED!\n');
end

% Print the three p-values
fprintf('\n->P-value (column, row, interaction) = \n');
display(p);
fprintf('------------------------------------------------------------\n');