function op = opPadTop(A, new_n1, A_is_sizes)
% OPPADTOP               Returns ans operator that zero-pads on the top of the 1st axis of a vectorized
%                        input datacube that is the same size as A, such that the new size along the 
%                        1st dimension is new_n1
%
% optional: if A_is_sizes = true then treat A like a size vector, instead of a datacube

if exist('A_is_sizes','var') && (A_is_sizes == true)
    sA = A;
    dtype = 'double';
else
    sA = size(A);
    dtype = class(A);
end
clear A

old_n1 = sA(1);

if (old_n1 > new_n1)
    error('OPPAD: Padded size is smaller than original size');
end
    
n = prod(sA);
m = prod([new_n1 sA(2:end)]);
npad = new_n1 - old_n1;

subfunc_handle = @(x,mode) opPadTop_intrnl(n,m,old_n1,new_n1,npad,sA,dtype,x,mode);

op = opFunction(m,n,subfunc_handle); % return a SPOT operator using constructor opFunction


function y = opPadTop_intrnl(n,m,old_n1,new_n1,npad,sA,dtype,x,mode)

switch mode
    case 0
        y = {m,n,[0,0,0,0],{'opPadTop'}};
        
    case 1
        x = reshape(x,sA);
        y = [zeros([npad sA(2:end)],dtype); x];
        y = y(:);
        
    case 2
        x = reshape(x,[new_n1 sA(2:end)]);
        x(1:npad,:) = [];
        x = x(:);
        y = x;
end
