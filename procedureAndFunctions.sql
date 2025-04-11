-- Un procedimiento almacenado para registrar una venta.
CREATE OR REPLACE PROCEDURE registrar_venta (p_id_cliente INTEGER, p_fecha_venta DATE)
LANGUAGE plpgsql
AS $$
BEGIN 
INSERT INTO venta (id_cliente, fecha_venta)
VALUES (p_id_cliente, p_fecha_venta);

RAISE NOTICE 'Venta Registrada';
END;
$$;

CALL registrar_venta(1, '2025-04-11');
-- Validar que el cliente exista.
CREATE OR REPLACE PROCEDURE (p_cliente_id INTEGER)
-- Verificar que el stock sea suficiente antes de procesar la venta.
-- Si no hay stock suficiente, Notificar por medio de un mensaje en consola usando RAISE.
-- Si hay stock, se realiza el registro de la venta.