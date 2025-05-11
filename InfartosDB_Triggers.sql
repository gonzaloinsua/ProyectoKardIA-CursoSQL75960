-- Elijo el Schema sobre el cual trabajar
USE DB_Infartos;

/*
Creación  de trigger (disparador) que se dispone a lanzar un mensaje de alerta si se desea modificar los campos ID_Paciente
y/o ID_Genero en la tabla Dim_Pacientes. Previene modificaciones accidentales o no autorizadas.
**/

DELIMITER //

CREATE TRIGGER trg_PrevenirCambioDatosPaciente
BEFORE UPDATE ON Dim_Pacientes
FOR EACH ROW
BEGIN
    -- Verificar si los campos ID_Paciente o ID_Genero están siendo modificados
    IF OLD.ID_Paciente <> NEW.ID_Paciente OR OLD.ID_Genero <> NEW.ID_Genero THEN
        -- Lanzar un error y prevenir el cambio
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede modificar los campos ID_Paciente e ID_Genero';
    END IF;
END;
//

DELIMITER ;

/*
Creación de trigger (disparador) que se dispone a lanzar un mensaje de alerta si se desea eliminar un paciente
que tiene cargado todos los datos en la BD.
*/

DELIMITER //

CREATE TRIGGER trg_PrevenirBorradoPaciente
BEFORE DELETE ON Dim_Pacientes
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Fact_AnalisisCardiacos
        WHERE ID_Paciente = OLD.ID_Paciente
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un paciente con análisis registrados.';
    END IF;
END;
//

DELIMITER ;

/*
Creación de trigger (disparador) que actúa como barrera protectora a nivel de BD indicando un mensaje de emergencia
hipertensiva cuando se ingresa un valor en el campo PresionArterial que supere los 180mmhg (umbral clínico
considerado potencialmente peligroso)
*/

DELIMITER //

CREATE TRIGGER trg_ValidarPresionAlta
BEFORE INSERT ON Fact_AnalisisCardiacos
FOR EACH ROW
BEGIN
    IF NEW.PresionArterial > 180 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Presión arterial extremadamente alta. Requiere validación médica.';
    END IF;
END;
//

DELIMITER ;
