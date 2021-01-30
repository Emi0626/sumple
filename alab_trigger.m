function alab_trigger(trigger_num, window, rect)
%% A funtion to call trigger
% Prepares white squares using Psychtoolbox so that the PyCorder software
% detects trigger "R[trigger_num]"
% Caution: this function does not Screen('Flip') nor WaitSecs(). 
% It simply prepares squares
% ex.)
% alab_trigger(1, window, rect)
% Input
% trigger_num: Number of trigger to output to PyCorder. 0 for all black
% window: window object created by Screen function
% rect: rect object created by Screen function
% for use, see trigger_test_functionalize.m
% Written by Shu Sakamoto, 2019/03/22, updated 2019/12/31

black = [0 0 0];
white = [255 255 255];

one_thirdX = rect(3)/3;
two_thirdx = one_thirdX * 2;
rect(4) = rect(4)-30; % the screen is taped on the bottom edge

len_rect = 50;
rect1 = [0                     rect(4)-len_rect len_rect              rect(4)]; 
rect2 = [one_thirdX-len_rect/2 rect(4)-len_rect one_thirdX+len_rect/2 rect(4)];
rect3 = [two_thirdx-len_rect/2 rect(4)-len_rect two_thirdx+len_rect/2 rect(4)];
rect4 = [rect(3)-len_rect      rect(4)-len_rect rect(3)               rect(4)];

if trigger_num == 0 % neutral
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, black, rect4); 

elseif trigger_num == 1
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, black, rect4); 
    
elseif trigger_num == 2
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, black, rect4);

elseif trigger_num == 3
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, black, rect4);
    
elseif trigger_num == 4
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, black, rect4);
    
elseif trigger_num == 5
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, black, rect4);

elseif trigger_num == 6
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, black, rect4);

elseif trigger_num == 7
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, black, rect4);
    
elseif trigger_num == 8
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, white, rect4); 

elseif trigger_num == 9
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, white, rect4); 

elseif trigger_num == 10
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, white, rect4); 

elseif trigger_num == 11
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, black, rect3); 
    Screen('FillRect', window, white, rect4); 
    
elseif trigger_num == 12
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, white, rect4); 

elseif trigger_num == 13
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, black, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, white, rect4); 

elseif trigger_num == 14
    Screen('FillRect', window, black, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, white, rect4); 

else
    Screen('FillRect', window, white, rect1); 
    Screen('FillRect', window, white, rect2); 
    Screen('FillRect', window, white, rect3); 
    Screen('FillRect', window, white, rect4); 
end	

end