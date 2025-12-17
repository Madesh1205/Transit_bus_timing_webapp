
/*
  # Fix RLS Policies for Anonymous Access

  1. Security
    - Update RLS policies to allow anon role (not just public role)
    - Maintain existing admin policies for authenticated users
    - Keep data access patterns: anyone can read approved timings and services
*/

DROP POLICY IF EXISTS "Public can read bus services" ON bus_services;
CREATE POLICY "Allow anonymous to read bus services"
  ON bus_services FOR SELECT
  TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS "Public can read bus stops" ON bus_stops;
CREATE POLICY "Allow anonymous to read bus stops"
  ON bus_stops FOR SELECT
  TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS "Public can read approved bus timings" ON bus_timings;
CREATE POLICY "Allow anonymous to read approved bus timings"
  ON bus_timings FOR SELECT
  TO anon, authenticated
  USING (status = 'approved');

DROP POLICY IF EXISTS "Public can insert bus timings" ON bus_timings;
CREATE POLICY "Allow anonymous to insert bus timings"
  ON bus_timings FOR INSERT
  TO anon, authenticated
  WITH CHECK (status = 'pending');
