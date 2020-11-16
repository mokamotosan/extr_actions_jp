clear; close all; clc;

%% set directories
conditiondir = '../conditions';
datadir = '../data';

%% read the condition file
[cname, cpath] = uigetfile('*.xlsx', 'select a file', [conditiondir, filesep, 'condition*.xlsx'], 'MultiSelect', 'off');
conditionTbl = readtable(fullfile(cpath, cname));

%% read the log file
% TODO: 前セッションが２つ以上の場合に対応させる
[dname, dpath] = uigetfile('*.csv', 'select a file', [datadir, filesep, 'verb_impression_*.csv']);

verbs_c = {};
questionnarie_c = {};

fid = fopen(fullfile(dpath, dname), 'r', 'n', 'UTF-8');
line_in = fgetl(fid); % skip the first line
step = 1;
while ~feof(fid)
    line_in = fgetl(fid);
    line_c = strsplit(line_in, ',');
    verbs_c{step} = line_c{1};
    questionnarie_c{step} = line_c{2};
    step = step + 1;
end
fclose('all');

dataTbl = table(verbs_c', questionnarie_c', 'VariableNames', {'verbs', 'questionnarie'});

%% add q_id and verb_id to the data table
dataTbl = innerjoin(dataTbl, conditionTbl);
dataTbl = sortrows(dataTbl, [4, 3]);

%% difference set
difsetTbl = setdiff(conditionTbl, dataTbl);
difsetTbl = sortrows(difsetTbl, [4, 3]);

%% save the difference set table as an extra condition file
[~, f, e] = fileparts(cname);
[savefile, savepath] = uiputfile('*.xlsx', 'Save File As...', fullfile(cpath, [f '_extra' e]));
if isfile(fullfile(cpath, [f '_extra' e]))
    delete(fullfile(cpath, [f '_extra' e]));
end
writetable(difsetTbl, fullfile(savepath, savefile));