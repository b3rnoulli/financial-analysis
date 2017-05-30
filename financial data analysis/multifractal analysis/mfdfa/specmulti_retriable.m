function specmulti_retriable(data, filename)

retry=1;
repeat_counter = 0;
while retry == 1 || repeat_counter == 0
    specmulti(data, filename);
    repeat_counter = repeat_counter + 1;
    if retry == 1
        out=input('[specmulti_retriable] Powtorzyc wybor skal ? t/n [n] : ','s');
        if isempty(out) || out == 'n'
            retry = 0;
        end
        if out == 't'
            retry = 1;
        end
    end
end

end

