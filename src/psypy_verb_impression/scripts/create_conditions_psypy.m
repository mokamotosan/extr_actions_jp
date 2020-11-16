%% calculate distances from each PC to each words
% Before run this script
% 1. perfomen the correspondence analysis by the KHC
% 2. save the result as csv file.
% 3. copy the extracted verbs from the csv file.
clear; close all; clc;

%% set directories
conditionsdir = '../conditions';

%% read the verb file
[vname, vpath] = uigetfile('*.csv', 'select a verb list', [conditionsdir, filesep, '*verbs.csv'], 'MultiSelect', 'off');
verbTbl = readtable(fullfile(vpath, vname));

%% read the PCA results with categories
[pcaname, pcapath] = uigetfile('*.mat', 'select a file', ['../../quan_text_analysis/results', filesep, 'categories*.mat'], 'MultiSelect', 'off');
load(fullfile(pcapath, pcaname), 'T_traitq', 'T_coeff');

%% join the two tables
T_coeff = sortrows(T_coeff, 'RowNames');
T_traitq = sortrows(T_traitq, {'traitq_id'});
T_tmp = [T_coeff, T_traitq];

%% select questionnarie
numQs = 2; % most positive and negative Qs in each PC
% The 1st PC
T_tmp = sortrows(T_tmp, 1, 'descend');
Qs{1} = T_tmp.traitq{1};
QIDs{1} = T_tmp.traitq_id{1};
Cats{1} = T_tmp.pca_cat_id_q{1};
Qs{2} = T_tmp.traitq{20};
QIDs{2} = T_tmp.traitq_id{20};
Cats{2} = T_tmp.pca_cat_id_q{20};
% The 2nd PC
T_tmp = sortrows(T_tmp, 2, 'descend');
Qs{3} = T_tmp.traitq{1};
QIDs{3} = T_tmp.traitq_id{1};
Cats{3} = T_tmp.pca_cat_id_q{1};
Qs{4} = T_tmp.traitq{20};
QIDs{4} = T_tmp.traitq_id{20};
Cats{4} = T_tmp.pca_cat_id_q{20};
% The 3rd PC
T_tmp = sortrows(T_tmp, 3, 'descend');
Qs{5} = T_tmp.traitq{1};
QIDs{5} = T_tmp.traitq_id{1};
Cats{5} = T_tmp.pca_cat_id_q{1};
Qs{6} = T_tmp.traitq{20};
QIDs{6} = T_tmp.traitq_id{20};
Cats{6} = T_tmp.pca_cat_id_q{20};
% make a table
questionnarieTbl = table(Qs', QIDs', Cats', 'VariableNames', {'traitq', 'traitq_id', 'pca_cat_id_q'});

%% extract variables
verbs = verbTbl{:, 'verbs'};
traitq = questionnarieTbl{:, 'traitq'};
% traits_L = verbTbl{1:20, 'q_left'};
% traits_R = verbTbl{1:20, 'q_right'};
traitq_id = questionnarieTbl{:, 'traitq_id'};
verb_id = verbTbl{:, 'verb_id'};
negative_flag = verbTbl{:, 'negative_flag'};
pca_cat_id_v = verbTbl{:, 'pca_cat_id_v'};

%% make a condition file
nVerbs = length(verbs);
nQs = length(traitq);
conditionCell = cell(nVerbs*nQs, 6);
step = 1;
for iVerb = 1:nVerbs
    for iQ = 1:nQs
        conditionCell(step, 1) = verbs(iVerb);
        %conditionCell{step, 2} = [traits_L{iQ} '-' traits_R{iQ}];
        conditionCell{step, 2} = traitq{iQ};
        conditionCell{step, 3} = traitq_id(iQ);
        conditionCell{step, 4} = verb_id(iVerb);
        conditionCell{step, 5} = negative_flag(iVerb);
        conditionCell{step, 6} = pca_cat_id_v{iVerb};
        step = step + 1;
    end
end
conditionTbl = table(conditionCell(:,1), conditionCell(:,2), conditionCell(:,3), conditionCell(:,4), conditionCell(:,5), conditionCell(:,6), 'VariableNames', {'verbs', 'traitq', 'traitq_id', 'verb_id', 'negative_flag', 'pca_cat_id_v'});

%% save a condition file
[~, f, e] = fileparts(vname);
[savefile, savepath] = uiputfile('*.csv', 'Save File As...', fullfile(vpath, ['condition_' f e]));
writetable(conditionTbl, fullfile(savepath, savefile));