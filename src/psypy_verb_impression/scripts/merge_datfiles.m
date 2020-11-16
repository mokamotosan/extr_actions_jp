clear; close all; clc;

%% set data and results directory
datadir = '../data';
resultdir = '../results';
conditiondir = '../conditions';

%% select data file(s)
[fname, fpath] = uigetfile('*.dat', 'select a file', [datadir, filesep, 'verb_impression_*.dat'], 'MultiSelect', 'on');
if ~iscell(fname)
    fname = {fname};
end

%% read data
nSubs = length(fname);
nVerbs = 360;
ratingsMat = NaN(nVerbs, nSubs);
subnames = cell(1, nSubs);

for iSub = 1:nSubs
    % ratings
    dataTbl = readtable(fullfile(fpath, fname{iSub}));
    ratingsMat(:, iSub) = dataTbl.ratings;
    % names of subjects
    C = strsplit(fname{iSub}, '_');
    subnames{iSub} = C{3};
end

% creat ratings table
ratingsTbl = array2table(ratingsMat, 'VariableNames', subnames);

%% create output
dataTbl.ratings = [];
outTbl = [dataTbl ratingsTbl table(mean(ratingsMat,2), 'VariableNames', {'ratings'})];

%% save data
[savefile, savepath] = uiputfile('*.dat', 'Save as...', fullfile(resultdir, ['merged' datestr(datetime, 'yyyymmddTHHMMSS') '.dat']));
writetable(outTbl, fullfile(savepath, savefile));