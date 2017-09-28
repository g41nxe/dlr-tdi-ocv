# fix frequency differences of positionoer and camera
function position = get_position(i, t, gather) 
  position_index = i * t;
  position_index_rounded = round(i * t);
  next_position_rounded = round((i + 1) * t);
  
  position       = gather(position_index_rounded);
  next_position  = gather(next_position_rounded);
  position      += ((position_index - position_index_rounded) * (next_position - position));
end;