
CREATE TABLE region_sanitaria (
    id_region_sanitaria SERIAL PRIMARY KEY NOT NULL,
    codigo_region_sanitaria INT NOT NULL,
    region_sanitaria_nombre VARCHAR(255) NOT NULL,
    CONSTRAINT unique_region_sanitaria UNIQUE (codigo_region_sanitaria, region_sanitaria_nombre)
);



CREATE TABLE rango_edad_corto (
    id_rango_edad_corto SERIAL PRIMARY KEY NOT NULL,
    edad_min INT NOT NULL,
    edad_max INT NOT NULL,
    CONSTRAINT unique_rango_edad_corto UNIQUE (edad_min,edad_max)
);



CREATE TABLE grupo_atc (
    id_grupo_atc VARCHAR(20) PRIMARY KEY NOT NULL,
    nivel_grupo INT NOT NULL,
    descripcion_grupo VARCHAR(255) NOT NULL,
    id_grupo_atc_padre VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_grupo_atc_padre) REFERENCES grupo_atc(id_grupo_atc),
    CONSTRAINT unique_grupo_atc UNIQUE (id_grupo_atc,nivel_grupo,descripcion_grupo,id_grupo_atc_padre)
);




CREATE TABLE sexo(
    id_sexo SERIAL  PRIMARY KEY NOT NULL,
    sexo_nombre VARCHAR(255) NOT NULL,
    sexo_abreviado VARCHAR(1) NOT NULL,
    CONSTRAINT unique_sexo UNIQUE (sexo_nombre, sexo_abreviado)
);



CREATE TABLE rango_edad_amplio (
    id_rango_edad_amplio SERIAL  PRIMARY KEY NOT NULL,
    edad_min INT NOT NULL,
    edad_max INT NOT NULL,
    CONSTRAINT unique_rango_edad_amplio UNIQUE (edad_min,edad_max)
);

CREATE TABLE mortalidad (
    id_mortalidad SERIAL  PRIMARY KEY NOT NULL,
    fecha DATE NOT NULL,
    id_sexo INT NOT NULL,
    id_rango_edad_amplio INT NOT NULL,
    defunciones_observadas INT NOT NULL,
    defunciones_esperadas DECIMAL(10,2) NOT NULL,
    defunciones_esperadas_limite_inf INT NOT NULL,
    defunciones_esperadas_limite_sup INT NOT NULL,
    CONSTRAINT unique_mortalidad UNIQUE (fecha, id_sexo, id_rango_edad_amplio),
    FOREIGN KEY (id_sexo) REFERENCES sexo(id_sexo),
    FOREIGN KEY (id_rango_edad_amplio) REFERENCES rango_edad_amplio(id_rango_edad_amplio)
);

-- Índices para las claves foráneas
CREATE INDEX idx_mortalidad_sexo ON mortalidad(id_sexo);
CREATE INDEX idx_mortalidad_rango_edad_amplio ON mortalidad(id_rango_edad_amplio);
-- Compuesto: útil para análisis cruzados
CREATE INDEX idx_mortalidad_fecha_sexo ON mortalidad(fecha, id_sexo);
CREATE INDEX idx_mortalidad_fecha_sexo_edad ON mortalidad(fecha, id_sexo, id_rango_edad_amplio);

CREATE TABLE receta (
    id_receta SERIAL PRIMARY KEY NOT NULL ,
    fecha DATE NOT NULL,
    id_region_sanitaria INT NOT NULL,
    id_sexo INT NOT NULL,
    id_rango_edad_corto INT NOT NULL,
    id_grupo_atc VARCHAR(20) NOT NULL,
    numero_receta INT NOT NULL,
    numero_envase INT NOT NULL,
    importe_integro DECIMAL(10,2) NOT NULL,
    importe_aportacion_cat_salut DECIMAL(10,2) NOT NULL,
    CONSTRAINT unique_receta UNIQUE (fecha, id_region_sanitaria, id_sexo, id_rango_edad_corto, id_grupo_atc),
    FOREIGN KEY (id_region_sanitaria) REFERENCES region_sanitaria(id_region_sanitaria),
    FOREIGN KEY (id_sexo) REFERENCES sexo(id_sexo),
    FOREIGN KEY (id_rango_edad_corto) REFERENCES rango_edad_corto(id_rango_edad_corto),
    FOREIGN KEY (id_grupo_atc) REFERENCES grupo_ATC(id_grupo_atc)
);

-- Índices para las claves foráneas
CREATE INDEX idx_receta_region_sanitaria ON receta(id_region_sanitaria);
CREATE INDEX idx_receta_sexo ON receta(id_sexo);
CREATE INDEX idx_receta_rango_edad_corto ON receta(id_rango_edad_corto);
CREATE INDEX idx_receta_grupo_atc ON receta(id_grupo_atc);
-- Compuesto: útil para análisis cruzados
CREATE INDEX idx_receta_fecha_sexo ON receta(fecha, id_sexo);
CREATE INDEX idx_receta_fecha_sexo_edad ON receta(fecha, id_sexo, id_rango_edad_corto);