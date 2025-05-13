--Receptionist table
CREATE TABLE receptionist (
    receptionist_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50),
    first_name VARCHAR(10),
    last_name VARCHAR(10),
    email VARCHAR(15),
    phone_number INT
);

-- Table to store receptionist information
CREATE TABLE receptionist (
    receptionist_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each receptionist
    username VARCHAR(50),                           -- Login username
    password VARCHAR(50),                           -- Login password
    first_name VARCHAR(10),                         -- First name of the receptionist
    last_name VARCHAR(10),                          -- Last name of the receptionist
    email VARCHAR(15),                              -- Email address
    phone_number INT                                -- Phone number (consider using VARCHAR for better flexibility)
);

-- Table to store admin information
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique identifier for each admin
    username VARCHAR(50),                           -- Login username
    password VARCHAR(50),                           -- Login password
    first_name VARCHAR(10),                         -- First name of the admin
    last_name VARCHAR(10),                          -- Last name of the admin
    email VARCHAR(15),                              -- Email address
    phone_number INT                                -- Phone number (consider using VARCHAR)
);

-- Table to store doctor information
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique identifier for each doctor
    username VARCHAR(50),                           -- Login username
    password VARCHAR(50),                           -- Login password
    first_name VARCHAR(10),                         -- First name of the doctor
    last_name VARCHAR(10),                          -- Last name of the doctor
    email VARCHAR(30),                              -- Email address
    phone_number VARCHAR(10)                        -- Phone number (stored as string for formatting)
);

-- Table to store patient information
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique identifier for each patient
    first_name VARCHAR(50),                         -- First name
    last_name VARCHAR(50),                          -- Last name
    dob DATE,                                       -- Date of birth
    contact_number VARCHAR(15),                     -- Contact number
    Street_address VARCHAR(100),                    -- Street address
    registration_date DATE,                         -- Date the patient was registered
    registered_by INT,                              -- Receptionist who registered the patient
    FOREIGN KEY (registered_by) REFERENCES receptionist(receptionist_id) -- Foreign key reference
);

-- Table to store diagnosis and prescription details
CREATE TABLE diagnoses (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique identifier for each diagnosis record
    patient_id INT NOT NULL,                            -- Patient receiving the diagnosis
    diagnosis_date DATE NOT NULL,                       -- Date of diagnosis
    diagnosis_description TEXT,                         -- Description of diagnosis
    item_name VARCHAR(50) NOT NULL,                     -- Name of prescribed item (e.g., medicine)
    quantity_prescribed INT NOT NULL,                   -- Quantity of the item prescribed
    prescription_details TEXT,                          -- Detailed prescription instructions
    examined_by INT NOT NULL,                           -- Doctor who examined the patient
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),         -- Patient foreign key
    FOREIGN KEY (item_name) REFERENCES inventory(item_name),         -- Inventory item foreign key
    FOREIGN KEY (examined_by) REFERENCES doctors(doctor_id)          -- Doctor foreign key
);

-- Table to store inventory items (medications and supplies)
CREATE TABLE inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,             -- Unique identifier for each item
    item_name VARCHAR(15) NOT NULL,                     -- Name of the item
    item_category ENUM('Medication','Supply') NOT NULL, -- Category of the item
    quantity_available INT NOT NULL,                    -- Quantity available in stock
    unit_price DECIMAL(10,2) NOT NULL                   -- Unit price of the item
);

-- Table to store patient appointments with doctors
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique identifier for each appointment
    patient_id INT NOT NULL,                            -- Patient ID
    doctor_id INT NOT NULL,                             -- Doctor ID
    appointment_date DATE NOT NULL,                     -- Date of the appointment
    appointment_time TIME NOT NULL,                     -- Time of the appointment
    purpose_of_visit TEXT,                              -- Purpose or reason for the visit
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled', -- Status of the appointment
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),              -- Patient foreign key
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)                  -- Doctor foreign key
);

-- Index to optimize searches by item name
CREATE INDEX idx_item_name ON inventory(item_name);

-- Index to optimize searches by item category (Medication/Supply)
CREATE INDEX idx_item_category ON inventory(item_category);
