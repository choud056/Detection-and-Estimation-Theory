function output_par=resample(particles,partSizeCDF,number)
output_par = zeros(size(particles));
for i=1:number
    uni = rand;
    if partSizeCDF(1) > uni
        x = 1;
    else
        for j=2:number
            if partSizeCDF(j) > uni && partSizeCDF(j-1) <= uni
                x = j;
                break;
            end
        end
    end
    output_par(:,i) = particles(:,x);
end
