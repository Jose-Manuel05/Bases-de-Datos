--insert data
use reservation_system;


insert into clients (firstname, lastname, email, phone) values
('john', 'doe', 'johndoe@example.com', '123456789'),
('jane', 'smith', 'janesmith@example.com', '987654321'),
('bob', 'brown', 'bobbrown@example.com', '555666777');

insert into employees (name, specialty, phone, availability) values
('alice', 'hairdresser', '111222333', 'mon-fri'),
('mark', 'massage therapist', '444555666', 'tue-sat'),
('nancy', 'nail technician', '777888999', 'wed-sun');

insert into service_categories (name, description) values
('beauty', 'beauty and personal care services'),
('wellness', 'wellness and relaxation services'),
('fitness', 'fitness and training services');

insert into service (servicesname, description, duration, price, categoryid) values
('haircut', 'basic haircut', 30, 15.00, 1),
('massage', 'relaxing full-body massage', 60, 50.00, 2),
('manicure', 'basic manicure', 45, 25.00, 1);

insert into reservations (reservationdate, reservationtime, clientid, employeeid, status) values
('2024-12-20', '10:00', 1, 1, 'confirmed'),
('2024-12-21', '14:00', 2, 2, 'pending'),
('2024-12-22', '16:30', 3, 3, 'confirmed');

insert into reservation_details (reservationid, serviceid, quantity) values
(1, 1, 1),
(2, 2, 1),
(3, 3, 2);

insert into payments (reservationid, amount, paymentdate, paymentmethod) values
(1, 15.00, '2024-12-20', 'credit card'),
(2, 50.00, '2024-12-21', 'cash'),
(3, 50.00, '2024-12-22', 'credit card');

insert into schedules (employeeid, day, starttime, endtime) values
(1, 'monday', '09:00', '17:00'),
(2, 'tuesday', '10:00', '18:00'),
(3, 'wednesday', '11:00', '19:00');