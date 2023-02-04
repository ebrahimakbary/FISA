clc;
clear ;

func_no=1;    % No. of the problem

for run_no=1:10
    
    %% Problem Definition
    
    CostFunction=@(x, Nf) Cost(x, Nf);
    
    VarMin=-100;             % Decision Variables Lower Bound
    if func_no==7
        VarMin=-600;             % Decision Variables Lower Bound
    end
    if func_no==8
        VarMin=-32;             % Decision Variables Lower Bound
    end
    if func_no==9
        VarMin=-5;             % Decision Variables Lower Bound
    end
    if func_no==10
        VarMin=-5;             % Decision Variables Lower Bound
    end
    if func_no==11
        VarMin=-0.5;             % Decision Variables Lower Bound
    end
    if func_no==12
        VarMin=-pi;             % Decision Variables Lower Bound
    end
    if func_no==14
        VarMin=-100;             % Decision Variables Lower Bound
    end
    
    VarMax= -VarMin;             % Decision Variables Upper Bound
    
    if func_no==13
        VarMin=-3;             % Decision Variables Lower Bound
        VarMax= 1;             % Decision Variables Upper Bound
    end
    
    nVar =30;          % Number of Unknown Variables
    VarSize = [1 nVar]; % Unknown Variables Matrix Size
    
    MaxIt =300;        % Maximum Number of Iterations
    
    nPop =30;           % Population Size
    
    D=nVar;
    
    % Empty Structure for Individuals
    empty_individual.Position = [];
    empty_individual.Cost = [];
    
    % Initialize Population Array
    pop = repmat(empty_individual, nPop, 1);
    
    % Initialize Best Solution
    BestSol.Cost = inf;
    
    % Initialize Population Members
    for i=1:nPop
        pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
        pop(i).Cost= CostFunction(pop(i).Position , func_no);
        if pop(i).Cost < BestSol.Cost
            BestSol = pop(i);
        end
    end
    
    % Initialize Best Cost Record
    BestCosts = zeros(MaxIt,1);
    
    for it=1:MaxIt
        
        BBest = pop(1);
        Wworst = pop(1);
        for i=2:nPop
            if pop(i).Cost < BBest.Cost
                BBest = pop(i);
            end
            if pop(i).Cost > Wworst.Cost
                Wworst = pop(i);
            end
        end
        
        for i=1:nPop
            % Create Empty Solution
            newsol = empty_individual;
            
            newsol.Position =pop(i).Position+ rand(VarSize).*(BBest.Position - Wworst.Position);
            
            % Clipping
            newsol.Position = max(newsol.Position, VarMin);
            newsol.Position = min(newsol.Position, VarMax);
            
            % Evaluation
            newsol.Cost=  CostFunction(newsol.Position, func_no);
            
            % Comparison
            if newsol.Cost<pop(i).Cost
                pop(i) = newsol;
                if pop(i).Cost < BestSol.Cost
                    BestSol = pop(i);
                end
            end
        end
        
        % Store Record for Current Iteration
        BestCosts(it) = BestSol.Cost;
        
        % Show Iteration Information
        % disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
        
    end
    
    Cost_Rsult(1, run_no)=BestSol.Cost;
    Rsult(run_no,:)=BestCosts;
end
