function [dataset labels individuals] = load_dataset()
%
%
% Author Gonzalo Martinez
%
MANOS_ARRIBA = 1;
CUCLILLAS = 2;
DCHA = 3;
icol = [MANOS_ARRIBA CUCLILLAS DCHA];
dd{1} = {'P1_1_1A' 'P3_1_1A' 'P2_1_1A' 'P3_2_1A' 'P1_1_1' 'P1_2_1' 'P2_1_1' 'P2_2_1' 'P3_1_1' 'P3_2_1'};
dd{2} = {'P3_1_2A' 'P2_1_2A' 'P1_1_2A' 'P2_2_2A' 'P1_1_2' 'P1_2_2' 'P2_1_2' 'P2_2_2' 'P3_1_2' 'P3_2_2'};
dd{3} = {'P2_1_3A' 'P1_1_3A' 'P3_1_3A' 'P1_2_3A' 'P1_1_3' 'P1_2_3' 'P2_1_3' 'P2_2_3' 'P3_1_3' 'P3_2_3'};
individuals = [];
labels = [];


for i=1:length(dd)
    rr{i} = zeros(0,60);
    idx=1:80;
    idx(mod(idx,4)==0) = [];
    for ip=1:length(dd{i})
%    for ip=length(dd)
        ff = dir(['../data/' dd{i}{ip} '*.csv']);
        ['../data/' dd{i}{ip} '*.csv']
        for is=1:length(ff)
            [p y t] = load_file(ff(is).name(1:end-4));
            iframes = find(y(:,icol(i))==1);
            disp(length(iframes));
            assert(~isempty(iframes));
            rr{i} = [rr{i} ; p(iframes,idx)];
            individuals = [individuals ; ...
                ones(size(p(iframes,idx),1),1)*extract_individual_id(ff(is).name)];
        end
    end
    data_i{i}=reshape(rr{i},[size(rr{i},1) 3 20]);
    data_i{i}=permute(data_i{i},[3 2 1]);
    labels = [labels; ones(size(data_i{i},3),1)*icol(i)];
end
dataset=cat(3,data_i{1},data_i{2},data_i{3});

function id = extract_individual_id(txt)
id = str2double(txt(find(txt=='_',1,'last')+2:end-4));