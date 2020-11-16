clear; close all; clc;

%% set data and results directory
datadir = '../data';
resultdir = '../results';
conditiondir = '../conditions';

%% select a data file
[fname, fpath] = uigetfile('*.dat', 'select a file', ['..', filesep, '*.dat'], 'MultiSelect', 'off');

%% read the data file
dataTbl = readtable(fullfile(fpath, fname));
match_idx = strcmp(dataTbl.pca_cat_id_q, dataTbl.pca_cat_id_v);
dataTbl_match = dataTbl(match_idx, :);
dataTbl_notmatc = dataTbl(~match_idx, :);
ratings = abs(dataTbl.ratings);

%% dividing ratings into 9 paires
ratings11 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat1')), :);
ratings12 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat2')), :);
ratings13 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat3')), :);
ratings21 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat1')), :);
ratings22 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat2')), :);
ratings23 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat3')), :);
ratings31 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat1')), :);
ratings32 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat2')), :);
ratings33 = ratings(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat3')), :);

%% counting
edges = 0:3;

counts11 = histcounts(ratings11, edges);
counts12 = histcounts(ratings12, edges);
counts13 = histcounts(ratings13, edges);
counts21 = histcounts(ratings21, edges);
counts22 = histcounts(ratings22, edges);
counts23 = histcounts(ratings23, edges);
counts31 = histcounts(ratings31, edges);
counts32 = histcounts(ratings32, edges);
counts33 = histcounts(ratings33, edges);

%% counting shuffled data / KS-test (two-samples)
nShuffles = 1000;

counts11_shuffle = NaN(nShuffles, length(edges)-1);
counts12_shuffle = NaN(nShuffles, length(edges)-1);
counts13_shuffle = NaN(nShuffles, length(edges)-1);
counts21_shuffle = NaN(nShuffles, length(edges)-1);
counts22_shuffle = NaN(nShuffles, length(edges)-1);
counts23_shuffle = NaN(nShuffles, length(edges)-1);
counts31_shuffle = NaN(nShuffles, length(edges)-1);
counts32_shuffle = NaN(nShuffles, length(edges)-1);
counts33_shuffle = NaN(nShuffles, length(edges)-1);

ks2stat11 = NaN(nShuffles, 1);
ks2stat12 = NaN(nShuffles, 1);
ks2stat13 = NaN(nShuffles, 1);
ks2stat21 = NaN(nShuffles, 1);
ks2stat22 = NaN(nShuffles, 1);
ks2stat23 = NaN(nShuffles, 1);
ks2stat31 = NaN(nShuffles, 1);
ks2stat32 = NaN(nShuffles, 1);
ks2stat33 = NaN(nShuffles, 1);

for iShuffle = 1:nShuffles
    % shuffle
    ratings_shuffle = ratings;
    ratings_shuffle = ratings_shuffle(randi(size(ratings_shuffle, 1), [size(ratings_shuffle,1) 1]));
    
    % divide into 9 paires
    ratings11_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat1')));
    ratings12_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat2')));
    ratings13_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat1'), strcmp(dataTbl.pca_cat_id_q, 'cat3')));
    ratings21_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat1')));
    ratings22_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat2')));
    ratings23_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat2'), strcmp(dataTbl.pca_cat_id_q, 'cat3')));
    ratings31_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat1')));
    ratings32_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat2')));
    ratings33_shuffle = ratings_shuffle(and(strcmp(dataTbl.pca_cat_id_v, 'cat3'), strcmp(dataTbl.pca_cat_id_q, 'cat3')));
    
    % counting
    counts11_shuffle(iShuffle, :) = histcounts(ratings11_shuffle, edges);
    counts12_shuffle(iShuffle, :) = histcounts(ratings12_shuffle, edges);
    counts13_shuffle(iShuffle, :) = histcounts(ratings13_shuffle, edges);
    counts21_shuffle(iShuffle, :) = histcounts(ratings21_shuffle, edges);
    counts22_shuffle(iShuffle, :) = histcounts(ratings22_shuffle, edges);
    counts23_shuffle(iShuffle, :) = histcounts(ratings23_shuffle, edges);
    counts31_shuffle(iShuffle, :) = histcounts(ratings31_shuffle, edges);
    counts32_shuffle(iShuffle, :) = histcounts(ratings32_shuffle, edges);
    counts33_shuffle(iShuffle, :) = histcounts(ratings33_shuffle, edges);
    
    % KS-test2
    [~,~,ks2stat11(iShuffle)] = kstest2(ratings11, ratings11_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat12(iShuffle)] = kstest2(ratings12, ratings12_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat13(iShuffle)] = kstest2(ratings13, ratings13_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat21(iShuffle)] = kstest2(ratings21, ratings21_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat22(iShuffle)] = kstest2(ratings22, ratings22_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat23(iShuffle)] = kstest2(ratings23, ratings23_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat31(iShuffle)] = kstest2(ratings31, ratings31_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat32(iShuffle)] = kstest2(ratings32, ratings32_shuffle, 'Tail', 'Smaller');
    [~,~,ks2stat33(iShuffle)] = kstest2(ratings33, ratings33_shuffle, 'Tail', 'Smaller');
    
end
ks2stat11_mean = mean(ks2stat11);
ks2stat12_mean = mean(ks2stat12);
ks2stat13_mean = mean(ks2stat13);
ks2stat21_mean = mean(ks2stat21);
ks2stat22_mean = mean(ks2stat22);
ks2stat23_mean = mean(ks2stat23);
ks2stat31_mean = mean(ks2stat31);
ks2stat32_mean = mean(ks2stat32);
ks2stat33_mean = mean(ks2stat33); 
% Dn,m,alpha: n=m=40, alpha=0.05, two-side -> 12/40=0.3
% Dn,m,alpha: n=m=40, alpha=0.005 (Bonfferroni), one-side ->14/40=0.35

%% visulalize ratings and shuffled ratings
figure('Name', fname);
subplot(3,3,1); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts11_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts11); ylim([0 40]); title(ks2stat11_mean);
subplot(3,3,4); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts12_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts12); ylim([0 40]); title(ks2stat12_mean);
subplot(3,3,7); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts13_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts13); ylim([0 40]); title(ks2stat13_mean);
subplot(3,3,2); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts21_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts21); ylim([0 40]); title(ks2stat21_mean);
subplot(3,3,5); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts22_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts22); ylim([0 40]); title(ks2stat22_mean);
subplot(3,3,8); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts23_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts23); ylim([0 40]); title(ks2stat23_mean);
subplot(3,3,3); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts31_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts31); ylim([0 40]); title(ks2stat31_mean);
subplot(3,3,6); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts32_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts32); ylim([0 40]); title(ks2stat32_mean);
subplot(3,3,9); hold on; histogram('BinEdges', edges, 'BinCounts', mean(counts33_shuffle)); histogram('BinEdges', edges, 'BinCounts', counts33); ylim([0 40]); title(ks2stat33_mean);

% save fig
[~, f] = fileparts(fname);
saveas(gcf, fullfile(fpath, [f '_shuffle.png']));

%% visualize ratings and uniform distribution
% uniform ratings
ratings_uniform = [zeros(13,1); ones(13,1); ones(13,1)*2];
% counting
counts_uniform = histcounts(ratings_uniform, edges);
% KS-test2
[~,~,ks2stat11_uniform] = kstest2(ratings11, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat12_uniform] = kstest2(ratings12, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat13_uniform] = kstest2(ratings13, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat21_uniform] = kstest2(ratings21, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat22_uniform] = kstest2(ratings22, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat23_uniform] = kstest2(ratings23, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat31_uniform] = kstest2(ratings31, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat32_uniform] = kstest2(ratings32, ratings_uniform, 'Tail', 'Smaller');
[~,~,ks2stat33_uniform] = kstest2(ratings33, ratings_uniform, 'Tail', 'Smaller');
% Two-side, Dn,m,alpha: n=40, m=39, alpha=0.05 -> 1.36*sqrt(79/(40*39))=0.3060
% One-side, Dn,m,aplha: n=40, m=39, alpha=0.005 (Bonferroni) -> 1.63*sqrt(79/(40*39)) = 0.3668

figure('Name', fname);
subplot(3,3,1); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts11); ylim([0 40]); title(ks2stat11_uniform);
subplot(3,3,4); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts12); ylim([0 40]); title(ks2stat12_uniform);
subplot(3,3,7); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts13); ylim([0 40]); title(ks2stat13_uniform);
subplot(3,3,2); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts21); ylim([0 40]); title(ks2stat21_uniform);
subplot(3,3,5); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts22); ylim([0 40]); title(ks2stat22_uniform);
subplot(3,3,8); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts23); ylim([0 40]); title(ks2stat23_uniform);
subplot(3,3,3); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts31); ylim([0 40]); title(ks2stat31_uniform);
subplot(3,3,6); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts32); ylim([0 40]); title(ks2stat32_uniform);
subplot(3,3,9); hold on; histogram('BinEdges', edges, 'BinCounts', counts_uniform); histogram('BinEdges', edges, 'BinCounts', counts33); ylim([0 40]); title(ks2stat33_uniform);

% save fig
[~, f] = fileparts(fname);
saveas(gcf, fullfile(fpath, [f '_uniform.png']));

%% TODO: individual analyses

% % category
% T_tmp = innerjoin(inTbl_match, T_pca_cat);
% inTbl_match = sortrows(inTbl_match, 7);
% ratings_match = abs(reshape(cell2mat(inTbl_match.ratings), 40, []));
% figure(); boxplot(ratings_match);
% 
% % traitq
% inTbl_match = sortrows(inTbl_match, 4);
% ratings_match = abs(reshape(cell2mat(inTbl_match.ratings), 20, []));
% figure(); boxplot(ratings_match);
% 
% % verb
% inTbl_match = sortrows(inTbl_match, 5);
% ratings_match = abs(reshape(cell2mat(inTbl_match.ratings), 40, []));
% figure(); boxplot(ratings_match);

% TODO: impression-verb vs. verb-impression

%% TODO: population analyses
% TODO: match vs. non-match
% TODO: impression-verb vs. verb-impression

%% create a matrix
% totalNumVerbs = size(unique(inTbl.verb_id), 1);
% totalNumQs = size(unique(inTbl.traitq_id), 1);
% inTbl = sortrows(inTbl, [4 5]);
% ratings = reshape(cell2mat(inTbl.ratings), totalNumVerbs, totalNumQs);
% labels = unique(inTbl.traitq);
% 
% my_ratings_pca(ratings, labels);

%% find verbs with weak effects on all tratis.
% verbTbl = sortrows(unique(inTbl(:, {'verbs', 'verb_id', 'pca_cat'})), 2);
% qTbl = sortrows(unique(inTbl(:, {'questionnarie', 'q_id'})), 2);
% vt = verbTbl(~all(abs(ratingMat)<=2,2),:);
% pca_cat = categorical(vt.pca_cat);
% countcats(pca_cat)

% %% create verb list
% ratingTbl = table(ratingMat(:,1), ratingMat(:,2), ratingMat(:,3), ratingMat(:,4), ratingMat(:,5), ratingMat(:,6),...
%                       'RowNames', verbTbl.verbs); % questionnarie ID is in clumns

%% assign each verb to a questionnarie
% [max_val, max_idx] = max(ratingMat, [], 2);
% [min_val, min_idx] = min(ratingMat, [], 2);
% T1 = table(qTbl.questionnarie(max_idx), 'VariableNames', {'questionnarie_max'});
% T2 = table(qTbl.q_id(max_idx), 'VariableNames', {'q_id_max'});
% T3 = table(max_val, 'VariableNames', {'rate_max'});
% T4 = table(qTbl.questionnarie(min_idx), 'VariableNames', {'questionnarie_min'});
% T5 = table(qTbl.q_id(min_idx), 'VariableNames', {'q_id_min'});
% T6 = table(min_val, 'VariableNames', {'rate_min'});
% verbTbl = [verbTbl, T1, T2, T3, T4, T5, T6];

%verbTbl(verbTbl.rate_max == abs(verbTbl.rate_min),:) = []; % 異なる質問におなじ得点（絶対値）をつけた組み合わせは除外

                  
%% comparison of ratings between the original form and the negative form
% figure();
% questionnarie = unique(inTbl.questionnarie);
% for iQ = 1:length(questionnarie)
%     q = questionnarie{iQ};
%     x = cell2mat(inTbl.ratings(and(strcmp(inTbl.questionnarie, q), inTbl.negative_flag == 0)));
%     y = cell2mat(inTbl.ratings(and(strcmp(inTbl.questionnarie, q), inTbl.negative_flag == 1)));
%     xysizeTbl = mybubbleplot(x, y);
%     subplot(2,3,iQ); scatter(xysizeTbl.Var1(:,1), xysizeTbl.Var1(:,2), xysizeTbl.size*10); 
%     xlabel('rating for original form'); ylabel('rating for negative form'); xlim([-3 3]); ylim([-3 3]);
%     title(q); 
% end

%% histogram
% figure();   
% questionnarie = unique(inTbl.questionnarie);
% for iQ = 1:length(questionnarie)
%     q = questionnarie{iQ};
%     x = cell2mat(inTbl.ratings(and(strcmp(inTbl.questionnarie, q), inTbl.negative_flag == 0)));
%     y = cell2mat(inTbl.ratings(and(strcmp(inTbl.questionnarie, q), inTbl.negative_flag == 1)));
%     edges = -3.5:1:3.5;
%     subplot(2,3,iQ); histogram(x, edges); hold on; histogram(y, edges);
%     xlabel('ratings'); title(q); 
% end