function ip = peaksN(x,choice)
% peaksN(X) picks the peaks of a sequence.
 
if nargin < 2
   choice = 'max'; % default 
end
switch lower(choice)
   case {'max'}
      ip = find(sign(-sign(diff(sign(diff(x)))+0.5)+1))+1;
   case {'min'}
      ip = find(sign(-sign(diff(sign(diff(-x)))+0.5)+1))+1;
   otherwise
      warning('Default search of local maximum !');
      ip = find(sign(-sign(diff(sign(diff(x)))+0.5)+1))+1;
end;
