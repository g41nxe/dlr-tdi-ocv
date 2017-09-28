clear;
file = 'D:\Daten\1907\rot-50um-3';

[gather, spot] = load_tdi_files(file);

position = gather(:,1);
speed    = gather(:,2);
header   = spot{1};
spot     = spot{2};

pixelCount = header{2,2} - header{1,2} + 1;
lineCount  = header{3,2};
pixel      = round(pixelCount / 2);
lineFreq   = header{5,2};
pixelSize  = 0.00875; # millimeter

t = (10000 / lineFreq);

j = 1;
for i = 1:lineCount
  position_index      = round(i * t);
  
  # position doesn't exist
  if (position_index + 1 > numel(position)) 
    break;
  endif
  
  current_position = get_position(i, t, position);
  current_speed    = get_position(i, t, speed);
  
  # only store data in radius of pixelCount pixels
  if (abs(current_position) < 1
  # remove outlier
    && spot(pixel, i) < 5000   
  # remove backwards travel
    && current_speed > 0) 
    
    x(j) = current_position;      
    z(j++, :) = spot(:, i);      
  endif
    
endfor

#plot_contour(z);
plot_psf(x,z);