function run_clock_task(sub_num)
%This function runs the non-temporal clock task, and then three working
%memory tasks. (Michael Hess - April '18)

eval('clear all');

%Non-temporal Clock Task
% Runexp;

which_tasks = randperm(3);

for i = length(which_tasks)
    
    if which_tasks(i) == 1
        
        %Digit-Span Task
        eval('web(''digit-span/index.html'',''-notoolbar'')');        
        run_task = 0;
        while run_task == 0
            [isDown, secs, keyCode, deltaSecs] = KbCheck;
            if find(keyCode==1)==KbName('N')
                run_task = 1;
            end
        end
        temp=csvread('digit-span_results.csv');
        csvwrite(sprintf('data/ExpSub%d-digitspan.csv',sub_num),temp);
        
    elseif which_tasks(i) == 2
        
        %Multi-source Task
        eval('web(''multisource-master/index.html'',''-notoolbar'')');        
        run_task = 0;
        while run_task == 0
            [isDown, secs, keyCode, deltaSecs] = KbCheck;
            if find(keyCode==1)==KbName('N')
                run_task = 1;
            end
        end
        temp=csvread('multisource_results.csv');
        csvwrite(sprintf('data/ExpSub%d-multisource.csv',sub_num),temp);
        
    else
        
        %Ravens Task
        eval('web(''multisource-master/index.html'',''-notoolbar'')');        
        run_task = 0;
        while run_task == 0
            [isDown, secs, keyCode, deltaSecs] = KbCheck;
            if find(keyCode==1)==KbName('N')
                run_task = 1;
            end
        end
        temp=csvread('ravens_results.csv');
        csvwrite(sprintf('data/ExpSub%d-ravens.csv',sub_num),temp);
        
    end
    
end

end