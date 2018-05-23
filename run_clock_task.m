function run_clock_task(sub_num)
%This function runs the non-temporal clock task, and then three working
%memory tasks. (Michael Hess - April '18)

save('sub_num','sub_num');
eval('clear all');
load('sub_num');

%Non-temporal Clock Task
Runexp;

which_tasks = randperm(3);

tasks = {'digit-span','multisource','ravens'};

try
    rand_tasks = Shuffle(tasks);
catch
    rand_tasks = shuffle(tasks);
end

for task_num = 1:3
    
    task = rand_tasks(task_num);
    task = task{1};
    
    eval('web(sprintf(''%s/index.html'',task),''-notoolbar'')');
    
    try
        temp_table=readtable(sprintf('%s_results.csv',task));
        writetable(temp_table,sprintf('data/ExpSub%d-%s.csv',sub_num,task));
    end
    
    run_task = 0;
    while run_task == 0
        [isDown, secs, keyCode, deltaSecs] = KbCheck;
        if find(keyCode==1)==KbName('-_')
            WaitSecs(0.1)
            run_task = 1;
        end
    end
    
end

end