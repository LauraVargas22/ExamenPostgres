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

--Prueba
CALL registrar_venta(1, '2025-04-11');
-- Validar que el cliente exista.
CREATE OR REPLACE PROCEDURE validar_cliente(p_cliente_id INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE 
    cliente_id INTEGER;
BEGIN
    SELECT id INTO cliente_id
    FROM cliente
    WHERE id = p_cliente_id;

    IF cliente_id = p_cliente_id THEN
        RAISE NOTICE 'El cliente con el ID % si existe', p_cliente_id;
    ELSE 
        RAISE EXCEPTION 'El cliente con el ID % no existe', p_cliente_id;
    END IF;
END;
$$;

--Prueba
CALL validar_cliente(1);
-- Verificar que el stock sea suficiente antes de procesar la venta. Si no hay stock suficiente, Notificar por medio de un mensaje en consola usando RAISE. Si hay stock, se realiza el registro de la venta.
CREATE OR REPLACE PROCEDURE procesar_venta(p_id_cliente INTEGER, p_fecha_venta DATE, p_id_producto INTEGER, p_cantidad INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    cliente_id INTEGER;
    producto_id INTEGER;
    stock_producto INTEGER;
    venta_id INTEGER;
BEGIN
    SELECT id INTO cliente_id
    FROM cliente
    WHERE id = p_id_cliente;

    SELECT id INTO producto_id
    FROM producto
    WHERE id = p_id_producto;

    IF cliente_id = p_id_cliente AND producto_id = p_id_producto THEN
        SELECT stock INTO stock_producto
        FROM producto
        WHERE id = p_id_producto;

        IF stock_producto >= p_cantidad THEN
            INSERT INTO venta (id_cliente, fecha_venta)
            VALUES (p_id_cliente, p_fecha_venta)
            RETURNING id INTO venta_id;

            INSERT INTO detalle_venta (id_venta, id_producto, cantidad)
            VALUES (venta_id, p_id_producto, p_cantidad);

            UPDATE producto
            SET stock = stock - p_cantidad
            WHERE id = p_id_producto;

            RAISE NOTICE 'Venta % procesada correctamente', venta_id;
        ELSE
            RAISE EXCEPTION 'No contamos con la cantidad de productos requeridos';
        END IF;
    ELSE
        RAISE EXCEPTION 'El ID del cliente y del producto no existen';
    END IF;
END;
$$;

--Venta Correcta
CALL procesar_venta(1, '2025-04-11', 1, 3);

--Validar ID
CALL procesar_venta(1, '2025-04-11', 20, 3);

--Validar Stock
CALL procesar_venta(1, '2025-04-11', 1, 21);


