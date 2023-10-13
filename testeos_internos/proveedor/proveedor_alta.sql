CALL proveedor_alta_sp("Ford", "contacto@ford.com", "42196175", "Alsina", '1220', NULL, "CABA", "Buenos Aires", "Argentina", @nResultado, @cMensaje);
SELECT @nResultado, @cMensaje;

#SELECT * FROM proveedor;