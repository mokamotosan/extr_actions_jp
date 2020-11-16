function xysizeTbl = mybubbleplot(x, y)

%x = cell2mat(inTbl.ratings(1:30)); y = cell2mat(inTbl.ratings(31:60));

T = table([x, y]);
xyTbl = unique(T);
sizeM = NaN(height(xyTbl),1);
for row = 1:height(xyTbl)
    sizeM(row) = sum(and(T.Var1(:,1) == xyTbl.Var1(row,1), T.Var1(:,2) == xyTbl.Var1(row,2)));
end
sizeT = table(sizeM, 'VariableNames', {'size'});
xysizeTbl = [xyTbl, sizeT];
%subplot(2,3,1); scatter(xyTbl.Var1(:,1), xyTbl.Var1(:,2), xyTbl.size*10); title('Š´‚¶‚Ìˆ«‚¢-Š´‚¶‚Ì—Ç‚¢')