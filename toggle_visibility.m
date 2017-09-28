function toggle_visibility(this, b, h)

  if (strcmp(get(h, 'visible'), "on"))
    set(h, 'visible', 'off');
    set(this, 'String', 'Show Gauss');
  else
    set(h, 'visible', 'on');
    set(this, 'String', 'Hide Gauss');
  endif
    
end