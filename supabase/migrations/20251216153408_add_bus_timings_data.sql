/*
  # Add comprehensive bus timings data

  1. Additional Bus Stops
    - PK Puram, Alarmaram, CTR (Central), Thangal, VIT Main Gate
  
  2. Additional Bus Services
    - Kanchipuram, VIT, Thabaram, Hariharan, TKB, Government Bus 9, etc.
  
  3. Approved Bus Timings
    - All provided timings inserted as approved
*/

INSERT INTO bus_stops (stop_name) VALUES
  ('PK Puram'),
  ('Alarmaram'),
  ('CTR (Central)'),
  ('Thangal'),
  ('VIT Main Gate')
ON CONFLICT (stop_name) DO NOTHING;

INSERT INTO bus_services (bus_name, route) VALUES
  ('Kanchipuram bus', 'Gudiyatham - Kanchipuram'),
  ('VIT bus', 'Gudiyatham - VIT Express'),
  ('Thabaram bus', 'Gudiyatham - Thabaram via Katpadi'),
  ('Hariharan bus', 'Gudiyatham - Vellore'),
  ('TKB', 'Gudiyatham - Arcot'),
  ('Government Bus 9', 'Gudiyatham - Katpadi'),
  ('Shree Andal', 'Gudiyatham - Vellore'),
  ('APL PRN', 'Gudiyatham - Vellore'),
  ('Beeyar', 'Gudiyatham - Vellore'),
  ('Krishna', 'Vellore - Gudiyatham'),
  ('16 M Bus', 'Vellore - Mahadevamalai'),
  ('Bihar', 'Vellore - Gym'),
  ('NMD', 'Vellore - Gym'),
  ('JDL Balamurugan', 'Arcot - Gudiyatham')
ON CONFLICT DO NOTHING;

DO $$
DECLARE
  v_kanchipuram_id uuid;
  v_vit_id uuid;
  v_thabaram_id uuid;
  v_hariharan_id uuid;
  v_tkb_id uuid;
  v_govt9_id uuid;
  v_shree_andal_id uuid;
  v_apl_prn_id uuid;
  v_beeyar_id uuid;
  v_krishna_id uuid;
  v_16m_id uuid;
  v_bihar_id uuid;
  v_nmd_id uuid;
  v_jdl_id uuid;
BEGIN
  SELECT id INTO v_kanchipuram_id FROM bus_services WHERE bus_name = 'Kanchipuram bus';
  SELECT id INTO v_vit_id FROM bus_services WHERE bus_name = 'VIT bus';
  SELECT id INTO v_thabaram_id FROM bus_services WHERE bus_name = 'Thabaram bus';
  SELECT id INTO v_hariharan_id FROM bus_services WHERE bus_name = 'Hariharan bus';
  SELECT id INTO v_tkb_id FROM bus_services WHERE bus_name = 'TKB';
  SELECT id INTO v_govt9_id FROM bus_services WHERE bus_name = 'Government Bus 9';
  SELECT id INTO v_shree_andal_id FROM bus_services WHERE bus_name = 'Shree Andal';
  SELECT id INTO v_apl_prn_id FROM bus_services WHERE bus_name = 'APL PRN';
  SELECT id INTO v_beeyar_id FROM bus_services WHERE bus_name = 'Beeyar';
  SELECT id INTO v_krishna_id FROM bus_services WHERE bus_name = 'Krishna';
  SELECT id INTO v_16m_id FROM bus_services WHERE bus_name = '16 M Bus';
  SELECT id INTO v_bihar_id FROM bus_services WHERE bus_name = 'Bihar';
  SELECT id INTO v_nmd_id FROM bus_services WHERE bus_name = 'NMD';
  SELECT id INTO v_jdl_id FROM bus_services WHERE bus_name = 'JDL Balamurugan';

  INSERT INTO bus_timings (bus_service_id, stop, time, runs_daily, status) VALUES
    (v_kanchipuram_id, 'PK Puram', '06:30', true, 'approved'),
    (v_vit_id, 'PK Puram', '06:45', true, 'approved'),
    (v_thabaram_id, 'PK Puram', '07:00', true, 'approved'),
    (v_hariharan_id, 'Alarmaram', '07:10', true, 'approved'),
    (v_tkb_id, 'CTR (Central)', '19:10', true, 'approved'),
    (v_tkb_id, 'Alarmaram', '07:20', true, 'approved'),
    (v_govt9_id, 'CTR (Central)', '19:20', true, 'approved'),
    (v_shree_andal_id, 'Alarmaram', '07:40', true, 'approved'),
    (v_apl_prn_id, 'Alarmaram', '08:02', true, 'approved'),
    (v_govt9_id, 'Alarmaram', '10:00', true, 'approved'),
    (v_beeyar_id, 'Alarmaram', '10:05', true, 'approved'),
    (v_govt9_id, 'CTR (Central)', '11:00', true, 'approved'),
    (v_govt9_id, 'CTR (Central)', '12:25', true, 'approved'),
    (v_krishna_id, 'CTR (Central)', '12:35', true, 'approved'),
    (v_tkb_id, 'Thangal', '13:45', true, 'approved'),
    (v_govt9_id, 'VIT Main Gate', '14:00', true, 'approved'),
    (v_16m_id, 'CTR (Central)', '14:00', true, 'approved'),
    (v_tkb_id, 'CTR (Central)', '14:10', true, 'approved'),
    (v_bihar_id, 'CTR (Central)', '14:30', true, 'approved'),
    (v_krishna_id, 'CTR (Central)', '15:40', true, 'approved'),
    (v_tkb_id, 'Thangal', '15:55', true, 'approved'),
    (v_beeyar_id, 'CTR (Central)', '16:15', true, 'approved'),
    (v_nmd_id, 'CTR (Central)', '17:05', true, 'approved'),
    (v_jdl_id, 'Thangal', '17:15', true, 'approved'),
    (v_jdl_id, 'Thangal', '17:55', true, 'approved'),
    (v_krishna_id, 'CTR (Central)', '18:00', true, 'approved'),
    (v_govt9_id, 'CTR (Central)', '18:10', true, 'approved'),
    (v_hariharan_id, 'CTR (Central)', '18:30', true, 'approved'),
    (v_tkb_id, 'CTR (Central)', '20:00', true, 'approved')
  ON CONFLICT DO NOTHING;
END $$;