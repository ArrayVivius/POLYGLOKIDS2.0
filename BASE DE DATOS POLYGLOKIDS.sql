create database POLYGLOKIDS;
USE POLYGLOKIDS;

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY,
    NombreUsuario VARCHAR(100),
    Email VARCHAR(100)
);


CREATE TABLE Lecciones (
    LeccionID INT PRIMARY KEY,
    NombreLeccion VARCHAR(100)
);

CREATE TABLE ProgresoLecciones (
    UsuarioID INT,
    LeccionID INT,
    Puntuacion INT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID)
);


CREATE TABLE Idiomas (
    IdiomaID INT PRIMARY KEY,
    NombreIdioma VARCHAR(50)
);


CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY,
    NombreCurso VARCHAR(100),
    IdiomaID INT,
    FOREIGN KEY (IdiomaID) REFERENCES Idiomas(IdiomaID)
);



CREATE TABLE LeccionesPorCurso (
    CursoID INT,
    LeccionID INT,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID),
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID)
);


CREATE TABLE Maestros (
    MaestroID INT PRIMARY KEY,
    NombreMaestro VARCHAR(100),
    Email VARCHAR(100),
    IdiomaID INT,
    FOREIGN KEY (IdiomaID) REFERENCES Idiomas(IdiomaID)
);


CREATE TABLE Administradores (
    AdminID INT PRIMARY KEY,
    NombreAdmin VARCHAR(100),
    Email VARCHAR(100)
);


CREATE TABLE Calificaciones (
    UsuarioID INT,
    LeccionID INT,
    Calificacion INT,
    Fecha DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID)
);


CREATE TABLE AsignacionesMaestros (
    CursoID INT,
    MaestroID INT,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID),
    FOREIGN KEY (MaestroID) REFERENCES Maestros(MaestroID)
);


CREATE TABLE ComentariosLecciones (
    ComentarioID INT PRIMARY KEY,
    UsuarioID INT,
    LeccionID INT,
    Comentario TEXT,
    Fecha TIMESTAMP,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID)
);


CREATE TABLE MensajesPrivados (
    MensajeID INT PRIMARY KEY,
    EmisorID INT,
    ReceptorID INT,
    Mensaje TEXT,
    Fecha TIMESTAMP,
    FOREIGN KEY (EmisorID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (ReceptorID) REFERENCES Usuarios(UsuarioID)
);


CREATE TABLE InscripcionesCursos (
    InscripcionID INT PRIMARY KEY,
    UsuarioID INT,
    CursoID INT,
    FechaInscripcion DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);


CREATE TABLE EvaluacionesMaestros (
    EvaluacionID INT PRIMARY KEY,
    MaestroID INT,
    UsuarioID INT,
    Puntuacion INT,
    Comentario TEXT,
    Fecha TIMESTAMP,
    FOREIGN KEY (MaestroID) REFERENCES Maestros(MaestroID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);



INSERT INTO Usuarios (UsuarioID, NombreUsuario, Email)
VALUES
(1, 'Usuario1', 'usuario1@example.com'),
(2, 'Usuario2', 'usuario2@example.com'),
(3, 'Usuario3', 'usuario3@example.com');


INSERT INTO Lecciones (LeccionID, NombreLeccion)
VALUES
(1, 'Lección de introducción'),
(2, 'Lección intermedia'),
(3, 'Lección avanzada');

INSERT INTO Idiomas (IdiomaID, NombreIdioma)
VALUES
(1, 'Inglés'),
(2, 'Francés'),
(3, 'Español');

INSERT INTO Cursos (CursoID, NombreCurso, IdiomaID)
VALUES
(1, 'Curso de Inglés Básico', 1),
(2, 'Curso de Francés Intermedio', 2),
(3, 'Curso de Español Avanzado', 3);


INSERT INTO Maestros (MaestroID, NombreMaestro, Email, IdiomaID)
VALUES
(1, 'Maestro1', 'maestro1@example.com', 1),
(2, 'Maestro2', 'maestro2@example.com', 2);


INSERT INTO Administradores (AdminID, NombreAdmin, Email)
VALUES
(1, 'Admin Uno', 'admin1@example.com'),
(2, 'Admin Dos', 'admin2@example.com');

CREATE TABLE NivelesLecciones (
    NivelID INT PRIMARY KEY,
    NombreNivel VARCHAR(50)
);
CREATE TABLE LeccionesNiveles (
    LeccionID INT,
    NivelID INT,
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID),
    FOREIGN KEY (NivelID) REFERENCES NivelesLecciones(NivelID)
);
CREATE TABLE ModulosLecciones (
    ModuloID INT PRIMARY KEY,
    NombreModulo VARCHAR(100),
    LeccionID INT,
    FOREIGN KEY (LeccionID) REFERENCES Lecciones(LeccionID)
);
CREATE TABLE Ejercicios (
    EjercicioID INT PRIMARY KEY,
    NombreEjercicio VARCHAR(100),
    ModuloID INT,
    FOREIGN KEY (ModuloID) REFERENCES ModulosLecciones(ModuloID)
);
CREATE TABLE RespuestasUsuarios (
    RespuestaID INT PRIMARY KEY,
    UsuarioID INT,
    EjercicioID INT,
    Respuesta VARCHAR(255),
    Correcta BOOLEAN,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (EjercicioID) REFERENCES Ejercicios(EjercicioID)
);
CREATE TABLE Certificados (
    CertificadoID INT PRIMARY KEY,
    UsuarioID INT,
    CursoID INT,
    FechaCertificacion DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
CREATE TABLE TemasConversacion (
    TemaID INT PRIMARY KEY,
    NombreTema VARCHAR(100)
);
INSERT INTO TemasConversacion (TemaID, NombreTema)
VALUES
(1, 'Viajes'),
(2, 'Comida y Bebida'),
(3, 'Cultura y Tradiciones');
CREATE TABLE PreguntasRespuestas (
    PreguntaID INT PRIMARY KEY,
    TemaID INT,
    Pregunta TEXT,
    Respuesta TEXT,
    FOREIGN KEY (TemaID) REFERENCES TemasConversacion(TemaID)
);
INSERT INTO PreguntasRespuestas (PreguntaID, TemaID, Pregunta, Respuesta)
VALUES
(1, 1, '¿Cuál es tu lugar de viaje favorito?', 'Mi lugar de viaje favorito es París.'),
(2, 2, '¿Cuál es tu comida favorita?', 'Mi comida favorita es la pizza.'),
(3, 3, '¿Cuál es una tradición cultural interesante?', 'En Japón, es común saludar inclinando la cabeza.');
CREATE TABLE Logros (
    LogroID INT PRIMARY KEY,
    NombreLogro VARCHAR(100)
);
INSERT INTO Logros (LogroID, NombreLogro)
VALUES
(1, 'Primer Curso Completado'),
(2, '1000 Puntos en Ejercicios'),
(3, 'Participación en 10 Conversaciones');
CREATE TABLE UsuariosLogros (
    UsuarioID INT,
    LogroID INT,
    FechaObtencion DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LogroID) REFERENCES Logros(LogroID)
);
INSERT INTO UsuariosLogros (UsuarioID, LogroID, FechaObtencion)
VALUES
(1, 1, '2023-10-10'),
(1, 2, '2023-09-15'),
(2, 3, '2023-10-05');

INSERT INTO InscripcionesCursos (InscripcionID, UsuarioID, CursoID, FechaInscripcion)
VALUES
(1, 1, 1, '2023-10-01'),
(2, 2, 2, '2023-09-28'), 
(3, 1, 3, '2023-10-05'), 
(4, 3, 1, '2023-09-30');


INSERT INTO ProgresoLecciones (UsuarioID, LeccionID, Puntuacion)
VALUES
(1, 1, 85), 
(1, 2, 92), 
(1, 3, 78), 
(2, 1, 90), 
(2, 2, 88), 
(2, 3, 95), 
(3, 1, 79),
(3, 2, 84),
(3, 3, 87);

INSERT INTO LeccionesPorCurso (CursoID, LeccionID) VALUES
(1, 1),
(1, 2),
(2, 3);



SELECT Usuarios.NombreUsuario, Cursos.NombreCurso
FROM Usuarios
JOIN InscripcionesCursos ON Usuarios.UsuarioID = InscripcionesCursos.UsuarioID
JOIN Cursos ON InscripcionesCursos.CursoID = Cursos.CursoID
WHERE Cursos.CursoID = 3;

SELECT Usuarios.NombreUsuario, AVG(ProgresoLecciones.Puntuacion) AS PuntuacionPromedio
FROM Usuarios
LEFT JOIN ProgresoLecciones ON Usuarios.UsuarioID = ProgresoLecciones.UsuarioID
GROUP BY Usuarios.NombreUsuario;

SELECT TemasConversacion.NombreTema, PreguntasRespuestas.Pregunta, PreguntasRespuestas.Respuesta
FROM TemasConversacion
JOIN PreguntasRespuestas ON TemasConversacion.TemaID = PreguntasRespuestas.TemaID
WHERE TemasConversacion.TemaID = 1;

SELECT Cursos.NombreCurso, Lecciones.NombreLeccion
FROM Cursos
JOIN LeccionesPorCurso ON Cursos.CursoID = LeccionesPorCurso.CursoID
JOIN Lecciones ON LeccionesPorCurso.LeccionID = Lecciones.LeccionID
WHERE Cursos.CursoID = 2;


SELECT u.NombreUsuario, c.NombreCurso
FROM Usuarios u
JOIN InscripcionesCursos ic ON u.UsuarioID = ic.UsuarioID
JOIN Cursos c ON ic.CursoID = c.CursoID;

SELECT Usuarios.NombreUsuario, AVG(ProgresoLecciones.Puntuacion) AS PuntuacionPromedio
FROM Usuarios
LEFT JOIN ProgresoLecciones ON Usuarios.UsuarioID = ProgresoLecciones.UsuarioID
GROUP BY Usuarios.NombreUsuario;

SELECT Cursos.NombreCurso, Lecciones.NombreLeccion
FROM Cursos
JOIN LeccionesPorCurso ON Cursos.CursoID = LeccionesPorCurso.CursoID
JOIN Lecciones ON LeccionesPorCurso.LeccionID = Lecciones.LeccionID
WHERE Cursos.CursoID = 2;

SELECT Usuarios.NombreUsuario, Cursos.NombreCurso
FROM Usuarios
JOIN Certificados ON Usuarios.UsuarioID = Certificados.UsuarioID
JOIN Cursos ON Certificados.CursoID = Cursos.CursoID
WHERE Cursos.CursoID = 3;


SELECT COUNT(UsuarioID) AS CantidadUsuarios
FROM Usuarios;

SELECT Usuarios.NombreUsuario, Logros.NombreLogro
FROM Usuarios
JOIN UsuariosLogros ON Usuarios.UsuarioID = UsuariosLogros.UsuarioID
JOIN Logros ON UsuariosLogros.LogroID = Logros.LogroID
WHERE Usuarios.UsuarioID = 1;

SELECT Maestros.NombreMaestro, COUNT(EvaluacionesMaestros.UsuarioID) AS CantidadEvaluaciones
FROM Maestros
LEFT JOIN EvaluacionesMaestros ON Maestros.MaestroID = EvaluacionesMaestros.MaestroID
WHERE Maestros.MaestroID = 1
GROUP BY Maestros.NombreMaestro;

SELECT Usuarios.NombreUsuario, COUNT(MensajesPrivados.MensajeID) AS CantidadMensajes
FROM Usuarios
JOIN MensajesPrivados ON Usuarios.UsuarioID = MensajesPrivados.EmisorID
GROUP BY Usuarios.NombreUsuario;

SELECT Usuarios.NombreUsuario, Lecciones.NombreLeccion, Calificaciones.Calificacion
FROM Usuarios
JOIN Calificaciones ON Usuarios.UsuarioID = Calificaciones.UsuarioID
JOIN Lecciones ON Calificaciones.LeccionID = Lecciones.LeccionID
WHERE Usuarios.UsuarioID = 2;

