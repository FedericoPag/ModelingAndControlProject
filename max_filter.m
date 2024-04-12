function out = max_filter(in, times)
    out = in;

    for i=1:length(in)
        count = 0;
        for j=1:length(in)
            if (in(i)<in(j))
                count = count+1;
            end
        end
        if (count>=times)
            out(i) = 0;
        end
    end
end