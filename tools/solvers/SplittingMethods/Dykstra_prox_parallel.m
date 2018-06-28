function [x,res,evol_rel,nx,np,nz,xlog,zlog,plog]=Dykstra_prox_parallel(x,P,options)
%this script computes the projection of x0 onto the intersection of and
%arbitrary number of closed and convex sets. May still work in case
%nonconvex sets are used.
% Solves: min_x 0.5||x-x0||_2^2 s.t. x in intersection of m convex sets.
%
% This algorithm allows for parallel evaluation of the prox part
% (projections). This version does it in serial anyway, so no Matlab
% Parallel computing toolbox is required.
%
% input:
%       x                   -   vector to be projection onto the intersection
%       P                   -   contains projectors. P{1},P{2}...P{m} as generated by setup_constraint.m in folder :
%       options.
%           options.tol     -   tolerance based on residual as stopping condition
%           options.maxIt   -   maximum number of Parallel proximal Dykstra-like iterations
%           options.minIt   -   minimum number of Parallel proximal Dykstra-like iterations
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
if exist('options','var') && ~isempty(options)
    if isfield(options,'tol'),      tol      = options.tol; end
    if isfield(options,'maxIt'),    maxIt    = options.maxIt; end
    if isfield(options,'minIt'),    minIt    = options.minIt; end
    if isfield(options,'feas_tol'), feas_tol = options.feas_tol; end
    if isfield(options,'log_vec'),  log_vec  = options.log_vec; end
    if isfield(options,'evol_rel_tol'),  evol_rel_tol = options.evol_rel_tol; end
end

%% Input checks
% Dykstra like algorithms can work with imaginary numbers and zeros, but in geophysical
% inverse problems the input and output should typically be real and
% positive. 
if isreal(x)==0
    disp('warning: vector to be projected using parallel Dykstra is not real')
end
if nnz(x)~=length(x)
    disp('warning: input of Parallel Dykstra contains ZEROS')
end

%% Initialize
m       = length(P); %number of constraints
N       = length(x);
x_old   = x;
for i=1:m
    z{i} = x;
end
omega   = 1./m; %weights are hardcored here
res(1)  = inf;

nx=[]; nz=[]; np=[];
xlog=[]; plog{1}=[]; zlog{1}=[];
res_inc=0;
%% Main loop
n=1;
while (res(end)>tol && n<=maxIt) || n<minIt
    
    %evaluate prox
    for i=1:m %put this loop inside spmd for actual parallel proximal evaluation
        if log_vec==1; zlog{i}(:,n)=z{i}; end; %save z vectors
        p{i}=P{i}(z{i});
        if log_vec==1; plog{i}(:,n)=p{i}; end; %save p vectors
        np_temp(i)=norm(p{i});
    end
    
    %averaging step
    if n>1; x_old = x; end;
    x     = zeros(N,1);
    for i=1:m
        x = x + omega.*p{i};
    end
    if log_vec==1;  xlog(:,n)=x; end;
    
    %updating (contains a type of hardcoded over/under relaxation. Standard
    %choice is 1.00 for x, z and p. 1.25x+0.75x-1.0p seems work better for
    %most testproblems
    for i=1:m
        z{i} = 1.25*x + 0.75*z{i} - 1.0*p{i};
        %z{i} = x + z{i} - 1.0*p{i};
        nz_temp(i)=norm(z{i});
    end
    
    %logging
    evol_rel(n) = norm(x-x_old)/norm(x_old);
    if evol_rel(n)<evol_rel_tol &&  n>minIt
        disp('relative evolution to small, exiting parallel proximal Dykstra')
        break
    end
    nx(n) = norm(x);
    np(n) = max(np_temp);
    nz(n) = max(nz_temp);
    
    res(n)=0;
    for i=1:m %p vectors should converge towards eachother (if intersection is nonempty)
        res(n) = res(n) + norm(p{i}-x);
    end
    res(n)=res(n)/norm(x);
    
    %check if residual is decreasing
    if n>2
        if (res(n)-res(n-2))>0 && n>minIt
            disp('WARNING: parallel Dykstra residual is increasing')
            res_inc = 1;
            break
        end
    end
    
    n=n+1; %update iteration counter 
end

%enforce bound constraints
x=P{1}(x);

%% Output checks
%test relative feasibility of final point
for i=1:m
    temp=norm((P{i}(x))-x);
    feas_err(i)=temp/norm(x);
    if feas_err(i)>feas_tol && temp>1000*eps
        disp(['constraint ',num2str(i),' violates feasibility tolerance in Parallel Dykstra, error:',num2str(feas_err(i))])
        disp(['res =',num2str(res)])
        disp(['||x|| =',num2str(nx)])
        disp(['||z|| =',num2str(nz)])
        disp(['||p|| =',num2str(np)])
    end
end

if res_inc == 1;
    disp(['res=',num2str(res)]);
end

if isreal(x)==0
    disp('warning: Result of Parallel Dykstra is not real')
end
if nnz(x)~=length(x)
    disp('warning: Result of Parallel Dykstra contains ZEROS')
end

end