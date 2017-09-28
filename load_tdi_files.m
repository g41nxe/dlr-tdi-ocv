# - gather columns: position, speed
# - skip first 2 rows 
# - cut spot header
function [gather spot] = load_tdi_files(file);
  gather = dlmread(strcat(file, '.dat'));
  gather = gather(3:end,:);

  header      = cell(7,2);
  header{1,1} = '[FirstPixel]';
  header{2,1} = '[LastPixel]';
  header{3,1} = '[NrReadOuts]';
  header{4,1} = '[TDI-Stages]';
  header{5,1} = '[LineFreq]';
  header{6,1} = '[Date]';
  header{7,1} = '[Time]';

  spot_fid = fopen(strcat(file, '.spot'));

  for i = 1:numel(header)/2
    row         = fgetl(spot_fid);
    start       = numel(header{i,1}) + 1;
    length      = numel(row) - numel(header{i,1});
    header{i,2} = str2double(substr(row, start, length));
  end
  
  pixelCount = header{2,2} - header{1,2} + 1;
  lineCount  = header{3,2};
  
  # - one column per pixel
  # - probably binary ushort data
  # - empty row after header
  spot = cell(2,1);
  spot{1} = header;
  spot{2} = fread(spot_fid, [pixelCount, lineCount], 'ushort');

end