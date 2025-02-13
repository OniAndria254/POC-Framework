@echo off

if errorlevel 1 (
        pause
        exit /b 1
)
REM Nom de votre application
SET "APP_NAME=Ticketing"

REM Définition des répertoires
SET "TEMP_DIR=temp_%APP_NAME%"
SET "SRC_DIR=C:\e-bossy\S4\Web Dyn\POC\Ticketing\src"
SET "CLASSES_DIR=%TEMP_DIR%\WEB-INF\classes"
SET "VIEWS_DIR=%TEMP_DIR%"
SET "LIB=%TEMP_DIR%\WEB-INF\lib"
SET "WAR_NAME=%APP_NAME%.war"

REM Création du répertoire temporaire
mkdir %TEMP_DIR%
mkdir %TEMP_SRC%

REM Copie des vues
xcopy /s /i web\pages %VIEWS_DIR%

REM Copie des xml
xcopy /s /i xml %TEMP_DIR%\WEB-INF

REM Copie des lib
xcopy /s /i lib %LIB%


xcopy /s /i bin %CLASSES_DIR%
@REM FOR /R "%SRC_DIR%" %%F IN (*.java) DO (
@REM copy "%%F" "%TEMP_SRC%" 
@REM )

@REM cd "%TEMP_SRC%"
@REM javac -parameters -cp "%TEMP_DIR%/WEB-INF/lib.*" -d "%TEMP_DIR%/WEB-INF/classes" -sourcepath "%TEMP_SRC%" *.java

@REM javac -parameters -d %CLASSES_DIR% -sourcepath "%SRC_DIR%\model\*.java" -cp "%TEMP_DIR%/WEB-INF/lib.*"
@REM javac -parameters -d %CLASSES_DIR% -sourcepath "%SRC_DIR%\controller\*.java" -cp "%TEMP_DIR%/WEB-INF/lib.*"

rem Copie les sources dans le tempsrc
for /r "%SRC_DIR%" %%f in (*.java) do copy "%%f" "%TEMP_SRC%" 

rem Compilation de tous les fichiers Java du répertoire tempsrc
javac -parameters -cp "%TEMP_DIR%/WEB-INF/lib/*" -d "%TEMP_DIR%/WEB-INF/classes/" "%TEMP_SRC%\*.java"

REM Création du fichier WAR
cd %TEMP_DIR%
jar -cvf %WAR_NAME% *

REM Déploiement du WAR dans Tomcat (assurez-vous que Tomcat soit en cours d'exécution)
REM Assurez-vous d'ajuster le chemin vers le répertoire webapps de Tomcat
copy %WAR_NAME% "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\%APP_NAME%.war"

REM Redémarrage de Tomcat (facultatif)
REM Assurez-vous d'ajuster le chemin vers les scripts de démarrage de Tomcat
"C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin\shutdown.bat"
"C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin\startup.bat"

REM Nettoyage du répertoire temporaire
cd ..
rmdir /s /q %TEMP_DIR%
