sum = 0;
thresh = 1.9;
for t=1:10
    sum = sum + sin(t);
    if (sum >= thresh)
        t
        break;
    end
end
        