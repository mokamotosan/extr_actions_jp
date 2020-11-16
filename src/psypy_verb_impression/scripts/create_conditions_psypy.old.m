%% calculate distances from each PC to each words
% Before run this script
% 1. perfomen the correspondence analysis by the KHC
% 2. save the result as csv file.
% 3. copy the extracted verbs from the csv file.
clear; close all; clc;

%% set directories
conditionsdir = '../conditions';

%% read the original file
[fname, fpath] = uigetfile('*.xlsx', 'select a file', [conditionsdir, filesep, 'verbs_questionnarie.xlsx'], 'MultiSelect', 'off');
data = readtable(fullfile(fpath, fname));

%% extract variables
verbs = data{:, 'verbs'};
traits = data{1:20, 'questionnarie'};
traits_L = data{1:20, 'q_left'};
traits_R = data{1:20, 'q_right'};
trait_id = data{1:20, 'q_id'};
verb_id = data{:, 'verb_id'};

%% make a condition file
nVerbs = length(verbs);
nTraits = length(traits);
conditionCell = cell(nVerbs*nTraits, 4);
step = 1;
for iVerb = 1:nVerbs
    for iTrait = 1:nTraits
        conditionCell(step, 1) = verbs(iVerb);
        conditionCell{step, 2} = [traits_L{iTrait} '-' traits_R{iTrait}];
        conditionCell{step, 3} = trait_id(iTrait);
        conditionCell{step, 4} = verb_id(iVerb);
        step = step + 1;
    end
end
conditionTbl = table(conditionCell(:,1), conditionCell(:,2), conditionCell(:,3), conditionCell(:,4), 'VariableNames', {'verbs', 'questionnarie', 'q_id', 'verb_id'});

%% save a condition file
[~, f, e] = fileparts(fname);
[savefile, savepath] = uiputfile('*.xlsx', 'Save File As...', fullfile(fpath, ['condition_' f e]));
writetable(conditionTbl, fullfile(savepath, savefile));