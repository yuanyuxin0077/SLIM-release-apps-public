function [x, res, x_norm]= POCS(x,P,options)
%this script is the Projection onto convex sets algorithm (von Neumann's
%alternating projections) to solve the convex feasibility problem:
% find x s.t. x in the intersecion of p convex sets. May not work if one or
% more sets are not closed, convex.
%
% This script is included for illustration only to show what goes wrong
% when this is used when one wants to compute the projection onto an
% intersecion. Even if convex feasibility is all that is desired, Dykstra's
% algorithm will also solve this, often in less iterations.
%
% input:
%       x                   -   initial guess for convex feasibilityproblem
%       P                   -   contains projectors. P{1},P{2}...P{m} as generated by setup_constraint.m in folder :
%       options.
%           options.tol     -   tolerance based on residual as stopping condition
%           options.maxIt   -   maximum number of iterations
%           options.minIt   -   minimum number of iterations
%           options.feas_tol-   feasibility tolerance for warning message, not for stopping condition
%
% output:
%       x           -   result
%       res         -   relative residual
%       x_norm      -   norm of the solution vector at every iteration


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
tol   = 1e-4;
maxIt = 10;
minIt = 1;
feas_tol = 5e-2;
if exist('options','var') && ~isempty(options)
    if isfield(options,'tol'),      tol      = options.tol; end
    if isfield(options,'maxIt'),    maxIt    = options.maxIt; end
    if isfield(options,'minIt'),    minIt    = options.minIt; end
    if isfield(options,'feas_tol'), feas_tol = options.feas_tol; end
end

%% Input checks
% POCS can work with imaginary numbers and zeros, but in geophysical
% inverse problems the input and output should typically be real and
% positive. 
if isreal(x)==0
    disp('warning:input for POCS is not real')
end
if nnz(x)~=length(x)
    disp('warning: input of POCS contains ZEROS')
end

%% initialize
res_X=[];
p = length(P);
res(1)=inf;

%% main loop
i=1;
while (res(end)>tol && i<=maxIt) || i<minIt 
    x_old=x;
    
    % sequentially project onto each set
    for j=1:p
        x = P{j}(x);
    end
    i=i+1;
    
    %logging
    res(i)      = norm(x-x_old)/norm(x_old);
    x_norm(i)   = norm(x); %log the norm to detect blowing up solutions, in case nonconvex sets are used  
end

%% Output checks

%feasibility check
for cn=1:p
    temp=norm((P{cn}(x))-x);
    feas_err(cn)=temp/norm(x);
    if feas_err(cn)>feas_tol && temp>1000*eps
        disp(['constraint ',num2str(cn),' violates feasibility tolerance in POCS, error=',num2str(feas_err(cn))])
        disp(['res =',num2str(res)])
        disp(['||x|| =',num2str(x_norm)])
    end
end

if isreal(x)==0
    disp('warning: Result of POCS is not real')
end
if nnz(x)~=length(x)
    disp('warning: Result of POCS contains ZEROS')
end

end
