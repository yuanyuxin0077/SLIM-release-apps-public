function [x,res,evol_rel,nx,xlog]=Dykstra_cyclic(x,P,options)
%this script computes the projection of x0 onto the intersection of and
%arbitrary number of closed and convex sets. May still work in case
%nonconvex sets are used.
% Solves: min_x 0.5||x-x0||_2^2 s.t. x in intersection of m convex sets.
%
%
% input:
%       x                   -   vector to be projection onto the intersection
%       P                   -   contains projectors. P{1},P{2}...P{m} as generated by setup_constraint.m in folder :
%       options.
%           options.tol     -   tolerance based on residual as stopping condition
%           options.maxIt   -   maximum number of Dykstra iterations
%           options.minIt   -   minimum number of Dykstra iterations
%           options.log_vec -   if (=1), saves all vectors at every iteration for analysis purposes.
%           options.feas_tol-   feasibility tolerance for warning message, not for stopping condition
%           options.evol_rel_tol- tolerance on relative evolution between iterations: exit if norm(x-x_old)/norm(x_old) becomes too small
%
% output:
%       x           -   result
%       res         -   relative residual
%       prog_rel    -   relative evolution (movement) per iteration

% Author: Bas Peters
%         Seismic Laboratory for Imaging and Modeling
%         Department of Earth, Ocean, and Atmosperic Sciences
%         The University of British Columbia
%
% Date:January 2016.

% You may use this code only under the conditions and terms of the
% license contained in the file LICENSE provided with this source
% code. If you do not agree to these terms you may not use this
% software.

% If you have any questions, errors or disappointing results, email
% (bpeters {at} eos.ubc.ca)

%% Parse options
tol      = 1e-4;
maxIt    = 10;
minIt    = 1;
feas_tol = 5e-2;
log_vec  = 0;
evol_rel_tol = 1e-4;
verbosity = 1;
if exist('options','var') && ~isempty(options)
    if isfield(options,'tol'),      tol      = options.tol; end
    if isfield(options,'maxIt'),    maxIt    = options.maxIt; end
    if isfield(options,'minIt'),    minIt    = options.minIt; end
    if isfield(options,'feas_tol'), feas_tol = options.feas_tol; end
    if isfield(options,'log_vec'),  log_vec  = options.log_vec; end
    if isfield(options,'evol_rel_tol'),  evol_rel_tol = options.evol_rel_tol; end
    if isfield(options,'verbosity'), verbosity = options.verbosity; end
end

function print(str)
    if verbosity > 0
        disp(str);
    end
end

%% Input checks
% Dykstra like algorithms can work with imaginary numbers and zeros, but in geophysical
% inverse problems the input and output should typically be real and
% positive. 
if isreal(x)==0 
    print('warning: vector to be projected using cyclic Dykstra is not real')
end
if nnz(x)~=length(x)
    print('warning: input of cyclic Dykstra contains ZEROS')
end

%% Initialize
m       = length(P); %number of constraints
N       = length(x);
x_old   = x;
clear x
for i=1:m+1
    x{i} = x_old;
    y{i} = zeros(length(x_old),1);
end
res(1)  = inf;
nx=[];
res_inc = 0;

%% Main loop
n=1;
while (res(end)>tol && n<=maxIt) || n<minIt
    
    %step 1
    x{1} = x{end};
    
    %step 2
    for i=1:m
        x{i+1} = P{i}(x{i}-y{i+1});
    end
    
    y_old = y;
    %step 3
    for i=1:m
        y{i+1} = x{i+1} - (x{i}-y_old{i+1});
    end
    
    %logging
    evol_rel(n) = norm(x{end}-x_old)/norm(x_old);
    x_old = x{end};
    
    if evol_rel(n)<evol_rel_tol &&  n>minIt
        print('relative evolution to small, exiting cyclic Dykstra')
        break
    end
    nx(n) = norm(x{end});
    
    res(n)=0;
    mean_x = mean(cell2mat(x),2);
    for i=1:m %p vectors should converge towards eachother (if intersection is nonempty)
        res(n) = res(n) + norm(x{i}-mean_x);
    end
    res(n)=res(n)/norm(mean_x);
    
    %check if residual is decreasing
    if n>2
        if (res(n)-res(n-2))>0 && n>minIt
            print('WARNING: cyclic Dykstra residual is increasing')
            res_inc = 1;
            break
        end
    end
    
    n=n+1; %update iteration counter 
end

%set output
x = x{end};

%enforce bound constraints
x=P{1}(x);

%% Output checks
%test relative feasibility of final point
for i=1:m
    temp=norm((P{i}(x))-x);
    feas_err(i)=temp/norm(x);
    if feas_err(i)>feas_tol && temp>1000*eps
        print(['constraint ',num2str(i),' violates feasibility tolerance in cyclic Dykstra, error:',num2str(feas_err(i))])
        print(['res =',num2str(res)])
        print(['||x|| =',num2str(nx)])
    end
end

if res_inc == 1;
    print(['res=',num2str(res)]);
end

if isreal(x)==0
    print('warning: Result of cyclic Dykstra is not real')
end
if nnz(x)~=length(x)
    print('warning: Result of cyclic Dykstra contains ZEROS')
end
print(['res=',num2str(res)]);
end


