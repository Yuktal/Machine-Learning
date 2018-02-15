function [v1, v2, v3, v4, v5, v6, v7] = featureExtractor(record, vals)   
    b= [];v1=[];v2=[];v3=[];v4=[];v5=[];v6=[];v7=[];
    for i=record:18:size(vals,1)
        for index=1:size(vals(i,:),2)
            if(~isnan(vals(i,index)))
                 b =[b vals(i,index)];
            else
                break;
            end
        end
        v1 = [v1 min(b)];
        v2 = [v2 max(b)];
        diff = max(b)-min(b);
        v3 = [v3 diff];
        v4 = [v4 max(fft(b))];
        v5 = [v5 rms(b)];
        v6 = [v6 mean(b)];
        v7 = [v7 std(b)];
        b = [];
    end
end