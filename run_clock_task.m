function run_clock_task(sub_num)
eval('clear all');
eval('web(''digit-span/index.html'',''-notoolbar'')');
run_task = 0;
while run_task == 0
    [isDown, secs, keyCode, deltaSecs] = KbCheck;
    if find(keyCode==1)==KbName('N')
        run_task = 1;
    end
end
temp=csvread('digit-span_results.csv');
csvwrite(sprintf('ExpSub%d-digitspan.csv',sub_num),temp);
Runexp;
end