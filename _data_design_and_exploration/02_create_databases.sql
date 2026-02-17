-- ============================
-- DATA TABLES
-- ============================

CREATE TABLE IF NOT EXISTS aircraft (
  aircraft_id          serial PRIMARY KEY,
  registry_n_number    varchar UNIQUE,
  aircraft_make        varchar(50),
  aircraft_model       varchar(50),
  aircraft_serial      varchar(50),
  aircraft_total_time  int,
  aircraft_total_cycles int
);


CREATE TABLE IF NOT EXISTS operator (
  operator_id          serial PRIMARY KEY,
  operator_code        varchar(10) NOT NULL UNIQUE,
  operator_name        varchar(100)
);


CREATE TABLE IF NOT EXISTS ata_chapter (
  jasc_code            varchar(10) PRIMARY KEY,
  ata_description      varchar(200)
);


CREATE TABLE IF NOT EXISTS sdr_event (
  sdr_id                   serial PRIMARY KEY,
  operator_control_number  varchar(50),
  difficulty_date          date,
  submission_date          date,
  operator_designator      varchar(10),
  submitter_designator     varchar(10),
  submitter_type_code      varchar(10),
  receiving_region_code    varchar(10),
  receiving_district_office varchar(10),
  sdr_type                 varchar(10),
  nature_condition_a       varchar(50),
  nature_condition_b       varchar(50),
  nature_condition_c       varchar(50),
  precautionary_proc_a     varchar(50),
  precautionary_proc_b     varchar(50),
  precautionary_proc_c     varchar(50),
  precautionary_proc_d     varchar(50),
  stage_of_operation       varchar(50),
  how_discovered           varchar(50),
  discrepancy              text,

  -- Foreign keys
  aircraft_id              int REFERENCES aircraft(aircraft_id),
  operator_id              int REFERENCES operator(operator_id),
  jasc_code                varchar(10) REFERENCES ata_chapter(jasc_code),

  -- ENGINE (event-specific)
  engine_make              varchar(50),
  engine_model             varchar(100),
  engine_serial_number     varchar(100),
  engine_total_time        int,
  engine_total_cycles      int,

  -- PROPELLER (event-specific)
  propeller_make           varchar(50),
  propeller_model          varchar(100),
  propeller_serial_number  varchar(100),
  propeller_total_time     int,
  propeller_total_cycles   int,

  -- PART (event-specific)
  part_make                varchar(50),
  part_name                varchar(100),
  part_number              varchar(100),
  part_serial_number       varchar(100),
  part_condition           varchar(50),
  part_location            varchar(100),
  part_total_time          int,
  part_total_cycles        int,
  part_time_since          int,
  part_since_code          varchar(10),

  -- COMPONENT (event-specific)
  component_make           varchar(50),
  component_model          varchar(100),
  component_name           varchar(100),
  component_part_number    varchar(100),
  component_serial_number  varchar(100),
  component_location       varchar(100),
  component_total_time     int,
  component_total_cycles   int,
  component_time_since     int,
  component_since_code     varchar(10),

  -- STRUCTURAL LOCATION (event-specific)
  fuselage_station_from    varchar(50),
  fuselage_station_to      varchar(50),
  stringer_from            varchar(50),
  stringer_from_side       varchar(10),
  stringer_to              varchar(50),
  stringer_to_side         varchar(10),
  wing_station_from        varchar(50),
  wing_station_from_side   varchar(10),
  wing_station_to          varchar(50),
  wing_station_to_side     varchar(10),
  butt_line_from           varchar(50),
  butt_line_from_side      varchar(10),
  butt_line_to             varchar(50),
  butt_line_to_side        varchar(10),
  water_line_from          varchar(50),
  water_line_to            varchar(50),
  crack_length             varchar(50),
  number_of_cracks         int,
  corrosion_level          varchar(50),
  structural_other         text
);



-- ============================
-- CHECK FOR PROPER EXECUTION
-- ============================

-- Table Names . . .
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

--