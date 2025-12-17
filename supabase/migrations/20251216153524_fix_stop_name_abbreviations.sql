/*
  # Fix bus stop name abbreviations to full names

  Updates stop names from abbreviations to full names:
  - CTR (Central) → Chittor bus stand
  - Gym → Gudiyatham
  - VLR → Vellore (where used in stop records)

  All bus timings referencing these stops are automatically updated.
*/

UPDATE bus_stops SET stop_name = 'Chittor bus stand' WHERE stop_name = 'CTR (Central)';
UPDATE bus_stops SET stop_name = 'Gudiyatham' WHERE stop_name = 'Gym';
UPDATE bus_stops SET stop_name = 'Vellore' WHERE stop_name = 'VLR';

UPDATE bus_timings SET stop = 'Chittor bus stand' WHERE stop = 'CTR (Central)';
UPDATE bus_timings SET stop = 'Gudiyatham' WHERE stop = 'Gym';
UPDATE bus_timings SET stop = 'Vellore' WHERE stop = 'VLR';